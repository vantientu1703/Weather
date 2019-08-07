//
//  SearchViewModel.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class SearchViewModel {
    var arrayAddress: [Address] = []
    
    func numberOfRows() -> Int {
        return self.arrayAddress.count
    }
    
    func address(at indexPath: IndexPath) -> Address? {
        guard indexPath.row < self.arrayAddress.count else {
            return nil
        }
        return self.arrayAddress[indexPath.row]
    }
    
    func configCell(at indexPath: IndexPath) -> PlaceCellModel {
        guard indexPath.row < self.arrayAddress.count else {
            return PlaceCellModel()
        }
        return PlaceCellModel(address: self.arrayAddress[indexPath.row])
    }
}
