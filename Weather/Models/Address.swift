//
//  Address.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class Address {
    var id: Int?
    var name: String?
    var placeId: String?
    var types: [String] = []
    var climate: Climate?
    init() {
        
    }
    
    init(name: String?, placeId: String?, types: [String]) {
        self.name = name
        self.placeId = placeId
        self.types = types
    }
}
