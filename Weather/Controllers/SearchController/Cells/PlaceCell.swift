import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet private weak var placeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ model: PlaceCellModel) {
        self.placeName.text = model.name
    }
}
