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
    try database?.connectDatabase()
      print("Подключение установленно!\n Имя базы данных:\((database?.databaseName)!)\n Имя пользователя: \((database?.userName)!)")
  
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



/*
 Михаил! Вот второй вариант обработки ошибок
 и мои опыты с замыканиями.
 Посмотрите пожалуйста, прокоментируйте код если не трудно.
 Я постарался сделать с убегающим замыканием.
 Скажите есть у меня тут сильные ссылки?
 Если есть подскажите где и изза чего.
 
 */


print("\n\nВторой вариант кода с замыканиями\n")

enum Errors: Error {
    case serverError
    case userNotFound
}
enum UserType {
    case admin, moderator, author,visitor
}

struct ServerRequest {
    init(){}
    static var shared = ServerRequest()
    var allRequests: [Int] = [200,500,403,301,404,503]
    var request: Int?
    mutating func connect () throws {
        let result = self.allRequests.shuffled()[0]
        guard (200...320).contains(result) else{
            self.request = result
            throw Errors.serverError
            
        }
        self.request = result
    }

}

class DataUser {

    init(){}
    static var shared:DataUser? = DataUser()
    var userFind: UserType? = nil
    private var user: [String:UserType] = ["Ivan": .admin, "Igor": .moderator, "Michail": .visitor, "Oleg": .author]
    func findUser(_ name: String) throws -> UserType{
        guard let userFind = self.user[name] else { throw Errors.userNotFound }
        self.userFind = userFind
        
        // print(self.userFind!)
        return userFind
        }
    static func killDataUserProcess(){
        DataUser.shared = nil
    }
    deinit {
        self.userFind = nil
        
        print("DataUser delited")
    }
    }


class TasksData {
    var clousureHandle: (UserType?, ServerRequest?, Errors?) -> Void
    var dataUser: UserType? = nil
    var errors: Errors? = nil
    var serverRequest: ServerRequest? = nil
    func getTaskData(with name: String) {
        
    }
    init(with name: String, clousure: @escaping (UserType?, ServerRequest?, Errors?) -> Void ) {
        self.dataUser = try? DataUser.shared?.findUser(name)
        self.clousureHandle = clousure
        var request = ServerRequest.shared
        do {
            try request.connect()
        }catch {
            self.errors = .serverError
        }
        clousureHandle(self.dataUser, request, errors)
    }
    deinit {
        DataUser.killDataUserProcess()
        print("TaskData delite")
    }
}

func getName(with name: String, clousures:  @escaping (UserType?, ServerRequest?, Errors?) -> Void) -> TasksData {
    return TasksData(with: name, clousure: clousures)
}

var sessions:TasksData? = getName(with: "Ivan") { (data, response, error) in
    
    guard let responses = response else {
        return
    }
    guard  (200...320).contains(responses.request!) else {
        print("\(error!): \(responses.request ?? 404)")
        return
    }
    guard data != nil else {
        print("Получен ответ сервера: \(responses.request!)\nПользователь не найден!")
        return
    }
    print("Получен ответ сервера: \(responses.request!)\nСтатус пользователя: \(data!)" )
}
sessions = nil
