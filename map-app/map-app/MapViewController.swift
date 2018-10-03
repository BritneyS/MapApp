//
//  MapViewController.swift
//  map-app
//
//  Created by Elle Gover on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    // MARK: Properties
    var latlon: (latitude: Double?, longitude: Double?)

    // MARK: - Override Methods
   
    override func viewDidLoad() {
        super.viewDidLoad()

        populateMap()
    }
 
    // MARK: - Methods
    
    func populateMap() {
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let lat = latlon.latitude, let lon = latlon.longitude else { return }
        mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: lon), zoomLevel: 15, animated: false)
        view.addSubview(mapView)
    }
    
    
    
    
    
    
}
