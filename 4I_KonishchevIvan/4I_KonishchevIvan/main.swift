//
//  main.swift
//  4I_Konishchev_Ivan
//
//  Created by Ivan Konishchev on 23.01.2022.
//

import Foundation

class Car {
    enum EngineType : String {
        case petrol = "бензиновый двигатель"
        case diesel = "дизельный двигатель"
        case electro = "электрический двигатель"
    }
    enum WindowsControl: String {
        case open = "Открыты"
        case close = "Закрыты"
    }
    enum EngineControl: String {
        case stop = "Двигатель заглушен"
        case running = "Двигатель запущен"
    }
    let model: String
    let reliaseYear: Int
    var engineStatus: EngineControl
    var windowStatus: WindowsControl
    private var engineType: String = ""
    init(model: String, reliaseYear: Int) {
        self.model = model
        self.reliaseYear = reliaseYear
        self.engineStatus = .stop
        self.windowStatus = .close
       // self.setEngineType(engineType: .petrol)
    }

    func setEngineType(engineType: EngineType) {
        self.engineType = ""
    }
    func getEngineType () -> String {
        return engineType
    }
    func engineStart() {
        engineStatus != .running ? engineStatus = .running : print("Двигатель уже был запущен!!!")
    }
    func engineStop() {
        engineStatus != .stop ? engineStatus = .stop : print("Двигатель уже был заглушен!!!")
    }
}

 //SportCar вывод сделал через CustomStringConvertible

class SportCar: Car, CustomStringConvertible {

    enum BodyType: String {
        case coupe = "купе"
        case convertible = "кабриолет"
    }

    var bodyType: BodyType
    var wheelSize: Int
    private var sportEngineType: String
    var description: String {
        return """
            Модель автомобиля: \(model)\n
            Год выпуска: \(reliaseYear)\n
            Тип кузова: \(bodyType.rawValue)\n
            Размер колес: \(wheelSize) дюймов \n
            Окна: \(windowStatus.rawValue)\n
            Статус двигателя: \(engineStatus.rawValue)\n
            Тип двигателя: \(getEngineType())\n
            """
    }

    init(model: String, releaseYear: Int, bodyType: BodyType, wheelSize: Int,engineType: EngineType){
        self.bodyType = bodyType
        self.wheelSize = wheelSize
        self.sportEngineType = engineType.rawValue
        super.init(model: model, reliaseYear: releaseYear)
    }
    
    override func setEngineType(engineType: Car.EngineType) {
        sportEngineType = engineType.rawValue
    }
    override func getEngineType() -> String {
        return sportEngineType
    }
}

class TruckCar: Car {
    enum EngineType: String {
        case disel = "дизельный двигатель"

    }
    
    enum TrunkState {
        case load( count: Int)
        case unload( count: Int)
    }

    
    var bodyCapacity: Int
    var doorsCargo: WindowsControl{
        willSet{
            switch doorsCargo {
            case .open:
                newValue == .open ? print("Двери кузова уже открыты, можете загрузить груз") : print("Двери кузова закрываются! Погрузка будет невозможна!")
            case .close:
                newValue == . close ? print("Двери кузова уже закрыты!!!") : print("Двери кузова открываются! Возможна погрузка.")
            }
        }
    }
    var trunkLoad: Int
    var trunkFreeSpace: Int {
        get {
            return bodyCapacity - trunkLoad
        }
    }
    init(model: String, releaseYear: Int, bodyCapacity: Int ){
        self.bodyCapacity =  bodyCapacity
        self.doorsCargo = .close
        self.trunkLoad = 0
        super.init(model: model, reliaseYear: releaseYear)
       
        
    }

    func trunkAction(_ trunkAction: TrunkState) {
        if doorsCargo == .open {
            switch trunkAction{
            case .load(count: let count):
                if trunkFreeSpace > count {
                    trunkLoad = trunkLoad + count
                    print("Погружено: \(count)")
                }else if trunkFreeSpace == count {
                    trunkLoad = count
                }else {
                    print("В кузов не поместится :\(count - trunkFreeSpace)")
                }
            case .unload(count: let count):
                if trunkLoad > count {
                    trunkLoad = trunkLoad - count
                    print("Выгружено: \(count)")
                }else if trunkLoad == count {
                    trunkLoad = 0
                    print("Кузов свободен! Выгружено: \(count)")
                }else {
                    print("Вы пытаетесь выгрузить груза больше чем есть в кузове! \n В кузове всего: \(trunkLoad)")
                }
            }
        }else {
            print("Откройте двери кузова для погрузки!")
        }
    }
}
var ferrary = SportCar(model: "Ferrary", releaseYear: 2018, bodyType: .coupe, wheelSize: 20, engineType: .electro)

var scania = TruckCar(model: "Scania", releaseYear: 2012, bodyCapacity: 25000)

print("Модель автомобиля: \(scania.model)")
print("Год выпуска: \(scania.reliaseYear)")
print("Объем кузова: \(scania.trunkFreeSpace)")
scania.doorsCargo = .open
scania.trunkAction(.load(count: 16100))
print("Свободное место в кузове: \(scania.trunkFreeSpace)")
print("В кузове загружено: \(scania.trunkLoad)")
scania.doorsCargo = .close
scania.engineStart()
print(scania.engineStatus.rawValue)
print("\n")
print(ferrary)
ferrary.setEngineType(engineType: .petrol)
ferrary.bodyType = .convertible
ferrary.wheelSize = 22
ferrary.engineStatus = .running
print(ferrary)
