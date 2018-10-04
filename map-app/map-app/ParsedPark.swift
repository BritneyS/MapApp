//
//  ParsedPark.swift
//  map-app
//
//  Created by Britney Smith on 10/3/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation

class ParsedPark: Codable {
    var name: String?
    var the_geom: Geometry
}

class Geometry: Codable {
    
    var coordinates: [[[[Double?]]]]
    
    var lat: Double {
        guard let latitude = coordinates[0][0][0][1] else { return 0.0 }
        return latitude
    }
    
    var lon: Double {
        guard let longitude = coordinates[0][0][0][0] else { return 0.0 }
        return longitude
    }
}
