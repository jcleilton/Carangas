//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel: CarsListingViewModel = CarsListingViewModel()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.carsDidUpdate = self.carsDidUpdate
        refreshControl?.addTarget(self, action: #selector(self.loadCars), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let carViewController as CarViewController:
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            carViewController.viewModel = viewModel.getCarViewModelFor(indexPath: indexPath)
        case let carFormViewController as CarFormViewController:
            carFormViewController.viewModel = CarFormViewModel()
        default:
            break
        }
    }
    
    func carsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Methods
    @objc func loadCars() {
        viewModel.loadCars()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CarTableViewCell {
            cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath))
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCar(at: indexPath) { result in
                switch result {
                case .success:
                    break
                case .failure:
                    Alert.show(title: "Erro", message: "Não foi possível excluir o carro.", presenter: self)
                }
            }
        }
    }
}
