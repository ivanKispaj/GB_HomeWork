//
//  leaveGroup.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation

extension UserGroupTableViewController {
    func leaveGroup(to groupId: Int, completion: @escaping(Bool, [String]) -> ()) {
        var success: Bool!
        var message: [String] = []
        let internetConnection = InternetConnectionProxy(internetConnection:   InternetConnections(host: "api.vk.com", path: UrlPath.leaveGroup))
            internetConnection.leaveGroupService(for: groupId) { response in
                switch response {
                
                case .success(let result):
                    success = result.response
                    
                    if let error = result.error {
                        let messageError = error.errorMessage.components(separatedBy: ":")
                        message = messageError
                        completion(success, message)
                    }else {
                        completion(success, ["success"])
                    }
                    case .failure(_):
                       success = false
                       message = ["Internet error", "Ошибка интернет соединения!"]
                    completion(success, message)
                }
            }
        
    }
}
