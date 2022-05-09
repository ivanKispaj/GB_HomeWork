//
//  LoadAndSavePhotoData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift


//MARK: - Load photo selected user
extension InternetConnections {
    func LoadPhotoUser(for ownerId: String) async throws {
        guard let access_token = NetworkSessionData.shared.token else { return }
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: ownerId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "no_service_albums", value: "0"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "skip_hidden", value: "0")
        ]
        guard let url = self.urlComponents.url else { throw InternetError.parseError }
        do {
            let (data, _ ) = try await self.session.data(from: url)
            let decode = JSONDecoder()
            decode.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(ownerId)!]
            let result = try decode.decode(PhotoUser.self, from: data)
            await self.saveUserPhotoAlbum(result.response)
        }catch {
            throw InternetError.parseError
        }
    }
    
 //MARK: - Запись фото друга в Realm
    private func saveUserPhotoAlbum(_ data: PhotoResponse ) async {
        if let realm = try? await Realm() {
            do {
                try realm.write {
                    realm.add(data, update: .modified)
                }
                
            }catch {
                print("Error Save Realm: \(error.localizedDescription)")
            }
        }
    }
}
