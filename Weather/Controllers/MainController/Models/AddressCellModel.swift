//
//  AddressCellModel.swift
//  Weather
//
//  Created by Humaxvina on 8/9/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class AddressCellModel {
    fileprivate var address: Address?
    fileprivate var climate: Climate?
    
    init() {
        
    }
    
    func setAddress(_ address: Address?) {
        self.address = address
    }
    
    func setClimate(_ climate: Climate?) {
        self.climate = climate
    }
    
    var placeName: String? {
        return self.address?.name
    }
    
    var temp: String? {
        guard let tmpl = self.climate?.main?.temp else {
            return nil
        }
        return String(format: "%0.1f", (tmpl - 273))
    }
}
