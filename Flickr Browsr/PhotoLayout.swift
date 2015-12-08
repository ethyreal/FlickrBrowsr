//
//  PhotoLayout.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/7/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

class PhotoLayout: UICollectionViewFlowLayout {

    override init() {
        
        super.init()
        
        itemSize = CGSizeMake(160, 160)
        
        minimumInteritemSpacing = 13
        minimumLineSpacing = 13
        
        sectionInset = UIEdgeInsetsMake(8, 16, 8, 16)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
