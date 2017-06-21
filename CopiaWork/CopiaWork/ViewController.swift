//
//  ViewController.swift
//  CopiaWork
//
//  Created by Dishank Jhaveri on 19/06/17.
//  Copyright © 2017 Dishank Jhaveri. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,GMSMapViewDelegate {
    
    var mapView :GMSMapView?
    var camera :GMSCameraPosition?
    var coordList = allMapCoords()
    var timer: Timer! = nil
    var marker = GMSMarker()
    var counter: NSInteger!
    
    var mapCoords : [mapCoord] { //front end for coords model object
        get {
            return self.coordList.coordList
        }
        set(val) {
            self.coordList.coordList = val
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera = GMSCameraPosition.camera(withTarget: mapCoords[0].coordinate, zoom: 16.0)
         marker.icon = UIImage(named: "TruckSmall")
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        view = mapView
        counter = 0
        
        /*
        * Timer to call timedMovement every 0.5s.
        */
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timedMovement), userInfo: nil, repeats: true)
    }
    
    /*
     * Starting from the initial point animate through every coordinate position.
    */
    func timedMovement(){
        if(counter<mapCoords.count-1)
        {
            var initialPoint = CLLocationCoordinate2DMake(mapCoords[counter].coordinate.latitude, mapCoords[counter].coordinate.longitude)
            marker.map = mapView
            marker.appearAnimation = .pop
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.5)
            
            marker.position = initialPoint
            let newCoordinate = self.mapCoords[counter].coordinate
            self.moveMarker(self.marker, newCoordinate)
            initialPoint = newCoordinate
            counter = counter + 1
            
            CATransaction.commit()
        }
    }
    
    /*
    * Update the markers coordinate position to the next one.
    */
    func moveMarker(_ movedMarker: GMSMarker,_ newCoordinate: CLLocationCoordinate2D){
        marker = movedMarker
        marker.position = newCoordinate
        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

