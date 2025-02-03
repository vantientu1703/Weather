import UIKit

class PlaceCellModel {
    
    fileprivate var place: Address?
    
    init(_ address: Address? = nil) {
        self.place = address
    }
    
    var name: String? {
        return self.place?.name
    }
}
