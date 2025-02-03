import UIKit

class NoDataView: UIView {
    
    var addAddressAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func noDataAction(_ sender: Any) {
        self.addAddressAction?()
    }
}
