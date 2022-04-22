//
//  DataController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.03.2022.
//
// Убирается после настройки api VK
import UIKit

class DataController {
    static var shared = DataController()
 
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

}


