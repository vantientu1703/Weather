import UIKit

class MenuCellModel {
    
    fileprivate var address: Address?

    init(_ address: Address? = nil) {
        self.address = address
    }
    
    var placeName: String? {
        return self.address?.name
    }
}
