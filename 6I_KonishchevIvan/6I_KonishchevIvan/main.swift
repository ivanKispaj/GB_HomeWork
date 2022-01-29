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
               """
    }
    static var stockInSklad = CarSklad<Cars>()
    var brend: Brand
    var releaseYear: Int
    var color: Color
    var engineStatus: EngineAction = .stop
    var windowsStatus: WindowsAction = .close
    init(brend: Brand, releaseYear: Int, color: Color){
        self.brend = brend
        self.releaseYear = releaseYear
        self.color = color
        Cars.stockInSklad.sentToSklad(self)
    }
    static func printCar(_ carIn: [Cars]?){
        guard carIn != nil else {return}
        for cars in carIn! {
            print(cars)
            print("\n")
        }
    }

}


struct CarSklad<T: Car> {
    private var carInStock: [T] = []
    
    mutating func sentToSklad (_ car: T){
        carInStock.append(car)
    }
    func getCarForColor(_ color: Color) -> [T] {
        return carInStock.filter{ $0.color == color}
    }
    func getCarForBrend(_ brend: Brand) -> [T] {
        return carInStock.filter{ $0.brend == brend}
    }
    func getCountInSklad() -> Int {
        return carInStock.count
    }
    subscript(_ index: Int) -> [T]? {
        var returnFind: [T] = []
        guard carInStock.indices.contains(index)  else { print("Не найден автомобиль на складе!\n") ; return nil }
        returnFind.append(carInStock[index])
        return returnFind
        }
}

var alfa = Cars(brend: .Alfa_Romeo, releaseYear: 2010, color: .azure)
let bmw = Cars(brend: .BMW, releaseYear: 2021, color: .indigo)
let mercedes = Cars(brend: .Mercedes_Benz, releaseYear: 2018, color: .white)
let audi = Cars(brend: .Audi, releaseYear: 2016, color: .beige)
let bentley = Cars(brend: .Benley, releaseYear: 2012, color: .indigo)
let citroen = Cars(brend: .Citroen, releaseYear: 2015, color: .indigo)
bmw.windowsStatus.openCloseWindows()
bmw.engineStatus.startStopEngine()

// Получаем автомобиль со склада по бренду!
var car: [Cars]? // = Cars.stockInSklad.getCarForBrend(.BMW)
car = Cars.stockInSklad.getCarForBrend(.BMW)
print("Получаем автомобиль со склада по бренду!\n")
Cars.printCar(car)
print("\n")
bmw.windowsStatus.openCloseWindows()
bmw.engineStatus.startStopEngine()

// Получаем автомобиль со склада по индексу с помощью subscript!
print("Получаем автомобиль со склада по индексу с помощью subscript!\n")
car = Cars.stockInSklad[8]
Cars.printCar(car)

// Получаем все автомобили со склада с цветом .indigo

car = Cars.stockInSklad.getCarForColor(.indigo)
print("Получаем все автомобили со склада с цветом .indigo\n")
Cars.printCar(car)
