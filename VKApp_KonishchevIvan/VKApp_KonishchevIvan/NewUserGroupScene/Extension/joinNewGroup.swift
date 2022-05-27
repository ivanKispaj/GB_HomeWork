//
//  joinInNewGroup.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation

extension NewGroupTableViewController {
    func joinNewGroup(to groupId: Int, completion: @escaping(Bool, [String]) -> ()) {
        var success: Bool!
        var message: [String] = []
    
            InternetConnections(host: "api.vk.com", path: "/method/groups.join").joinInToGroup(for: groupId) { response in
                switch response {
                
                case .success(let result): //let result
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