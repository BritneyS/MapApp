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
    var latlon: (latitude: Double, longitude: Double)?

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
        mapView.setCenter(CLLocationCoordinate2D(latitude: latlon!.latitude, longitude: latlon!.longitude), zoomLevel: 15, animated: false)
        print("\(latlon!.latitude), \(latlon!.longitude)")
        view.addSubview(mapView)
    }
    
    
    
    
    
    
}
