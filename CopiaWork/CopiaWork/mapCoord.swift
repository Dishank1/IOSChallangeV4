//
//  mapCoord.swift
//  CopiaProject
//
//  Created by Dishank Jhaveri on 19/06/17.
//  Copyright © 2017 Dishank Jhaveri. All rights reserved.
//

/*
 * Model for each Coordinate location.
 */
import Foundation
import CoreLocation
import MapKit

class mapCoord: NSObject,MKAnnotation {
    private var location:CLLocation?
    
    init(location:CLLocation?)
    {
        super.init()
        self.setLocation(_location: location)
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    func getLocation()->CLLocation
    {
        return location!
    }
    
    func setLocation(_location: CLLocation?)
    {
        location = _location
    }
}
