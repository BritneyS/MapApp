//
//  LocationDatabase.swift
//  map-app
//
//  Created by Elle Gover on 10/2/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import UIKit

struct LocationDatabase {
    
    var locationDatabase: [Location] = [Park(name: "Belle Isle", latitude: 42.342147, longitude: -82.972192),
                                        Park(name: "Tolan Playfield", latitude: 42.351736, longitude: -83.048877),
                                        Park(name: "Palmer Park", latitude: 42.424239, longitude: -83.115951),
                                        Park(name: "Roosevelt Park", latitude: 42.330264, longitude: -83.076015)]
    
}
