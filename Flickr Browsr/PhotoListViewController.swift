//
//  ViewController.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/4/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit
import CoreLocation
//import AFNetworking

class PhotoListViewController: UICollectionViewController {

    let photoStore = PhotoStore()
    
    let locationManager = CLLocationManager()
    
    var photos = [Photo]()
    
    let photoCellIdentifier = "FlickrPhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        collectionView?.collectionViewLayout = PhotoLayout()
        
        //updateLocationManagerForStatus(CLLocationManager.authorizationStatus())
    }

    
    // MARK: UICollectionViewDataSource  
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCellIdentifier, forIndexPath: indexPath) as! PhotoCell
        cell.backgroundColor = UIColor.greenColor()
        
        let photo = photos[indexPath.row]
        
        if let url = photo.imageURL() {
            cell.imageView.setImageWithURL(url)
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showPhotoDetailSegue") {

            guard let targetPath = collectionView!.indexPathForCell(sender as! UICollectionViewCell) else {
                return
            }
            
            let detailVC = segue.destinationViewController as! PhotoDetailViewController
            detailVC.photo = photos[targetPath.row]
        }
    }
}

// MARK: - CLLocationManagerDelegate 

extension PhotoListViewController: CLLocationManagerDelegate {
    
    func updateLocationManagerForStatus(status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            let alertController = UIAlertController(
                title: "Location Access Disabled",
                message: "In order to find photos near you we really must know your current location",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.updateLocationManagerForStatus(status)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard locations.count > 0 else {
            return
        }
        
        manager.stopUpdatingLocation()
        
        let location = locations[0]
        
        photoStore.fetchPhotosForLocation(location) { (photos) -> () in
            
            self.photos = photos
            self.collectionView?.reloadData()
            print("fetched photos: \(photos)")
        }
    }
}

