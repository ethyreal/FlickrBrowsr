//
//  Photo.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/5/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit


class Photo : NSObject {
    
    var id:String = ""
    var farm:Int = 0
    var secret:String = ""
    var server:String = ""
    var title:String = ""
    var thumbnail:UIImage?
    
    class func photoFromJSON(data:NSDictionary) -> Photo {
        
        
        let keys = ["id", "farm", "secret", "server", "title"];
        
        let photo = Photo()
        
        for key in keys {

            guard let value = data.objectForKey(key) else {
                continue
            }
            
            photo.setValue(value, forKey: key)
        }
        
        return photo
    }
    
    
    func imageURL(size:String = "m") -> NSURL? {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")
    }

}
