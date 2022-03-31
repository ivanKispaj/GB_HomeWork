//
//  DataController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.03.2022.
//

import UIKit

class DataController {
    static var shared = DataController()
    
    func getDataUser() -> [Friends] {
        let dataUser = [
            Friends(image: UIImage.init(named: "Putin"), name: "Путин Владимир Владимирович", city: "Москва", details: "Президент российской Федерации", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "Bregnev"), friendsName: "Брежнев Леонид Ильич"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "карандаш"),
                HisFirends(friendsAvatar: UIImage(named: "Stalin"), friendsName: "Сталин Иосив Вессарионович"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "ктото"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "Bregnev"), name: "Брежнев Леонид Ильич", city: "Москва", details: "Председатель президиума Верховного совета СССР", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "FranclinRuzvelt"), name: "Франклин Рузвельт", city: "NewYork", details: "32 Президент США", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "MaoCzydun"), name: "Мао Дзядун", city: "Хуань", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "MargaretTetcher"), name: "Маргарет Тетчер", city: "London", details: "Премьер министр Великобритании", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "Merkel"), name: "Ангела Меркель", city: "Германия", details: "Федеральный канцлер Германии",hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]
                   ),
            Friends(image: UIImage.init(named: "MohandasGandi"), name: "Мохандос Ганди", city: "Порбандаре", hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "Stalin"), name: "Сталин Иосиф Виссарионович", city: "Москва",hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
            Friends(image: UIImage.init(named: "WinstonCherchil"), name: "Винстон Черчиль", city: "Великобритания",hisFriends: [
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг"),
                HisFirends(friendsAvatar: UIImage(named: "noFoto"), friendsName: "Какойто друг")
            ]),
        ]
        return dataUser
    }
    
     func getdataGroup() -> [AllUserGroups] {
        let dataGroup = [
            AllUserGroups(nameGroup: "Баскетбол", logoGroup: UIImage.init(named: "Basketball")),
            AllUserGroups(nameGroup: "Стрельба из лука", logoGroup: UIImage.init(named: "BowShooting")),
            AllUserGroups(nameGroup: "Бальные танцы", logoGroup: UIImage.init(named: "Dances")),
            AllUserGroups(nameGroup: "Фехтование", logoGroup: UIImage.init(named: "Fencing")),
            AllUserGroups(nameGroup: "Футбол", logoGroup: UIImage.init(named: "Football")),
            AllUserGroups(nameGroup: "Художественная гимнастика", logoGroup: UIImage.init(named: "gymnastic")),
            AllUserGroups(nameGroup: "Тяжелая атлетика", logoGroup: UIImage.init(named: "HardAttletic")),
            AllUserGroups(nameGroup: "Хоккей", logoGroup: UIImage.init(named: "Hockey")),
            AllUserGroups(nameGroup: "Прыжки в воду", logoGroup: UIImage.init(named: "jumpWather")),
            AllUserGroups(nameGroup: "Боевые искуства", logoGroup: UIImage.init(named: "karate")),
            AllUserGroups(nameGroup: "Бег", logoGroup: UIImage.init(named: "Run")),
            AllUserGroups(nameGroup: "Теннис", logoGroup: UIImage.init(named: "Tennis")),
            AllUserGroups(nameGroup: "Велогонки", logoGroup: UIImage.init(named: "Velo")),
            AllUserGroups(nameGroup: "Волейбол", logoGroup: UIImage.init(named: "Volleyball"))
        ]
        return dataGroup
    }
    
    func getDataNews() -> [NewsData] {
        let news = [NewsData(cellType: .textWithimage, newsText: "Правительство РФ будет внимательно смотреть за ситуацией с ценами и в текущих условиях не даст пенсионеров в обиду. Об этом 13 марта сообщил министр финансов РФ Антон Силуанов.", newsImage: ImageAndLikeData(image: UIImage(named: "Siluvanov")!, likeStatus: false, likeLabel: 19)),
                    NewsData(cellType: .textWithTextView, newsText: "Можно ли считать прекращение поставок продукции Apple действием санкций, приедут ли в Россию мартовские новинки, стоит ли скупать доступные в магазинах продукты и как выглядит худший сценарий развития событий?", newsImage: ImageAndLikeData(image: UIImage(named: "appleNews")!, likeStatus: true, likeLabel: 64))
                    ]
        return news
    }
    
    func getSinglePhoto () -> ImageAndLikeData {
        let dataPhoto: ImageAndLikeData = ImageAndLikeData(image: UIImage(named: "appleNews")!, likeStatus: true, likeLabel: 76)
        return dataPhoto
    }
    
    func getPhoto() -> [ImageAndLikeData] {
        var dataPhoto:[ImageAndLikeData] = [ImageAndLikeData(image:
                                                                UIImage(named: "onePhoto")!
        , likeStatus: false, likeLabel: 12),
       
        ]
        
        dataPhoto.append(ImageAndLikeData(image: UIImage(named: "twoPhoto")!, likeStatus: false, likeLabel: 54))
        dataPhoto.append(ImageAndLikeData(image: UIImage(named: "threePhoto")!, likeStatus: true, likeLabel: 14))
        dataPhoto.append(ImageAndLikeData(image: UIImage(named: "fourPhoto")!, likeStatus: false, likeLabel: 31))
        dataPhoto.append(ImageAndLikeData(image: UIImage(named: "appleNews")!, likeStatus: false, likeLabel: 45))
        return dataPhoto
    }
}

