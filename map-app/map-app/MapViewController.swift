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

    override func viewDidLoad() {
        super.viewDidLoad()

        populateMap()
    }
 
    func populateMap() {
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v10")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 42.371373, longitude: -83.066100), zoomLevel: 10.93, animated: false)
        view.addSubview(mapView)
    }
    
    
    
    
    
    
}
