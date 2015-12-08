//
//  UIImageView+FlickrBrowsrAdditions.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/7/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

extension UIImageView {
    public func setImageWithURL(url: NSURL) {
        
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            guard let rawData = data else {
                // TODO: handle no data
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.image = UIImage(data: rawData)
            })
        }
        
        task.resume()
    }
}
