//
//  PlaceCellModel.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class PlaceCellModel {
    
    fileprivate var place: Address?
    
    init() {
        
    }
    
    init(address: Address?) {
        self.place = address
    }
    
    var name: String? {
        return self.place?.name
    }
}
