//
//  main.swift
//  7I_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.01.2022.
//

import Foundation

enum ErrorDatabase: Error {
    case errorConnectDatabase
}
enum Connect {
    case connect
    case disconnect
    mutating func connectDatabase(){
        switch self {
        case .connect:
            self = .disconnect
        case .disconnect:
            self = .connect
        }
    }
}

class User {
    enum User {
        case admin
        case test
        case author
    }
    var userArray: [[User :String]] = [[ .admin: "Ivan konishcev"], [.test: "test"], [.author: "Pupkin"]]
    
    func addUserToArray(userType: User, fullName: String) -> Bool? {
        let filterUser = self.userArray.filter{ $0 == [userType: fullName] }
        guard filterUser.count <= 0 else { return nil }
        self.userArray.append([userType: fullName])
        return true
    }
    
    func printUsersArray(){
        for value in self.userArray{
            for values in value{
                print("Пользователь: \(values.key), \(values.value)\n")
            }
        }
    }
}
// Класс с обработкой ошибок Throw при выполнение соединения через раз выкидывает ошибку!
class Database {
    
    var databaseName: String
    var userName: String
    var password: String
    var localhost: String
    var connect: Connect
    init(database: String, userName: String, password: String, host: String){
        self.databaseName = database
        self.userName = userName
        self.password = password
        self.localhost = host
        self.connect = .disconnect
    }
    func connectDatabase() throws {
        print("бла бла бла, соединяемся с базой данных")
        self.connect.connectDatabase()
        guard self.connect == .connect else { throw ErrorDatabase.errorConnectDatabase }
       
    }

}

var database: Database? = Database(database: "test", userName: "ivan", password: "12345", host: "https://localhost")
do {
   var connect = try database?.connectDatabase()
    print("Подключение установленно!\n Имя базы данных:\((database?.databaseName)!)\n Имя пользователя: \((database?.userName)!)")
    connect = try database?.connectDatabase()
}catch let error {
    print("Ошибка соединения с базой данных: Error: \(error)\n")
}


var users = User()
print("--------Все пользователи-------")
users.printUsersArray()
print("-------------------------------")
if users.addUserToArray(userType: .admin, fullName: "Ivan Konishchev") != nil {
    print("добавлен пользователь\n")
} else {
    print("Такой пользователь существует!\n")
}

if users.addUserToArray(userType: .author, fullName: "Ivan Konishchev") != nil {
    print("добавлен пользователь\n")
} else {
    print("Такой пользователь существует!\n")
}
if users.addUserToArray(userType: .author, fullName: "Ivan Konishchev") != nil {
    print("добавлен пользователь")
} else {
    print("Такой пользователь существует!")
}
print("--------Все пользователи-------")
users.printUsersArray()
print("-------------------------------")
