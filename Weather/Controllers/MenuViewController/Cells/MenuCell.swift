import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(model: MenuCellModel) {
        self.placeNameLabel.text = model.placeName
    }
}
