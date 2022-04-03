//
//  GallaryViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 02.04.2022.
//

import UIKit

class GallaryViewController: UIViewController, ProtocolLikeDelegate {

    
// Для определения направления скрола
    enum DirectionImageState {
        case left, right
    }
   
    @IBOutlet weak var controllForLike: ControlForLike!
    @IBOutlet weak var bottomViewLike: UIView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var labelLikeView: UILabel!
// кнопка комментировать
    @IBOutlet weak var commentImageView: UIImageView!
// кнопка поделится
    @IBOutlet weak var shareImageview: UIImageView!
// view для изображения
    var viewImage: UIView!
// первое изображение
    var currentImageView: UIImageView!
// следующее изображение
    var nextImageView: UIImageView!
// анимация первого изображения
    private var animateImage = UIViewPropertyAnimator()
// анимация второго изображения
    private var nextAnimateImage: UIViewPropertyAnimator?
// массив с фото и лайками!
    var arrayPhoto: [ImageAndLikeData]!
//отображаемое изображение
    var currentImage = 0
// следующее изображение
    var nextImage = 1
// направление сдвига
    var directionOf: DirectionImageState!
// Y позиция для изображений центра view
    var yPos: CGFloat!
    var lastImage: Bool = false
    var frameNextImageForRightSwipe: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.arrayPhoto.count < 2 {
            self.nextImage = 0
            self.lastImage = true
        }
        self.controllForLike.delegate = self
        self.controllForLike.indexPath = IndexPath(row: self.currentImage, section: 0)
        self.setLikeData()
        self.yPos = (self.view.bounds.height / 2)
        setViewAndImagesToView()

    }

    @objc func movementImages(_ position: UIPanGestureRecognizer) {
//Устанавливаем направление движения!
        let positionX = position.translation(in: self.currentImageView).x
// Определяем направление движения!
        if  positionX < 0 {
            self.directionOf = .left
        }else {
            self.directionOf = .right
        }
        switch position.state {
            
        case .possible:
            print("Possible")
        case .began:
            if self.directionOf == .left {
 
                if self.currentImage != (self.arrayPhoto.count - 1) {
// если направление свайпа влево, и это не последнее фото! То используется эта анимация
                    self.animateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut , animations: {
                        self.currentImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    })
                    self.nextAnimateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: {
                        
                        self.nextImageView.transform = CGAffineTransform(translationX: self.view.frame.minX - self.view.frame.maxX, y: self.yPos - self.yPos)
                    })
                    
                    animateImage.addCompletion { [self] position in
                        switch position {
                        case .end:
    // устанавливаем начальные фреймы изображений
                            self.setLikeData()
                            self.viewImage.removeFromSuperview()
                            setViewAndImagesToView()
                        case .start:
                           print("start")
                        case .current:
                            print("current")
                        @unknown default:
                            print("XER")
                        }
                    }
                }else {
    // если направление свайпа влево и это последнее фото то меняем анимацию
                    self.animateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut , animations: {
                        self.currentImageView.transform = CGAffineTransform(translationX: self.view.frame.minX - self.view.frame.maxX, y: self.yPos - self.yPos)
                    })
                }
            }else if self.directionOf == .right && self.currentImage != 0 {
    // если направление свайпа вправо и это не первое изображение
                let x = self.currentImageView.frame.maxX
                
                self.setViewAndImagesToView()
                self.nextImageView.frame = self.frameNextImageForRightSwipe
                let nextImage = self.currentImage - 1
                self.nextImageView.image = self.arrayPhoto[nextImage].image
   // Делаем currentImageViwe поверх nextImageView
                self.viewImage.bringSubviewToFront(self.currentImageView)
                self.nextImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
                
                self.animateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut , animations: {
                        self.currentImageView.transform = CGAffineTransform(translationX: x, y: self.yPos - self.yPos)
                        })
                
                self.nextAnimateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
                    self.nextImageView.transform = CGAffineTransform(scaleX: 10, y: 10)
                 
                })
                
                self.nextAnimateImage!.addCompletion { progress in
                    switch progress {
                        
                    case .end:
                    
                        self.setLikeData()
                        self.viewImage.removeFromSuperview()
                        self.setViewAndImagesToView()
                        if self.currentImage == 0 {
                            self.nextImage = 1
                        }
                        self.setViewAndImagesToView()
                    case .start:

                        print("start Of rightSwipe")
                    case .current:
                        print("current Of rightSwipe")
                    @unknown default:
                        print("Error rightSwipe")
                    }
                }
                
            }else if self.directionOf == .right && self.currentImage == 0 {
    // если направление свайпа вправо и это первое изображение то анимация эта!
                let x = self.currentImageView.frame.maxX
                self.animateImage = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut , animations: {
                    self.currentImageView.transform = CGAffineTransform(translationX: x, y: self.yPos - self.yPos)
                        })
                
            }
