//
//  PhotoDetailViewController.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/7/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    var photoContainer: PhotoContainerView?
    
    var photo:Photo?
    var store:PhotoStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let container = PhotoContainerView(frame: view.bounds)
        view.addSubview(container)
        photoContainer = container
        
        setupPhoto()
    }
    
    func setupPhoto() {
        
        guard let photo = self.photo else {
            return;
        }

        store?.fetchImageForPhoto(photo, size: .Large) { (image) -> () in
            
            if let img = image {
                self.photoContainer?.updateViewWithImage(img)
            }
        }
    }
}
