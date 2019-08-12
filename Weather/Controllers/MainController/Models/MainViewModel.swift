//
//  MainViewModel.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit
import GooglePlaces

protocol MainViewModelDelegate: class {
    func didSearchAddressSuccess(_ arrayAddress: [Address])
    func didSearchAddressFail()
    func didLoadClimateSuccess(at index: Int)
}

class MainViewModel: NSObject {
    
    var arrayAddress: [Address] = []
    weak var delegate: MainViewModelDelegate?
    fileprivate var loadQueue = ClimateProcess()
    
    func searchAddress(_ text: String) {
        let client = GMSPlacesClient.shared()
        client.autocompleteQuery(text, bounds: nil, filter: nil) {[weak self] (results, error) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                guard let results = results else {
                    strongSelf.delegate?.didSearchAddressFail()
                    return
                }
                print(results.count)
                var addrs: [Address] = []
                for r in results {
                    let address = Address(name: r.attributedFullText.string, placeId: r.placeID, types: r.types)
                    addrs.append(address)
                }
                strongSelf.delegate?.didSearchAddressSuccess(addrs)
            }
        }
    }
    
    func requestClimate(address: Address?, at index: Int) {
        let params = NSMutableDictionary()
        params["q"] = address?.name
        Networking.requestClimate(params: params) { (result) in
            if result.error != nil {
                //TODO
            } else {
                do {
                    guard let data = result.data else { return }
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Climate.self, from: data)
                    print(model)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
        let model = AddressCellModel()
        model.setAddress(address)
        model.setClimate(address?.climate)
        return model
    }
    
    func address(at index: Int) -> Address? {
        guard index < self.arrayAddress.count else { return nil }
        return self.arrayAddress[index]
    }
}
