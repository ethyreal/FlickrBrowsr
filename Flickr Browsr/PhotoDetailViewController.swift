//
//  PhotoDetailViewController.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/7/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var photo:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imgURL = photo?.imageURL() {
            imageView.setImageWithURL(imgURL)
        }
    }
}
