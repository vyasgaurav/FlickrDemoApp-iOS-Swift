//
//  ViewController.swift
//  HikeTestDemo
//
//  Created by Gaurav Vyas on 13/04/19.
//  Copyright © 2019 Gaurav Vyas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var flickrPhoto: FlikrPhotos?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppServices().getFlickrPhotosSearch("rose", completion: { photos in
            self.flickrPhoto = photos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = flickrPhoto?.data.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.PHOTOCELL_IDENTIFIER) as! PhotoTableViewCell
        
        guard let flikrData = flickrPhoto?.data[indexPath.row] else { return UITableViewCell() }
        
        cell.drawCell(flikrData)
        
        return cell
    }
}
