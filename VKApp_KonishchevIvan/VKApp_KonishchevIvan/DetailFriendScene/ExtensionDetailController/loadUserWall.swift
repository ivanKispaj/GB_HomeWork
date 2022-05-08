//
//  loadUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//

import UIKit
import RealmSwift

extension DetailUserTableViewController {

    func LoadUserWall (_ friends: [Friend], photos: [ImageAndLikeData]) {

        var userDetailsTableData: [UserDetailsTableData]! {
            didSet {
                return finishLoadData( friends: friends, photos: photos, wall: userDetailsTableData)
            }
        }
        
        InternetConnections(host: "api.vk.com", path: "/method/wall.get").getUserWall(for: String(self.friendsSelectedd.id)) { [weak self] request in
            switch request {
           
                case .success(let result):
                
                self!.saveUserWall(result.response)
                
                var detailsTableData: [UserDetailsTableData] = []
                
                let items = result.response.items
                
                for item in items {
                    var typeSection: SectionType?
                    
                    if let attachments = item.attachments.first{
                        
                        
                    }else if let copyHistory = item.wallcopyHystory.first {
                        
                        
                    }
                    
                }
                userDetailsTableData = detailsTableData
                    case .failure(_):
                        print("Error request Photo")
            }
        }
    }
    
    private func finishLoadData( friends: [Friend], photos: [ImageAndLikeData], wall: [UserDetailsTableData]) {
              var details = wall
                    details.insert(UserDetailsTableData(sectionType: .Gallary, sectionData: DetailsSectionData(photo: photos)), at: 0)
                    details.insert(UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData(friends: friends)), at: 0)
                    self.dataTable = details
            

    }
   private func getPhotoUrl(_ photoArr: [WallSizes]) -> WallSizes {
        if let photoData = photoArr.first(where: { $0.type == "y" }) {
            return photoData
        } else if let photoData = photoArr.first (where: { $0.type == "x" }) {
          return photoData
        }else if let photoData = photoArr.first (where: { $0.type == "k" }) {
            return photoData
        } else if let photoData = photoArr.first(where: { $0.type == "q"}) {
            return photoData
        }else if let photoData = photoArr.first(where: { $0.width > 200}) {
            return photoData
        }else if let photoData = photoArr.first(where: { $0.width > 130}) {
        return photoData
        }
        let photoData = photoArr.first(where: { $0.width > 90})
        return photoData!
    }
    
   private func getPhotoNewsHistory(_ photoArray: [WallSizes]) -> String {
     
        let url = photoArray.first { $0.width > 300 }?.url
        return url ?? " "
    }
    
}


private extension DetailUserTableViewController {
    func saveUserWall(_ userWall: UserWallResponse) {
        
                DispatchQueue.main.async {
                    let realmDB = try!  Realm()
        //           print(realmDB.configuration.fileURL!)
                       do {
                           try realmDB.write{
                               realmDB.add(userWall.items, update: .modified)
                           }
                       } catch let error as NSError {
                           print("Something went wrong: \(error.localizedDescription)")
                       }
                }
    }
}
