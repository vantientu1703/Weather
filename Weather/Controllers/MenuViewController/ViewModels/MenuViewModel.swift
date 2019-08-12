
//
//  MenuViewModel.swift
//  Weather
//
//  Created by Humaxvina on 8/12/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class MenuViewModel {
    var arrayAddress: [Address] = []
    
    func getAllAddress() {
        self.arrayAddress = RAddress.getAllAddress()
    }
    
    func numberOfRows() -> Int {
        return self.arrayAddress.count
    }
    
    func configCell(at indexPath: IndexPath) -> MenuCellModel {
        let address = self.address(at: indexPath)
        return MenuCellModel(address: address)
    }
    
    func address(at indexPath: IndexPath) -> Address? {
        guard indexPath.row < self.arrayAddress.count else { return nil }
        return self.arrayAddress[indexPath.row]
    }
    
    func removeAddress(at indexPath: IndexPath) {
        guard indexPath.row < self.arrayAddress.count else { return }
        let address = self.address(at: indexPath)
        address?.toRAddress().delete()
        self.arrayAddress.remove(at: indexPath.row)
    }
}
