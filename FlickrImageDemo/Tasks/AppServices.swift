//
//  AppServices.swift
//  HikeTestDemo
//
//  Created by Gaurav Vyas on 13/04/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation
import  UIKit

struct FlikrPhotos {
    let page: Int
    let data: [FlikrPhotoKeys]
}

struct FlikrPhotoKeys {
    let photo_id: String
    let server: String
    let secret: String
    let farm: Int
}

extension FlikrPhotos {
    init?(json: [String: Any]) {
        guard let info = json["photos"] as? [String: Any], let pageNumber = info["page"] as? Int
            else {
                return nil
            }
        
        page = pageNumber
        
        var bufferData = [FlikrPhotoKeys]()
        
        guard let photos = info["photo"] as? [[String: Any]] else { return nil }
        
        for photo in photos {
            if let photoData = FlikrPhotoKeys(json: photo) {
                bufferData.append(photoData)
            }
        }
        data = bufferData
    }
}

extension FlikrPhotoKeys {
    init?(json: Any) {
        guard let jsonData = json as? [String: Any], let id = jsonData["id"] as? String, let server_id = jsonData["server"] as? String,
            let secret_id = jsonData["secret"] as? String,
            let farm_id = jsonData["farm"] as? Int else { return nil }
        
        photo_id = id
        server = server_id
        secret = secret_id
        farm = farm_id
    }
}

class AppServices {
    
    func getFlickrPhotosSearch(_ flowerName: String, completion: @escaping (_ photosData: FlikrPhotos) -> ()) {
        
        let serviceURL = AppConstants.BASE_URL + flowerName
        
        guard let url = URL(string: serviceURL) else { return }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) {(data, reponse, error) in
            guard error == nil, let data = data else {
                return
            }
            
            if let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = object as? [String: Any] {
                guard let photos = FlikrPhotos(json: json) else { return }
                
                completion(photos)
            }
        }
        
        dataTask.resume()
        session.finishTasksAndInvalidate()
    }
    
    func downloadTask(_ farm: Int, server: String, id: String, secret: String, imageView: UIImageView) {
        
        let downloadURL = "https://farm\(farm).static.flickr.com/" + server + "/" + "\(id)_" + secret + ".jpg"
        
        guard let url = URL(string: downloadURL) else { return }
        
        print("Download Started")
        DispatchQueue.global(qos: .background).async {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                
                DispatchQueue.main.async() {
                    imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
