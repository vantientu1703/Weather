import UIKit

class AddressCellModel {
    fileprivate var address: Address?
    
    init(_ address: Address? = nil) {
        self.address = address
    }
    
    var placeName: String? {
        return self.address?.name
    }
    
    var temp: String? {
        guard let tmpl = self.address?.climate?.main?.temp else {
            return nil
        }
        return String(format: "%0.0f", (tmpl - 273))
    }
}
