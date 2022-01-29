//
//  main.swift
//  6I_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.01.2022.
//

import Foundation


enum Color {
    case white,black,blue,red,yellow,green,brown,coral,indigo,beige,lime,orange,azure
}
enum Brand {
    case BMW,Mercedes_Benz,Audi,VW,Ford,Benley,Dodge,KIA,Hiundai, Infiniti,Lamborghini,Land_Rover,Citroen, Alfa_Romeo
}
protocol Car {
    var brend: Brand { get }
    var releaseYear: Int { get }
    var color: Color { get set }
    
 }

class Driver {
    var fullName: String
    var driverCar: Cars?
    init(driverFullName: String, carDriver: Cars?){
        self.fullName = driverFullName
        carDriver?.carDriver = self
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
                Марка автомобиля: \(brend)
                Год выпуска: \(releaseYear)
                Цвет автомобиля: \(color)
                \(engineStatus.rawValue)
                \(windowsStatus.rawValue)
                Водитель автомобиля: \((carDriver != nil) ? (carDriver?.fullName)! : "нет водителя")
                """
     }
     static var stockInSklad = CarSklad<Cars>()
     var brend: Brand
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
         self.brend = brend
         self.releaseYear = releaseYear
         self.color = color
         Cars.stockInSklad.sentToSklad(self)
     }
     deinit {
         print("Автомобиль: \(self.brend) ,год выпуска: \(self.releaseYear), цвет: \(self.color) удален\n")
     }
 
     

 }


struct CarSklad<T: Car> {
    private var carInStock: [T] = []
    
    mutating func sentToSklad (_ car: T){
        carInStock.append(car)
    }
    
     mutating func getCarForColor(_ color: Color) -> [T] {
         let findCar = carInStock.filter{ $0.color == color}
         self.deleteCarInToSklad(car: findCar)
        return findCar
     
    }
    
     mutating func getCarForBrend(_ brend: Brand) -> [T] {
         let findCar = carInStock.filter{ $0.brend == brend}
         self.deleteCarInToSklad(car: findCar)
        return findCar
    }
    
    func getCountInSklad() -> Int {
        return carInStock.count
     }
    
    mutating func deleteCarInToSklad(car: [T] ) {
        for value in car {
            let index = self.carInStock.firstIndex(where: { $0.brend  == value.brend })
            self.carInStock.remove(at: index!)
        }
        
    }

     subscript(_ index: Int) -> [T]? {
         var returnFind: [T] = []
         guard carInStock.indices.contains(index)  else { print("Не найден автомобиль на складе!\n") ; return nil }
             returnFind.append(carInStock[index])
             return returnFind
             }
    }
Cars(brend: .Alfa_Romeo, releaseYear: 2010, color: .azure)
Cars(brend: .BMW, releaseYear: 2021, color: .indigo)
Cars(brend: .Audi, releaseYear: 2016, color: .beige)
Cars(brend: .Benley, releaseYear: 2012, color: .indigo)
Cars(brend: .Citroen, releaseYear: 2015, color: .indigo)

// Получаем автомобиль со склада по бренду! и делаем с ним что нибудь.
var bmw: Cars?
bmw = Cars.stockInSklad.getCarForBrend(.BMW)[0]
var driver: Driver?
driver = Driver(driverFullName: "Konishchev Ivan", carDriver: bmw)
var audi: Cars?
audi = Cars.stockInSklad.getCarForBrend(.Audi)[0]
audi?.carDriver = driver
audi?.engineStatus.startStopEngine()
audi?.windowsStatus.openCloseWindows()
print(audi!)
driver = nil
print(audi!)

print("Получаем автомобиль со склада по индексу с помощью subscript!\n")
var subscriptCar = Cars.stockInSklad[8]
subscriptCar != nil ? print(subscriptCar!) : print("\n")

 // Получаем все автомобили со склада с цветом .indigo
var allCarFromColor: [Cars]?
allCarFromColor = Cars.stockInSklad.getCarForColor(.indigo)
print("Получаем все автомобили со склада с цветом .indigo\n")
Cars.printCar(allCarFromColor)

allCarFromColor = nil
