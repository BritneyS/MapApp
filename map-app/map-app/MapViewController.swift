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
        mapView.setCenter(CLLocationCoordinate2D(latitude: 42.371373, longitude: -83.066100), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
    }
    
    
    
    
    
    
}
