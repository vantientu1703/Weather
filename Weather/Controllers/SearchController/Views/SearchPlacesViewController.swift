import UIKit
import GooglePlaces

class SearchPlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SearchViewModel()
    var didSelectPlace: ((_ address: Address?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerCell()
        self.configViewModel()
        tableView.isHidden = true
        view.backgroundColor = .clear
    }
    
    private func configViewModel() {
        self.viewModel.delegate = self
    }
    
    private func registerCell() {
        self.tableView.registerCellByNib(PlaceCell.self)
    }
    
    func searchAddress(text: String) {
        self.viewModel.searchAddress(text)
        self.dismiss(animated: false, completion: nil)
    }
}

extension SearchPlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectPlace?(self.viewModel.address(at: indexPath))
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchPlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(PlaceCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.configCell(self.viewModel.configCell(at: indexPath))
        return cell
    }
}

extension SearchPlacesViewController: SearchViewModelDelegate {
    func didSearchAddressSuccess() {
//        self.tableView.reloadData()
        if let last = self.viewModel.arrayAddress.last {
            self.didSelectPlace?(last)
        }
    }
    
    func didSearchAddressFail() {
        
    }
}
