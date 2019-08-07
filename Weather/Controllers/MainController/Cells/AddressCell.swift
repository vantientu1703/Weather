//
//  AddressCell.swift
//  Weather
//
//  Created by Humaxvina on 8/7/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class AddressCell: UIView {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    
    var addAddressAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: AddressCellModel) {
        self.placeNameLabel.text = model.placeName
        self.tmpLabel.text = model.temp
    }
    
    @IBAction func addAddressAction(_ sender: Any) {
        self.addAddressAction?()
    }
}
