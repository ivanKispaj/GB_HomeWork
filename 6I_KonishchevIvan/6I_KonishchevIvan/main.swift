//
//  main.swift
//  6I_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.01.2022.
//

import Foundation


enum ErrorCarShipFromSklad: Error {
    case carNotFound
    case findMoreOneCar
}

enum Color {
    case white,black,blue,red,yellow,green,brown,coral,indigo,beige,lime,orange,azure
}
enum Brand {
    case BMW,Mercedes_Benz,Audi,VW,Ford,Benley,Dodge,KIA,Hiundai, Infiniti,Lamborghini,Land_Rover,Citroen, Alfa_Romeo
}
protocol Car {
    var brand: Brand { get }
    var releaseYear: Int { get }
    var color: Color { get set }
    
 }

class Driver {
    var fullName: String
    var driverCar: Cars?
    init(driverFullName: String){
        self.fullName = driverFullName
    }
    deinit {
        print("Водитель: \(self.fullName) , удален\n")
    }
}
 class Cars: Car, CustomStringConvertible {
 
     enum WindowsAction: String {
         case open = "окна открыты"
         case close = "окна закрыты"
         mutating func openCloseWindows(){
             switch self {
             case .open:
                 self = .close
             case .close:
                 self = .open
             }
         }
     }
     
     enum EngineAction: String {
         case start = "двигатель запущен"
         case stop = "двигатель заглушен"
         mutating func startStopEngine(){
             switch self {
             case .start:
                 self = .stop
             case .stop:
                 self = .start
             }
         }
     }
     
     var description: String {
         return """
                Марка автомобиля: \(brand)
                Год выпуска: \(releaseYear)
                Цвет автомобиля: \(color)
                \(engineStatus.rawValue)
                \(windowsStatus.rawValue)
                Водитель автомобиля: \((carDriver != nil) ? (carDriver?.fullName)! : "нет водителя")
                """
     }
     static var stockInSklad = CarSklad<Cars>()
     var brand: Brand
     var releaseYear: Int
     var color: Color
     weak var carDriver: Driver?
     var engineStatus: EngineAction = .stop
     var windowsStatus: WindowsAction = .close
     
     static func printCar(_ carIn: [Cars]?){
         guard carIn != nil else {return}
         for cars in carIn! {
             print(cars)
             print("\n")
         }
     }
     
     init(brend: Brand, releaseYear: Int, color: Color){
         self.brand = brend
         self.releaseYear = releaseYear
         self.color = color
         Cars.stockInSklad.sentToSklad(self)
     }
     deinit {
         print("Автомобиль: \(self.brand) ,год выпуска: \(self.releaseYear), цвет: \(self.color) удален\n")
     }
 
     

 }


struct CarSklad<T: Car> {
    private var carInStock: [T] = []
    
    mutating func sentToSklad (_ car: T){
        carInStock.append(car)
    }
    
    mutating func getFullSearchCar(brand: Brand, releaseYear: Int, color: Color ) throws -> T {
        var findCar = carInStock.filter{ $0.brand == brand }
        guard findCar.count != 0 else { throw ErrorCarShipFromSklad.carNotFound }
        findCar = findCar.filter{ $0.color == color}
        guard findCar.count != 0 else { throw ErrorCarShipFromSklad.carNotFound }
        findCar = findCar.filter{ $0.releaseYear == releaseYear }
        let index = self.carInStock.firstIndex(where: { $0.brand  == brand })
        guard findCar.count != 0 else { throw ErrorCarShipFromSklad.carNotFound }
        let  findOneCar = self.carInStock.remove(at: index!)
        return findOneCar
    }
    
    mutating func getCarFromColor(_ color: Color) throws  -> [T] {
         let findCar = carInStock.filter{ $0.color == color}
         guard findCar.count != 0 else { throw ErrorCarShipFromSklad.carNotFound }
         let carForDelivery = self.getCarFromSklad(car: findCar, color, nil)
        return carForDelivery!
     
    }
    
    mutating func getCarForBrend(_ brand: Brand) throws -> [T]? {
         let findCar = carInStock.filter{ $0.brand == brand}
         guard findCar.count != 0 else { throw ErrorCarShipFromSklad.carNotFound }
         guard findCar.count < 2 else { throw ErrorCarShipFromSklad.findMoreOneCar}
         let carForDelivery = self.getCarFromSklad(car: findCar, nil, brand)
        return carForDelivery
    }
    
