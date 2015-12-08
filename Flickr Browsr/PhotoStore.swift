//
//  PhotoStore.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/4/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit
import CoreLocation

class PhotoStore {

    func fetchPhotosForLocation(location:CLLocation, completion:(photos:[Photo]) ->()) {
        
        guard let components = NSURLComponents(string: "https://api.flickr.com/services/rest/") else {
            return; // TODO: handle error
        }
        
        components.queryItems = queryItemsForCoordinates(location.coordinate)
        
        guard let url = components.URL else {
            return; // TODO: handle error
        }
        
        let request = NSURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in

            guard let rawData = data else {
                // TODO: handle no data
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(rawData, options: .AllowFragments)

                let photos = self.photosFromJSON(json as! NSDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(photos: photos)
                })
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func queryItemsForCoordinates(coordinates:CLLocationCoordinate2D) -> [NSURLQueryItem] {
        let method      = NSURLQueryItem(name: "method", value: "flickr.photos.search")
        let apiKey      = NSURLQueryItem(name: "api_key", value: "3544c08abf9c4004e91c9a37e0a6745a")
        let format      = NSURLQueryItem(name: "format", value: "json")
        let callback    = NSURLQueryItem(name: "nojsoncallback", value: "1")
        let page        = NSURLQueryItem(name: "page", value: "1")
        let perPage     = NSURLQueryItem(name: "per_page", value: "20")
        let latitude    = NSURLQueryItem(name: "lat", value: "\(coordinates.latitude)")
        let longitude   = NSURLQueryItem(name: "lon", value: "\(coordinates.longitude)")
        
        return [method, apiKey, format, callback, page, perPage, latitude, longitude]
    }
    
    func photosFromJSON(data:NSDictionary) -> [Photo] {
        
        var result = Array<Photo>()
        
        guard let root:NSDictionary = data["photos"] as? NSDictionary else {
            return result
        }
        
        guard let photos:NSArray = root["photo"] as? NSArray else {
            return result
        }
        
        for obj in photos {
            if obj.isKindOfClass(NSDictionary) {
                let photo = Photo.photoFromJSON(obj as! NSDictionary)
                result.append(photo)
            }
        }
        
        return result
    }
}
