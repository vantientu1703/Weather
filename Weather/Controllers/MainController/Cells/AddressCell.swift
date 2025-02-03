import UIKit

class AddressCell: UIView {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var hightLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    
    var addAddressAction: (() -> ())?
    var showOrHideMenu: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: AddressCellModel) {
        self.placeNameLabel.text = model.placeName
        self.placeNameLabel.sizeToFit()
        self.tmpLabel.text = "\(model.temp ?? "")°"
        self.hightLabel.text = "H: \(model.max ?? "")°"
        self.lowLabel.text = "L: \(model.min ?? "")°"
        self.cloudLabel.text = "\(model.weather ?? "")"
        let index = Int.random(in: 0...10)
        self.backgroundImageView.image = UIImage(named: "\(index)")
    }
    
    @IBAction func addAddressAction(_ sender: Any) {
        self.addAddressAction?()
    }
    
    
    @IBAction func menuAction(_ sender: Any) {
        self.showOrHideMenu?()
    }
}
