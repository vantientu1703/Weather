//
//  MenuCellModel.swift
//  Weather
//
//  Created by Humaxvina on 8/12/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class MenuCellModel {
    
    fileprivate var address: Address?
    
    init() {
        
    }
    
    init(address: Address?) {
        self.address = address
    }
    
    var placeName: String? {
        return self.address?.name
    }
}