    func getCountInSklad() -> String {
        return "Всего автомобилей на складе: \(carInStock.count)"
     }
    
    mutating private func getCarFromSklad(car: [T],_ type: Color?,_ typetwo: Brand? ) -> [T]? {
        var carForDelivery: [T] = []
        for value in car {
            if type != nil {
                let index = self.carInStock.firstIndex(where: { $0.color  == value.color })
                carForDelivery.append(self.carInStock.remove(at: index!))
            }else if typetwo != nil {
                let index = self.carInStock.firstIndex(where: { $0.brand  == value.brand })
                carForDelivery.append(self.carInStock.remove(at: index!))
            }
         
        }
        return carForDelivery
    }

    subscript(_ index: Int) -> [T]? {
         var returnFind: [T] = []
         guard carInStock.indices.contains(index)  else { print("Не найден автомобиль на складе!\n") ; return nil }
             returnFind.append(carInStock[index])
             return returnFind
             }
    }
// В расширении добавляем водителя к автомобилю, и автомобиль к водителю
extension Cars {
    func setCarDriver (driver: Driver) {
        self.carDriver = driver
        driver.driverCar = self
    }
}

// Создаем автомобили и они автоматически помещаются на склад!
Cars(brend: .Alfa_Romeo, releaseYear: 2010, color: .azure)
Cars(brend: .BMW, releaseYear: 2021, color: .indigo)
Cars(brend: .BMW, releaseYear: 2021, color: .indigo)
Cars(brend: .Lamborghini, releaseYear: 2016, color: .beige)
Cars(brend: .Audi, releaseYear: 2012, color: .indigo)
Cars(brend: .Citroen, releaseYear: 2015, color: .indigo)

var driver: Driver? = Driver(driverFullName: "Konishchev Ivan")
print(Cars.stockInSklad.getCountInSklad())

do {
    var bmw: Cars? = try Cars.stockInSklad.getFullSearchCar(brand: .BMW, releaseYear: 2021, color: .indigo)
    bmw?.setCarDriver(driver: driver!)
    bmw?.engineStatus.startStopEngine()
    bmw?.windowsStatus.openCloseWindows()
    print(bmw!)
    print("\nВодитель:\((driver?.fullName)!)\nуправляет атомобилем: \((bmw?.brand)!)" )
    driver = nil
    print(bmw!)
    bmw = nil
    
} catch let error {
    print("Ошибка: автомобиль такой марки - \(error)")
}

driver = Driver(driverFullName: "Myster Pupkin")
print(Cars.stockInSklad.getCountInSklad())
do {
    var audi: [Cars]? = try Cars.stockInSklad.getCarForBrend(.Audi)
    audi?[0].setCarDriver(driver: driver!)
    audi?[0].engineStatus.startStopEngine()
    audi?[0].windowsStatus.openCloseWindows()
    print(audi!)
    print("\nВодитель:\((driver?.fullName)!)\n управляет атомобилем:\((audi?[0].brand)!)" )
    driver = nil
    print(audi!)
    audi = nil
    
} catch let error {
    if error as! ErrorCarShipFromSklad == ErrorCarShipFromSklad.findMoreOneCar {
        print("\nНайдено более одного автомобиля!\nВоспользуетесь расширенным поиском!\n")
    }else {
    print("Такой автомобиль не найден! Error: \(error)")
    }
}

print(Cars.stockInSklad.getCountInSklad())

print("Получаем автомобиль со склада по индексу с помощью subscript!\n")
var subscriptCar = Cars.stockInSklad[8]
subscriptCar != nil ? print(subscriptCar!) : print("\n")

 // Получаем все автомобили со склада с цветом .indigo

var allCarFromColor: [Cars]?
do {
    allCarFromColor = try Cars.stockInSklad.getCarFromColor(.indigo)
print("Получаем все автомобили со склада с определенным цветом \n")
Cars.printCar(allCarFromColor)
} catch let error {
    print("Такой автомобиль не найден! Error: \(error)")
}

allCarFromColor = nil
print(Cars.stockInSklad.getCountInSklad())


