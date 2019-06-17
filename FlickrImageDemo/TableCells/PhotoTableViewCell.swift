//
//  PhotoTableViewCell.swift
//  HikeTestDemo
//
//  Created by Gaurav Vyas on 13/04/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVIew: UIImageView!
    
    func drawCell(_ keys: FlikrPhotoKeys ) {
        
        AppServices().downloadTask(keys.farm,
                                   server: keys.server,
                                   id: keys.photo_id,
                                   secret: keys.secret,
                                   imageView: imageVIew)
    }
}
