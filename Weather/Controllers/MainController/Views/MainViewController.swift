//
//  ViewController.swift
//  Weather
//
//  Created by Humaxvina on 8/7/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var scrollView: CustomScrollView!
    let viewModel = MainViewModel()
    
    fileprivate let searchPlacesViewController: SearchPlacesViewController? = SearchPlacesViewController.fromStoryboard(UIStoryboard.StoryboardName.search)
    
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
    }
    
    private func configView() {
        self.scrollView.kDelegate = self
        self.scrollView.dataSource = self
    }
}

extension MainViewController: CustomScrollViewDelegate {
    func scrollView(_ scrollView: CustomScrollView, didScrollToAt index: Int) {
        
    }
}

extension MainViewController: CustomScrollViewDataSource {
    func numberOfRows() -> Int {
        return self.viewModel.numberOfRows() + 1
    }
    
    func scrollView(_ scrollView: CustomScrollView, cellForRowAt index: Int) -> UIView {
        guard let addressCell = AddressCell.fromNib() else {
            return UIView()
        }
        if index == self.viewModel.numberOfRows() {
            if let noDataView = NoDataView.fromNib() {
                noDataView.addAddressAction = { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.showSearchController()
                }
                return noDataView
            }
        } else {
            addressCell.addAddressAction = { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.showSearchController()
            }
            
            addressCell.showOrHideMenu = {
                AppDelegate.delegate?.slideMenuVC.toggleMenu()
            }
            addressCell.configCell(model: self.viewModel.configCell(at: index))
            return addressCell
        }
        return UIView()
    }
    
    private func showSearchController() {
        let searchController = UISearchController(searchResultsController: self.searchPlacesViewController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)
        
        self.searchPlacesViewController?.didSelectPlace = {[weak self] address in
            guard let strongSelf = self else { return }
            guard let address = address else { return }
            address.toRAddress().add()
            strongSelf.viewModel.append(address: address)
            strongSelf.scrollView.reloadData()
            DispatchQueue.main.async {
                strongSelf.viewModel.getClimate(at: strongSelf.viewModel.arrayAddress.count - 1)
                strongSelf.scrollView.scrollTo(at: strongSelf.viewModel.numberOfRows() - 1)
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchAddress(searchText)
    }
}

extension MainViewController: MainViewModelDelegate {
    func didLoadClimateSuccess(at index: Int) {
        guard let cell = self.scrollView.cellForRow(at: index) as? AddressCell else {
            return
        }
        cell.configCell(model: self.viewModel.configCell(at: index))
    }
    
    func didSearchAddressSuccess(_ arrayAddress: [Address]) {
        self.searchPlacesViewController?.reloadData(arrayAddress)
    }
    
    func didSearchAddressFail() {
        
    }
}