//   Вычисление коэффициэнта смещения анимации!!
        case .changed:

            var percent = position.translation(in: self.currentImageView).x
            var toPercent = position.translation(in: self.nextImageView).x
          // переводим минус в плюс
            if percent < 0 {
                percent.negate()
                toPercent.negate()
            }

            switch self.directionOf {
                
            case .left:
                if self.lastImage {
                    toPercent  = toPercent / 2000
                    percent = percent / 200
                }else {
                    percent  = percent / 2000
                    toPercent = toPercent / 200
                }
            case .right:
                if self.currentImage == 0 {
                    toPercent  = toPercent / 2000
                    percent = percent / 200
                }else {
                   
                    toPercent = toPercent / 18
                    percent = percent / 200
                }
            case .none:
                print(".none")
            }
        
            self.animateImage.fractionComplete =  min(1, max(0, percent))
            if self.nextAnimateImage != nil {
                self.nextAnimateImage!.fractionComplete = min(1, max(0, toPercent))
            }
           
            
        case .ended:
            
            let allImage = self.arrayPhoto.count - 1
            
            if directionOf == .right {
// Если изображение перетаскиваем вправо!
                if self.animateImage.fractionComplete > 0.5 && self.currentImage != 0 {

                    if self.lastImage {
                        self.lastImage = false
                        self.currentImage -= 1
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor:  0)
                        self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    }else {
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor:  0)
                        self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                        self.currentImage -= 1
                        self.nextImage -= 1
                    }
                                        
                }else if animateImage.fractionComplete < 0.5 {
                    if self.nextAnimateImage != nil {
                        self.nextAnimateImage!.isReversed = true
                        self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    }
                        self.animateImage.isReversed = true
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    
                }else {
                 
                        self.animateImage.isReversed = true
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    }
                
            }else {
                
// Если изображение перетаскиваем влево и прогресс больше 50% !
                if animateImage.fractionComplete > 0.5 && (self.nextImage != allImage) {
              
                    self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor:  0)
                    self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    self.frameNextImageForRightSwipe = self.currentImageView.frame
                    self.currentImage += 1
                    self.nextImage += 1
               
// Если изображение перетаскиваем влево и прогресс меньше 50% !
                }else if animateImage.fractionComplete < 0.5  {
                    if self.nextAnimateImage != nil {
                    self.nextAnimateImage!.isReversed = true
                    self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    }
                        self.animateImage.isReversed = true
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                  
                }else if self.nextImage == allImage {
// Если изображение перетаскиваем влево и это последнее изображение !
             
                    if self.currentImage != self.nextImage {
                    self.currentImage += 1
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                        self.nextAnimateImage!.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                        self.lastImage = true
                    }else {
                      //  self.nextAnimateImage!.isReversed = true
                        self.animateImage.isReversed = true
                        self.animateImage.continueAnimation(withTimingParameters: nil, durationFactor: 0)
               
                    }
                }
            }
        case .cancelled:
            print("cnaceled")
        case .failed:
            print("Error")
        @unknown default:
            print("Uncnow State")
        }
}

}

//MARK: - Добавляем на экран View на которую добавляем два ImageView
extension GallaryViewController {

   private func setViewAndImagesToView() {

        self.viewImage = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.bounds.height))
        self.viewImage.backgroundColor = UIColor.black
        setImageViewFrame()
        self.currentImageView.image = self.arrayPhoto[self.currentImage].image
        self.nextImageView.image = self.arrayPhoto[self.nextImage].image
        self.viewImage.addSubview(self.currentImageView)
        self.viewImage.addSubview(self.nextImageView)
        self.view.addSubview(self.viewImage)
        
        self.currentImageView.contentMode = .scaleAspectFit
        self.nextImageView.contentMode = .scaleAspectFit
        setConstraintViewImage()
       let pangesture = UIPanGestureRecognizer(target: self, action: #selector(movementImages))
       
       self.viewImage.addGestureRecognizer(pangesture)
    }
    
    private func setConstraintViewImage() {
        self.viewImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.viewImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.viewImage.bottomAnchor.constraint(equalTo: self.bottomViewLike.topAnchor, constant: 0),
            self.view.leadingAnchor.constraint(equalTo: self.viewImage.leadingAnchor, constant: 0),
            self.view.trailingAnchor.constraint(equalTo: self.viewImage.trailingAnchor, constant: 0),
            
        ])
       
    }
    
    private func setImageViewFrame() {
        var ratio = self.arrayPhoto[self.currentImage].image.size.width / UIScreen.main.bounds.width
        var height = self.arrayPhoto[self.currentImage].image.size.height / ratio
        self.currentImageView = UIImageView(frame: CGRect(x: 0, y: self.yPos - (height / 2), width: UIScreen.main.bounds.maxX, height: height))
         ratio = self.arrayPhoto[self.nextImage].image.size.width / UIScreen.main.bounds.width
         height = self.arrayPhoto[self.nextImage].image.size.height / ratio
        self.nextImageView = UIImageView(frame: CGRect(x: self.viewImage.frame.maxX, y: yPos - (height / 2), width: UIScreen.main.bounds.maxX, height: height))
        
    }

    private func setLikeData() {
        if self.arrayPhoto[self.currentImage].likeStatus {
            self.heartImageView.image = UIImage(systemName: "suit.heart.fill")
            self.heartImageView.tintColor = UIColor.red
        }else {
            self.heartImageView.image = UIImage(systemName: "suit.heart")
            self.heartImageView.tintColor = UIColor.systemGray2
        }
        self.labelLikeView.text = String(self.arrayPhoto[self.currentImage].likeLabel)
        self.controllForLike.indexPath = IndexPath(row: self.currentImage, section: 0)
    }
    
    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let like = [self.arrayPhoto[indexPath.row].likeLabel : self.arrayPhoto[indexPath.row].likeStatus]
        return like
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.arrayPhoto[indexPath.row].likeLabel = countLike
        self.arrayPhoto[indexPath.row].likeStatus = likeStatus
        setLikeData()
    }
}

