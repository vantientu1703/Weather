import UIKit
import GooglePlaces

protocol SearchViewModelDelegate: AnyObject {
    func didSearchAddressSuccess()
    func didSearchAddressFail()
}

class SearchViewModel {
    var arrayAddress: [Address] = []
    
    weak var delegate: SearchViewModelDelegate?
    
    func searchAddress(_ text: String) {
        var addrs: [Address] = []
        
        let address = Address(name: text, placeId: UUID().uuidString, types: [])
        addrs.append(address)
        arrayAddress = addrs
        delegate?.didSearchAddressSuccess()
    }
    
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
        return PlaceCellModel(self.address(at: indexPath))
    }
}
