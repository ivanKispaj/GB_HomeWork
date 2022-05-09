//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.04.2022.
//

import UIKit

extension DetailUserTableViewController {
    func loadDataTable() async {
        if let friend = await self.loadFriendsSelectedUser() {
            
            if let friendsPhoto = await self.loadPhotoAlbumSelctedUser(friend) {
                await LoadUserWall( friend, photos: friendsPhoto)
            }
        }
    }
}
