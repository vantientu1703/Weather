//
//  MainViewModel.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func didLoadClimateSuccess(at index: Int)
}

class MainViewModel: NSObject {
    
    var arrayAddress: [Address] = []
    weak var delegate: MainViewModelDelegate?
    fileprivate var loadQueue = ClimateProcess()
    
    func getClimates() {
        for index in 0..<self.arrayAddress.count {
            self.getClimate(at: index)
        }
    }
    
    func getClimate(at index: Int) {
        self.loadQueue.addQueue(address: self.arrayAddress[index], at: index) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didLoadClimateSuccess(at: index)
        }
    }
    
    func numberOfRows() -> Int {
        return self.arrayAddress.count
    }
    
    func getPlaces() {
        self.arrayAddress = RAddress.getAllAddress()
    }
    
    func append(address: Address) {
        self.arrayAddress.append(address)
    }
    
    func removeAddress(at index: Int) {
        guard index < self.arrayAddress.count else { return }
        self.arrayAddress.remove(at: index)
    }
    
    func configCell(at index: Int) -> AddressCellModel {
        let address = self.address(at: index)
        let model = AddressCellModel(address)
        return model
    }
    
    func address(at index: Int) -> Address? {
        guard index < self.arrayAddress.count else { return nil }
        return self.arrayAddress[index]
    }
}
