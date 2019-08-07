//
//  SearchAddressViewController.swift
//  Weather
//
//  Created by Humaxvina on 8/7/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

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
    }
    
    private func registerCell() {
        self.tableView.registerCellByNib(PlaceCell.self)
    }
    
    func reloadData(_ arrayAddress: [Address]) {
        self.viewModel.arrayAddress = arrayAddress
        self.tableView.reloadData()
    }
}

extension SearchPlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectPlace?(self.viewModel.address(at: indexPath))
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
