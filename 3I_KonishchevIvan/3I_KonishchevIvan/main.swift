//
//  main.swift
//  3I_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.01.2022.
//
//Test
import Foundation

enum OpenClose {
    case open, close
}
enum EngineState {
    case stop, running
}
enum TrunkState {
    case load( count: Int)
    case unload( count: Int)
}
enum TrunkData {
    case trunkSize
    case trunkLoadSize
    case trunkFreeSpace
}

struct HeavyTruck{
    let model: String
    let releaseYear: Int
    private let capacity: Int
    var engineStatus: EngineState
    var doorsCaro: OpenClose {
        willSet {
            switch doorsCaro {
            case .open:
                newValue == .open ? print("Двери кузова уже были открыты!") : print("Двери кузова закрываются.")
            case .close:
                newValue == .close ? print("Двери кузова уже были закрыты!") : print("Двери кузова открываются.")
            }
        }
    }
    private var trunkLoad: Int
    private var trunkFreeSpace: Int {
        get{
            return capacity - trunkLoad
        }
    }
    init(Model: String, ReleaseYear: Int, capacity: Int, EngineStatus: EngineState, DoorsCaro: OpenClose) {
        self.model = Model
        self.releaseYear = ReleaseYear
        self.capacity = capacity
        self.engineStatus = EngineStatus
        self.doorsCaro = DoorsCaro
        self.trunkLoad = 0
    }

    func getCapacityData(capacityData: TrunkData) -> (String) {
        switch capacityData {
        case .trunkSize:
            return "Объем кузова \(capacity)"
        case .trunkLoadSize:
            return "В кузов загружено \(trunkLoad)"
        case .trunkFreeSpace:
            return "В кузове свободно \(trunkFreeSpace)"
        }
    }
    mutating func startStopEngin(operation: EngineState) -> (String){
        switch operation {
        case .stop:
            if engineStatus == .stop {
                return "Ваш двигатель на данный момент и так заглушен!"
            }else {
                self.engineStatus = .stop
                return "Двигатель заглушен!"
            }
        case .running:
            if engineStatus == .running {
                return "Ваш двигатель уже был запущен!"
            }else {
                self.engineStatus = .running
                return "Двигатель запущен!"
            }
        }
    }
    
    mutating func trunkAction(trunkState: TrunkState){
        if doorsCaro == .open {
            switch trunkState {
            case .load( count: let count):
                if trunkFreeSpace > count {
                    trunkLoad = trunkLoad + count
                }else if trunkFreeSpace == count {
                    trunkLoad = trunkLoad + count
                    print("Кузов заполнен полностью!")
                }else {
                    print("В кузов не влезает : \( count - trunkFreeSpace) ")
                }
            case .unload( count: let count):
                if trunkLoad > count {
                    trunkLoad = trunkLoad - count
                }else {
                    print("В кузове всего: \(trunkLoad), вы пытаетесь выгрузить: \(count)")
                }
            }
        }else {
            print("Сначало откройте двери для погрузки!")
        }
    }
}

struct SportCar {
    let model: String
    let releaseYear: Int
    private var trunkSize: Int
    var engineStatus: EngineState {
        willSet {
            switch engineStatus {
            case .stop:
                newValue == .stop ? print("Двигатель уже был заглушен") : print("Двигатель запущен")
            case .running:
                newValue == .running ? print("Двигатель уже был запущен") : print("Двигатель остановлен")
            }
        }
    }
    var windowsStatus: OpenClose {
        willSet {
            switch windowsStatus {
            case .open:
                newValue == .open ? print("Окна автомобиля уже были открыты!") : print("Окна автомобиля закрываются")
            case .close:
                newValue == .close ? print("Окна автомобиля уже были закрыты!") : print("Окна открываются!")
            }
        }
    }
    private var trunkLoadSize: Int
    private var trunkFreeSpace: Int {
        get {
           return trunkSize - trunkLoadSize
        }
    }
    
    init(){
        model = "Lambprghini Aventador"
        releaseYear = 2017
        trunkSize = 300
        engineStatus = .stop
        windowsStatus = .close
        trunkLoadSize = 0
        
    }
    
    init(Model: String, ReleaseYear: Int, TrunkSize: Int, EngineStatus: EngineState, WindowsState: OpenClose) {
        self.model = Model
        self.releaseYear = ReleaseYear
        self.trunkSize = TrunkSize
        self.engineStatus = EngineStatus
        self.windowsStatus = WindowsState
        self.trunkLoadSize = 0
       
    }

    func getTrunkData(trunkData: TrunkData) -> (Int) {
        switch trunkData {
        case .trunkSize:
            return trunkSize
        case .trunkLoadSize:
            return trunkLoadSize
        case .trunkFreeSpace:
            return trunkFreeSpace
        }
    }

    mutating func trunkAction(trunkState: TrunkState){
        switch trunkState {
        case .load( count: let count):
            if trunkFreeSpace > count {
                trunkLoadSize = trunkLoadSize + count
                print("В багажник погружено: \(count)")
            }else if trunkFreeSpace == count {
                trunkLoadSize = trunkLoadSize + count
                print("Багажник заполнен полностью!")
            }else {
                print("В багажник не влезает : \( count - trunkFreeSpace) ")
            }
        case .unload( count: let count):
            if trunkLoadSize > count {
                trunkLoadSize = trunkLoadSize - count
                print("Из багажника выгружено: \(count)")
            }else {
                print("В багажнике всего: \(trunkLoadSize), вы пытаетесь выгрузить: \(count)")
            }
        }
    }
    
    
}

var  audiRs = SportCar(Model: "Audi RS6", ReleaseYear: 2016, TrunkSize: 450, EngineStatus: .stop, WindowsState: .close)
var lamborghini = SportCar(Model: "Lamborghini Aventador", ReleaseYear: 2018, TrunkSize: 380, EngineStatus: .stop, WindowsState: .open)
print(audiRs.model)
print(audiRs.releaseYear)
audiRs.windowsStatus = .open
audiRs.trunkAction(trunkState: .load(count: 185)) // Погрузка в багажник
print("Свободное место в багажнике: \(audiRs.getTrunkData(trunkData: .trunkFreeSpace))")
print("Занятое место в багажнике: \(audiRs.getTrunkData(trunkData: .trunkLoadSize))")
audiRs.windowsStatus = .close
audiRs.trunkAction(trunkState: .unload(count: 200))
audiRs.engineStatus = .running

print("\n")
print(lamborghini.model)
lamborghini.trunkAction(trunkState: .load(count: 380))
print("Свободное место в багажнике: \(lamborghini.getTrunkData(trunkData: .trunkFreeSpace))")
lamborghini.windowsStatus = .open
lamborghini.trunkAction(trunkState: .unload(count: 120))
lamborghini.engineStatus = .running
lamborghini.engineStatus = .running


print("\n")

var scania = HeavyTruck(Model: "Scania P Series", ReleaseYear: 2011, capacity: 20000, EngineStatus: .stop, DoorsCaro: .close)
print(scania.model)
//print(scania.cargoDoors(operation: .open))
scania.doorsCaro = .open
scania.trunkAction(trunkState: .load(count: 11800))
print(scania.getCapacityData(capacityData: .trunkLoadSize))
print(scania.getCapacityData(capacityData: .trunkFreeSpace))
scania.doorsCaro = .close
print(scania.startStopEngin(operation: .running))



