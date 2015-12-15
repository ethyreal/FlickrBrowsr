//
//  ViewController.swift
//  Flickr Browsr
//
//  Created by George Webster on 12/4/15.
//  Copyright © 2015 George Webster. All rights reserved.
//

import UIKit
import CoreLocation

class PhotoListViewController: UICollectionViewController {

    let photoStore = PhotoStore()
    
    let locationManager = CLLocationManager()
    
    var photos = [Photo]()
    
    let photoCellIdentifier = "FlickrPhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        collectionView?.collectionViewLayout = PhotoLayout()

        collectionView?.registerClass(PhotoCell.self, forCellWithReuseIdentifier: photoCellIdentifier)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
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
        //cell.backgroundColor = UIColor.greenColor()
        cell.imageView.contentMode = .ScaleAspectFit
        
        let photo = photos[indexPath.row]
        
        photoStore.fetchImageForPhoto(photo, size: .Thumbnail) { (image) -> () in
            cell.imageView.image = image
        }

        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let vc = PhotoDetailViewController()
        vc.photo = photos[indexPath.row]
        vc.store = photoStore
        
        if let nav = self.navigationController {
            nav.pushViewController(vc, animated: true)
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
        
        photoStore.fetchPhotosForCoordinate(location.coordinate) { (photos) -> () in
            
            self.photos = photos
            self.collectionView?.reloadData()
            //print("fetched photos: \(photos)")
        }
    }
}

