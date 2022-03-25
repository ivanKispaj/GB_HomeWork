//
//  CastomHorizontalView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.03.2022.
//

import UIKit

protocol CastomlayoutDelegate: AnyObject {
    func setLikeData(numberImage: Int)
    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, withWidth width: CGFloat) -> CGSize
}

class CastomHorizontalView: UICollectionViewLayout {
    
    weak var delegate: CastomlayoutDelegate!
// Хранит атрибуты для заданных индексов
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
// количество картинок
    var columnsCount: Int? = nil // Количество столбцов
// установим высоту фото с помощью делегата
    var cellHeight: CGFloat? // Высота ячейки
// ширина ячейки = ширине экрана!
    var cellWidth: CGFloat?
    
    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
 //   let layout = self
    var contentWith: CGFloat = 0
  //  var onlineContent: CGFloat = 0
   
    
    override func prepare() {
       
        self.cacheAttributes = [:] // Инициализируем атрибуты
        // Проверяем наличие collectionView
        guard let collectionView = self.collectionView else { return }
        // Проверяем, что в секции есть хотя бы одна ячейка
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        self.columnsCount = itemsCount
        
        // отключаем инерцию скрола!!
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0)
       
        cellWidth = collectionView.frame.width
        var lastX: CGFloat = 0
        
        for sectionsItem in 0..<collectionView.numberOfSections {
            for index in 0..<collectionView.numberOfItems(inSection: sectionsItem) {

                let indexPath = IndexPath(item: index, section: sectionsItem)
                let imageSize = delegate.collectionView(collectionView, heightForCellAt: indexPath, withWidth: self.cellWidth!)
                
                let ratio = imageSize.width / self.cellWidth!
                self.cellHeight = imageSize.height / ratio
                let center = CGFloat((collectionView.frame.height / 2) - (cellHeight! / 2))
                let lastY: CGFloat = center
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: lastX, y: lastY, width: self.cellWidth!, height: self.cellHeight!)
                lastX += self.cellWidth!
                
            cacheAttributes[indexPath] = attributes
        }
            self.contentWith = lastX
            lastX = 0
        }

    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter {
           attributes in return rect.intersects(attributes.frame)
        }
    }
   
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        let width = self.contentWith
        let height = self.totalCellsHeight
    return CGSize(width: width , height: height)

    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
   
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
// запоминаем на сколько сдвинулась картинка!
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
        
        if curentImage == 0 && (currentOffset > (imageWidht / 2)) {
            returns.x = imageWidht
            curentImage += 1
            delegate.setLikeData(numberImage: Int(curentImage))
            return  returns
            
        } else if curentImage == 0 && (currentOffset < (imageWidht / 2)) {
            returns.x = 0
            delegate.setLikeData(numberImage: Int(curentImage))
            return  returns
            
        }
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


