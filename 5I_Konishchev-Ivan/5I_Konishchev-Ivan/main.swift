//
//  main.swift
//  5I_Konishchev-Ivan
//
//  Created by Ivan Konishchev on 25.01.2022.
//

import Foundation


protocol ActionEngine {
   mutating func StartStop()
}

enum ActionWindows: String {
    case open = "открыты"
    case close = "закрыты"
}

enum StartStopEngine: String, ActionEngine {
    case start = "двигатель запущен"
    case stop = "двигатель остановлен"
    mutating func StartStop() {
        switch self {
        case .start:
            self = .stop
        case .stop:
            self = .start
        }
    }
}


protocol Car {
    var model: String { get  }
    var releaseYear: Int { get  }
    var windowsStatus: ActionWindows { get set }
    var engineStatus: StartStopEngine { get set }
    mutating func startStopEngine()
    mutating func actionWindow(_ action: ActionWindows)
}

extension Car {

   mutating func startStopEngine() {
        self.engineStatus.StartStop()
    }
    mutating func actionWindow(_ action: ActionWindows) {
        self.windowsStatus = action
    }

}

class SportCar: Car {
    
    enum SportCarType: String {
        case racingCar = "гоночный автомобиль"
        case giperCar = "редкий очень быстрый автомобиль"
        case superCar = "серийный очень быстрый автомобиль"
        case sitySportCar = "серийный спортивный автомобиль"
    }
    
    let model: String
    let releaseYear: Int
    var windowsStatus: ActionWindows = .close
    var engineStatus: StartStopEngine = .stop
    var sportCarTypre: SportCarType
    init(model: String, releaseYear: Int, sportCarType: SportCarType){
        self.model = model
        self.releaseYear = releaseYear
        self.sportCarTypre = sportCarType
       
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return
            """
            Модель автомобиля: \(model)
            Год выпуска: \(releaseYear)
            Окна автомобиля \(windowsStatus.rawValue)
            \(engineStatus.rawValue)
            Тип спортивного автомобиля: \(sportCarTypre.rawValue)\n
            """
        
    }
    
    
}
class TrankCar: Car {
    enum TrankCapAction: String{
        case open = "Крышка цистерны открыта"
        case close = "Крышка цистерны закрыта"
    }
    enum TrailerAction: String {
        case unhook = "Цистерна отцеплена"
        case hook = "Цистерна прицеплена"
    }
    var model: String
    var releaseYear: Int
    var windowsStatus: ActionWindows = .close
    var engineStatus: StartStopEngine = .stop
    var trankCapStatus = TrankCapAction .close
    var trailerStatus = TrailerAction.hook
    init(model: String, releaseYear: Int){
        self.model = model
        self.releaseYear = releaseYear
        
    }
}
extension TrankCar: CustomStringConvertible {
    var description: String {
        return """
               Модель автомобиля: \(model)
               Год выпуска: \(releaseYear)
               Окна автомобиля \(windowsStatus.rawValue)
               Двигатель \(engineStatus.rawValue)
               \(trailerStatus.rawValue)
               Статус крышки цистерны: \(trailerStatus == .hook ? trankCapStatus.rawValue: "нет данных, так как цистерна была отцеплена!")
               """
    }
    func trankCapAction(action: TrankCapAction) {
        if trailerStatus == .hook {
        switch action {
        case .open:
            trankCapStatus != .open ? trankCapStatus = action : print("Крышка уже была открыта ранее!")
        case .close:
            trankCapStatus != .close ? trankCapStatus = action : print("Крышка уже была закрыта ранее!")
        }
        }else {
            print("Сначало прицепите цистерну!")
        }
    }
    func trailerAction(action: TrailerAction) {
        switch action {
        case .unhook:
            trailerStatus != .unhook ? trailerStatus = action : print("Цистерна уже была отцеплена ранее!!!")
        case .hook:
            trailerStatus != .hook ? trailerStatus = action : print("Цистерна уже была прицеплена ранее!!!")
        }
    }
    
}
var bugatti = SportCar(model: "Bugatti Veyron 16.4", releaseYear: 2021, sportCarType: .giperCar)
bugatti.engineStatus.StartStop()
bugatti.windowsStatus = .open
print(bugatti)
var mercedesTrank = TrankCar(model: "Mercedes Axor 1840LS", releaseYear: 2012)
mercedesTrank.startStopEngine()
mercedesTrank.actionWindow(.open)
mercedesTrank.trailerAction(action: .unhook)
mercedesTrank.trankCapAction(action: .open)
mercedesTrank.trailerAction(action: .hook)
mercedesTrank.trankCapAction(action: .open)
print(mercedesTrank)
