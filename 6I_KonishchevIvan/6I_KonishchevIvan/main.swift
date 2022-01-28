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
    var description: String {
        return """
               Марка автомобиля: \(brend)
               Год выпуска: \(releaseYear)
               Цвет автомобиля: \(color)
               """
    }
    static var stockInSklad = CarSklad<Cars>()
    var brend: Brand
    var releaseYear: Int
    var color: Color
    init(brend: Brand, releaseYear: Int, color: Color){
        self.brend = brend
        self.releaseYear = releaseYear
        self.color = color
        Cars.stockInSklad.sentToSklad(self)
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
        guard carInStock.indices.contains(index)  else { return nil }
        returnFind.append(carInStock[index])
        return returnFind
        }
}

var alfa = Cars(brend: .Alfa_Romeo, releaseYear: 2010, color: .azure)
let bmw = Cars(brend: .BMW, releaseYear: 2021, color: .indigo)
let mercedes = Cars(brend: .Mercedes_Benz, releaseYear: 2018, color: .white)
let audi = Cars(brend: .Audi, releaseYear: 2016, color: .beige)
let bmw1 = Cars(brend: .Benley, releaseYear: 2012, color: .indigo)
let bmw2 = Cars(brend: .Citroen, releaseYear: 2015, color: .indigo)
// Получаем автомобиль со склада по бренду!
print(Cars.stockInSklad.getCarForBrend(.Audi))
// Получаем автомобиль со склада по индексу с помощью subscript!
let result = Cars.stockInSklad[5]
result != nil ? print(result!) : print("На складе отсутствует автомобиль с таким индексом!")

// Получаем все автомобили со склада с цветом .indigo
print(Cars.stockInSklad.getCarForColor(.indigo))
