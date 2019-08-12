//
//  MenuCell.swift
//  Weather
//
//  Created by Humaxvina on 8/12/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(model: MenuCellModel) {
        self.placeNameLabel.text = model.placeName
    }
}
