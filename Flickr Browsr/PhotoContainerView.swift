//
//  PhotoContainerView.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/13/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

class PhotoContainerView: UIScrollView {

    var imageView:UIImageView
    
    override init(frame: CGRect) {
        
        let ivFrame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))
        self.imageView = UIImageView(frame: ivFrame)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        self.delegate = self;
        self.scrollEnabled = true
        
        self.addSubview(self.imageView)
        
        let viewsDictionary = ["imageView" : self.imageView]
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        self.addConstraints(hConstraint)
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        self.addConstraints(vConstraint)
        
        
        self.minimumZoomScale = 0.5
        self.maximumZoomScale = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateViewWithImage(image:UIImage) {
        
        zoomScale = 1
        contentOffset = CGPointZero
        
        imageView.image = image
        imageView.sizeToFit()
        
        contentSize = CGSize(width: CGRectGetWidth(imageView.frame), height: CGRectGetHeight(imageView.frame))
        
        let scaleWidth = CGRectGetWidth(frame) / CGRectGetWidth(imageView.frame)
        let scaleHeight = CGRectGetHeight(frame) / CGRectGetHeight(imageView.frame)
        
        minimumZoomScale = min(scaleWidth, scaleHeight)
        
        let zoomRect = rectForZoomingToScale(scaleHeight)
        zoomToRect(zoomRect, animated: false)
    }

    func rectForZoomingToScale(scale:CGFloat) -> CGRect {
        
        let zoomWidth = CGRectGetWidth(frame) / scale
        let zoomHeight = CGRectGetHeight(frame) / scale
        let zoomX = CGRectGetMidX(frame) - (CGRectGetWidth(self.frame) / 2)
        let zoomY = CGRectGetMidY(frame) - (CGRectGetHeight(self.frame) / 2)
        
        return CGRect(x: zoomX, y: zoomY, width: zoomWidth, height: zoomHeight)
    }

}

// MARK: UIScrollViewDelegate

extension PhotoContainerView: UIScrollViewDelegate {

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
