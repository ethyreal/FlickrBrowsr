//
//  PhotoCell.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/7/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        let iv = UIImageView(frame: self.bounds)
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(iv)
        self.imageView = iv
        
        let viewsDictionary = ["imageView" : self.imageView]
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        self.addConstraints(hConstraint)
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(vConstraint)
        
        self.backgroundColor = UIColor.whiteColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
