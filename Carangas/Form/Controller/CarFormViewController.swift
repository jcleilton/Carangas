//
//  AddEditViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarFormViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
    }
}
