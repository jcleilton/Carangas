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
    var car: Car?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let car = car {
            title = car.name
            lbBrand.text = car.brand
            lbGasType.text = car.fuel
            lbPrice.text = car.formattedPrice
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carFormViewController = segue.destination as? CarFormViewController {
            carFormViewController.car = car
        }
    }
}
