//
//  Photo.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/5/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit

enum PhotoSize: Int {
    case Thumbnail = 0
    case Large

    func toString() -> String {
        switch self {
        case .Thumbnail:
            return "m"
        case .Large:
            return "b"
        }
    }

}

class Photo : NSObject {
    
    var id:String = ""
    var farm:Int = 0
    var secret:String = ""
    var server:String = ""
    var title:String = ""
    var thumbnail:UIImage?
    var photoDescription:String = ""
    
    class func photoFromJSON(data:NSDictionary) -> Photo {
        
        
        let keys = ["id", "farm", "secret", "server", "title"];
        
        let photo = Photo()
        
        for key in keys {

            guard let value = data.objectForKey(key) else {
                continue
            }
            
            photo.setValue(value, forKey: key)
        }

        // special case for descrption
        // gross little piramid of doom
        if let descriptionData = data["description"] {
            if let desc = descriptionData["_content"] {
                photo.photoDescription = desc as! String
            }
        }
        
        return photo
    }
    
    
    func imageURL(size:PhotoSize = .Thumbnail) -> NSURL? {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.toString()).jpg")
    }

}
