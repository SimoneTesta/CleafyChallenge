//
//  ViewController.swift
//  SecureApp
//
//  Created by Simone Testa on 12/02/22.
//

import UIKit
import SecureSDK

class ViewController: UIViewController {

    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var repositoryTextField: UITextField!
    @IBOutlet weak var stargazersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stargazersTableView.dataSource = self
        dismissKeyboardOnViewTap()
        viewModel.setCategoriesListener { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                switch result {
                case .success(()):
                    self?.stargazersTableView.reloadData()
                case .failure(let error):
                    self?.showMessage(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func showMessage(title: String, message: String, confirm: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
            confirm?()
        })
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        activityIndicator.startAnimating()
        viewModel.owner = ownerTextField.text
        viewModel.repository = repositoryTextField.text
        viewModel.getStargazers()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stargazers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StargazerCellTableViewCell.identifier, for: indexPath) as? StargazerCellTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(stargazer: viewModel.stargazers[indexPath.row])
        return cell
    }
    
}


