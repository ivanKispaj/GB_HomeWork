//
//  LoadAndSaveUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift

//MARK: - Load User Wall Data!!
extension InternetConnections {
    func getUserWall(for ownerId: String) async throws {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: ownerId),
            URLQueryItem(name: "filter", value: "owner"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = self.urlComponents.url else { throw InternetError.parseError }
        do {
            let (data, _ ) = try await self.session.data(from: url)
            let decode = JSONDecoder()
            decode.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(ownerId)!]
            let result = try decode.decode(UserWallModel.self, from: data)
            await self.saveUserWall(result.response)
            
        }catch {
            throw InternetError.parseError
        }

    }
  
    
//MARK: - Save Wall Data To Realm
    private func saveUserWall(_ userWall: UserWallResponse ) async {
        if let realm = try? await Realm() {
               do {
                   try realm.write{
                       realm.add(userWall, update: .modified)
                   }
               } catch let error as NSError {
                   print("Something went wrong: \(error.localizedDescription)")
               }
        }
    }
}
