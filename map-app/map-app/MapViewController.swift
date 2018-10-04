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
    var isZoomEnabled: Bool?
    var isPitchEnabled: Bool?
    
    // MARK: - Lifecycle Methods
   
    override func viewDidLoad() {
        super.viewDidLoad()

        populateMap()
        setMapProperties()
        setNavBarProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Methods
    
    func populateMap() {
        
        /// Uncomment this url line to use Mapbox pre-set map style
        //let url = URL(string: "mapbox://styles/mapbox/streets-v10")
        let url = URL(string: "mapbox://styles/ellegover/cjmr1ebfq98g92smzkj9a0a4i")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let lat = latlon.latitude, let lon = latlon.longitude else { return }
        mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: lon), zoomLevel: 15, animated: false)
        view.addSubview(mapView)
    }
    
    func setMapProperties() {
        
        isZoomEnabled = true
        isPitchEnabled = true
    }
    
    func setNavBarProperties() {
        
        navigationController?.navigationBar.barTintColor = UIColor.black

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }
}
