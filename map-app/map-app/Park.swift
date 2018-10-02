//
//  Park.swift
//  map-app
//
//  Created by Elle Gover on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import UIKit

class Park: Location {
    
    var name: String?
    
    init(name: String, latitude: Double, longitude: Double) {
       
        super.init(latitude: latitude, longitude: longitude)
        self.name = name
    }
    
    
}
