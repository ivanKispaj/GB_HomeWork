//
//  CastomHorizontalView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.03.2022.
//

import UIKit

class CastomHorizontalView: UICollectionViewLayout {
// delegate для установки лайков и получения размера изображения! в нем два метода
// 1.  setLikeData(numberImage: Int) который передает номер изображения
// 2.  collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, withWidth width: CGFloat) -> CGSize
// который возвращает размер изображения!
    weak var delegate: CastomlayoutDelegate!
// Хранит атрибуты для заданных индексов
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var twocache = [IndexPath: UICollectionViewLayoutAttributes]()
// количество картинок
    var columnsCount: Int? = nil // Количество столбцов
// установим высоту фото с помощью делегата
    var cellHeight: CGFloat? // Высота ячейки
// ширина ячейки = ширине экрана!
    var cellWidth: CGFloat?
    
    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
// хранит ширину всего контента
    var contentWith: CGFloat = 0

   
 // Метод подготовки лайота
    override func prepare() {
       
        self.cacheAttributes = [:] // Инициализируем атрибуты
      
        // Проверяем наличие collectionView
        guard let collectionView = self.collectionView else { return }
        // Проверяем, что в секции есть хотя бы одна ячейка
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
// устанавливаем количество ячеек
        self.columnsCount = itemsCount
        
// отключаем инерцию скрола!!
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0)
// устанавливаем ширину ячейки от ширины экрана
        cellWidth = collectionView.frame.width
// lastX устанавливает последнее положение от последней ячейки
        var lastX: CGFloat = 0
// перебираем секции ...
        for sectionsItem in 0..<collectionView.numberOfSections {
    // перебираем ячейки в секции....
            for index in 0..<collectionView.numberOfItems(inSection: sectionsItem) {
        // создаем indexPath для ячейки
                let indexPath = IndexPath(item: index, section: sectionsItem)
            // Получаем размер изображения с помощью делегата и нашего idexPath
                let imageSize = delegate.collectionView(collectionView, heightForCellAt: indexPath, withWidth: self.cellWidth!)
             // Вычисляем коэффициент пропорций ширина изображения деленная на ширину экрана
                let ratio = imageSize.width / self.cellWidth!
            // Вычисляем высоту ячейки : высота изображения деленная на коэффициэнт
                self.cellHeight = imageSize.height / ratio
        // Вычисляем центр по Y : высота экрана пополам - половину высоты изображения
                let center = CGFloat((collectionView.frame.height / 2) - (cellHeight! / 2))
        // устанавливаем позицию по Y
                let lastY: CGFloat = center
        // устанавливаем атрибуты
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        // устанавливаем frame атрибутов начало Х and Y , высота ячейки и ширина
                attributes.frame = CGRect(x: lastX, y: lastY, width: self.cellWidth!, height: self.cellHeight!)
        // устанавливаем следующую точку по X
                lastX += self.cellWidth!
        // Сохраняем атрибуты к индекс патчу
            cacheAttributes[indexPath] = attributes
               
        }
        // ширина контента будет равна сумме всех изображений!
            self.contentWith = lastX
        // обнуляем позицию по X
            lastX = 0
        }

    }
// не понял на 100 % но скорее всего возбращает атрибуты для элемента...
// Срабатывает при перемещении картинки
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter {
            attributes in return rect.intersects(attributes.frame)}
        
    }
 
// переменная класа, устанавливаем размер контента
    override var collectionViewContentSize: CGSize {
        let width = self.contentWith
        let height = self.totalCellsHeight
    return CGSize(width: width , height: height)

    }

// На сколько понял, если вернуть false то следующий метод не вызывается!
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

// метод который срабатывает при изменении положения контента (скролле )
// дает нам пропорцию на сколько изменилось положение контента по y и x а также
// velocity (ускорение с которым это произошло ( скорость смахивания коэффициент)
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
// запоминаем на сколько сдвинулась картинка по x!
        var currentOffset = proposedContentOffset.x
// переменная для возврата значений положения картинки
        var returns = proposedContentOffset
// размер картинки
        let imageWidht = contentWith / CGFloat(columnsCount!)
// номер текущего изображения
        var curentImage = 0
// В цикле проверяем какая картинк по счету в зависимости от смещения и вычисляем смещение
        while true {
            let target = currentOffset - imageWidht
            if target > 0 {
                curentImage += 1
                currentOffset = target
            } else {
                break
            }
        }
 // если текущая картинка первая индекс 0 и смещение больше 50% изображения то переходим к следующей картинке
        if curentImage == 0 && (currentOffset > (imageWidht / 2)) {
            returns.x = imageWidht
            curentImage += 1
            delegate.setLikeData(numberImage: Int(curentImage))
            return  returns
 // иначе если это первая картинка и смещение меньше 50% то возвращаем первую картинку
        } else if curentImage == 0 && (currentOffset < (imageWidht / 2)) {
            returns.x = 0
            delegate.setLikeData(numberImage: Int(curentImage))
            return  returns
            
        }
// если прошли дальше то следующая картинка
        curentImage += 1
        if currentOffset > (imageWidht / 2) {
          
            returns.x = CGFloat(curentImage) * imageWidht
            
        }else {
            curentImage -= 1
            returns.x = CGFloat(curentImage) * imageWidht
            
        }
        
        delegate.setLikeData(numberImage: Int(curentImage))
        return  returns

    }
    

}


