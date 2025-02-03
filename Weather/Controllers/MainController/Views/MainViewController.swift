import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didTouchToggleMenu()
    func didAddAddress()
}

class MainViewController: BaseViewController {

    @IBOutlet weak var scrollView: CustomScrollView!
    let viewModel = MainViewModel()
    
    fileprivate let searchPlacesViewController: SearchPlacesViewController? = SearchPlacesViewController.fromStoryboard(UIStoryboard.StoryboardName.search)
    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configView()
        self.configViewModel()
    }
    
    private func configViewModel() {
        self.viewModel.delegate = self
        self.viewModel.getPlaces()
        self.scrollView.reloadData()
        self.viewModel.getClimates()
        if viewModel.arrayAddress.isEmpty {
            showSearchController()
        }
    }
    
    private func configView() {
        self.scrollView.kDelegate = self
        self.scrollView.dataSource = self
    }
    
    func selectAddress(at index: Int) {
        self.scrollView.scrollTo(at: index)
    }
    
    func deleteAddress(at index: Int) {
        self.viewModel.removeAddress(at: index)
        self.scrollView.reloadData()
    }
    
    @IBAction func menuAction(_ sender: Any) {
        delegate?.didTouchToggleMenu()
    }
    
    @IBAction func addAction(_ sender: Any) {
        showSearchController()
    }
    
}

extension MainViewController: CustomScrollViewDelegate {
    func scrollView(_ scrollView: CustomScrollView, didScrollToAt index: Int) {
        
    }
}

extension MainViewController: CustomScrollViewDataSource {
    func numberOfRows() -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func scrollView(_ scrollView: CustomScrollView, cellForRowAt index: Int) -> UIView {
        guard let addressCell = AddressCell.fromNib() else {
            return UIView()
        }
        
        addressCell.addAddressAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showSearchController()
        }
        
        addressCell.showOrHideMenu = {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didTouchToggleMenu()
        }
        addressCell.configCell(model: self.viewModel.configCell(at: index))
        return addressCell
    }
    
    private func showSearchController() {
        let searchController = UISearchController(searchResultsController: self.searchPlacesViewController)
        searchController.searchBar.delegate = self
        searchController.view.backgroundColor = .clear
        self.present(searchController, animated: true, completion: nil)
        
        self.searchPlacesViewController?.didSelectPlace = {[weak self] address in
            guard let strongSelf = self else { return }
            address?.toRAddress().add()
            guard let address = RAddress.getAddress(placeId: address?.placeId) else { return }
            strongSelf.viewModel.append(address: address)
            strongSelf.scrollView.reloadData()
            DispatchQueue.main.async {
                strongSelf.delegate?.didAddAddress()
                strongSelf.viewModel.getClimate(at: strongSelf.viewModel.arrayAddress.count - 1)
                strongSelf.scrollView.scrollTo(at: strongSelf.viewModel.numberOfRows() - 1)
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPlacesViewController?.searchAddress(text: searchBar.text ?? "")
    }
}

extension MainViewController: MainViewModelDelegate {
    func didLoadClimateSuccess(at index: Int) {
        guard let cell = self.scrollView.cellForRow(at: index) as? AddressCell else {
            return
        }
        cell.configCell(model: self.viewModel.configCell(at: index))
    }
}
