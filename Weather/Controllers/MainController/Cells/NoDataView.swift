//
//  NoDataView.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    
    var addAddressAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func noDataAction(_ sender: Any) {
        self.addAddressAction?()
    }
}
