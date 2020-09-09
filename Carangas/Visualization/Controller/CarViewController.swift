//
//  CarViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    // MARK: - Properties
    var viewModel: CarViewModel?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewModel = viewModel {
            title = viewModel.title
            lbBrand.text = viewModel.brand
            lbGasType.text = viewModel.fuelType
            lbPrice.text = viewModel.price
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let carFormViewController = segue.destination as? CarFormViewController else {return}
        carFormViewController.viewModel = viewModel?.getCarFormViewModel()
    }
}
