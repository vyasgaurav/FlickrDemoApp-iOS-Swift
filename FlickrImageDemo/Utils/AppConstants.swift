//
//  AppConstants.swift
//  HikeTestDemo
//
//  Created by Gaurav Vyas on 13/04/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import Foundation

class AppConstants {
    
    static let API_KEY = "417ab2c95532ebec68f562ee01637860"

    static let SECRET_KEY = "2658a2f6245c9d09"

    static let REST_URL = "&format=json&nojsoncallback=1&safe_search=1&text="

    static let BASE_URL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=" + AppConstants.API_KEY + AppConstants.REST_URL
    
    static let PHOTOCELL_IDENTIFIER = "PhotoTableViewCell"
    
    
}
