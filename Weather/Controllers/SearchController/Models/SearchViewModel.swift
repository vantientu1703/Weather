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
        let client = GMSPlacesClient.shared()
        client.findAutocompletePredictions(fromQuery: text, filter: nil, sessionToken: nil) { [weak self] results, error in
            guard let strongSelf = self else {
                return
            }
            print("error \(error?.localizedDescription ?? "")")
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
                strongSelf.arrayAddress = addrs
                strongSelf.delegate?.didSearchAddressSuccess()
            }
        }
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
