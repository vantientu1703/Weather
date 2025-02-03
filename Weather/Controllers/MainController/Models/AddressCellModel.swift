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
    
    var min: String? {
        guard let tmpl = self.address?.climate?.main?.temp_min else {
            return nil
        }
        return String(format: "%0.0f", (tmpl - 273))
    }
    
    var max: String? {
        guard let tmpl = self.address?.climate?.main?.temp_max else {
            return nil
        }
        return String(format: "%0.0f", (tmpl - 273))
    }
    
    var weather: String? {
        guard let tmpl = self.address?.climate?.weather?.first?.main else {
            return nil
        }
        return tmpl
    }
}
