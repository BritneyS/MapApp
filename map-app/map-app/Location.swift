//
//  Location.swift
//  map-app
//
//  Created by Elle Gover on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import UIKit

class Location {
    
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
