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
    
    var detailTextView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        let containerFrame = frameForContainerView()
        let container = PhotoContainerView(frame: containerFrame)
        view.addSubview(container)
        photoContainer = container

        if traitCollection.userInterfaceIdiom == .Pad {
            var tvFrame = frameForDetailTextView()
            tvFrame.origin.y = CGRectGetMaxY(containerFrame)
            let tv = UITextView(frame: tvFrame)
            view.addSubview(tv)
            detailTextView = tv
        }

        setupPhoto()
        
    }
    
    override func viewWillLayoutSubviews() {

        photoContainer?.frame = frameForContainerView()
        
        detailTextView?.frame = frameForDetailTextView()
    }
    
    func setupPhoto() {
        
        guard let photo = self.photo else {
            return;
        }

        title = photo.title
        
        store?.fetchImageForPhoto(photo, size: .Large) { (image) -> () in
            
            if let img = image {
                self.photoContainer?.updateViewWithImage(img)
            }
        }
        
        detailTextView?.text = photo.photoDescription
    }
    
    func frameForContainerView() -> CGRect {

        var frame = view.bounds

        if traitCollection.userInterfaceIdiom == .Pad {
            frame.size = CGSize(width: 500, height: 500)
        }
        
        frame.origin.x = CGRectGetMidX(view.bounds) - (CGRectGetWidth(frame) / 2)
        
        if let navbar = navigationController?.navigationBar {
            frame.origin.y = CGRectGetHeight(navbar.frame)
        }
        
        return frame
    }

    func frameForDetailTextView() -> CGRect {
        
        if traitCollection.userInterfaceIdiom == .Pad {
            
            let containerFrame = frameForContainerView()
            
            var frame = containerFrame
            frame.size.height = CGRectGetHeight(view.bounds) - CGRectGetMaxY(containerFrame);
            frame.origin.y = CGRectGetHeight(containerFrame)
            return frame
        }
        
        return CGRectZero
    }

}
