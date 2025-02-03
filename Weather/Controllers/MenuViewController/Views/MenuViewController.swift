import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectAddress(at index: Int)
    func didDeleteAddress(at index: Int)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuViewControllerDelegate?
    fileprivate let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCell()
        self.reloadData()
    }
    
    private func registerCell() {
        self.tableView.registerCellByNib(MenuCell.self)
    }
    
    func reloadData() {
        self.viewModel.getAllAddress()
        self.tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectAddress(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (contextualAction, view, boolValue) in
            guard let strongSelf = self else { return }
            
            boolValue(true) // pass true if you want the handler to allow the action
            strongSelf.viewModel.removeAddress(at: indexPath)
            tableView.reloadData()
            DispatchQueue.main.async {
                strongSelf.delegate?.didDeleteAddress(at: indexPath.row)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(MenuCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.configCell(model: self.viewModel.configCell(at: indexPath))
        return cell
    }
}
