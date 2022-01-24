//
//  main.swift
//  2I_Konishchev Ivan
//
//  Created by Ivan Konishchev on 15.01.2022.
//

import Foundation


// even Функция возвращает true если число четное
func even (number: Int) -> Bool{
    guard number % 2 == 0 else { return false }
    return true
}

// multile функция возвращает true если число делится на 3
func multiple (number: Int) -> Bool {
    guard number % 3 == 0 else { return false }
    return true
}

// функция создает массив с последовательностью фибоначи
// на входе функции array -> массив
func fibonachiArray( count: Int) -> [Int]  {
    var arrayFibonachi: [Int] = [0]
    var countCycle = count
    while countCycle >= 0 {
        let count = arrayFibonachi.count
            if count < 2 {
                arrayFibonachi.append(arrayFibonachi[0] + 1 )
                
            }else {
                arrayFibonachi.append( arrayFibonachi[ count - 2 ] + arrayFibonachi[ count - 1 ] )
             
            }
        countCycle -= 1
    }
return arrayFibonachi
}

// Функция заполнения массива простыми числами
func primeNumber( array: [Int]) -> [Int] {
    var resultArray: [Int] = []
    var newArray = array
    while let p = newArray.first {
        resultArray.append(p)
        // Удаляем из массива все что делится на текущее значение
        newArray = newArray.filter{ $0 % p != 0 }
    }
    return resultArray
}

// Проверка функции на четные числа

if  even(number: 11) == true {
    print("Число четное")
}else {
    print("Число не четное")
}

// проверка функции на деление на 3
print("\n")
if multiple(number: 15) == true {
    print("Число делится на 3")
}else {
    print("Число не делится на 3")
}
print("\n")

// создаем возрастающий массив из 100 чисел
var array: [Int] = Array(0...100)
print("Массив из 100 элементов: \(array)")

print("\n")
// удаляем из массива все четные числа
array = array.filter { $0 % 2 != 0}
print("Массив без четных чисел: \(array)")
print("\n")

// удаляем из массива все числа которые не делятся на 3
array = array.filter { $0 % 3 == 0 }
print("Массив из чисел которые делятся на 3 : \(array)")

print("\n")
 // Последовательность фибоначи count -> количество чисел в последовательности
let count: Int = 50
var fibonachiItem = fibonachiArray( count: 50)
print("последовательность фибоначи из \(count) чисел :\(fibonachiItem)")

print("\n")
// простые числа
 let arrayNumber: [Int] = Array(2...100)
 let primeArray = primeNumber(array: arrayNumber)
 print("Массив с простыми числами : \(primeArray)")

