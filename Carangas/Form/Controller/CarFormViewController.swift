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
    
    // MARK: - Properties
    var car: Car?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        if let car = car {
            title = "Edição"
            btAddEdit.setTitle("Editar carro", for: .normal)
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType
        }
    }
    
    func checkResult(_ result: Result<Void,APIError>, withError message: String) {
        switch result {
        case .success:
            self.goBack()
        case .failure:
            Alert.show(title: "Erro", message: message, presenter: self)
        }
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        if car == nil {
            car = Car()
        }
        car?.name = tfName.text!
        car?.brand = tfBrand.text!
        car?.price = Double(tfPrice.text!) ?? 0
        car?.gasType = scGasType.selectedSegmentIndex
        
        guard let car = car else {return}
        if car._id == nil {
            CarAPI.createCar(car) { [weak self] (result) in
                DispatchQueue.main.async {
                    self?.checkResult(result, withError: "Falha ao cadastrar o carro")
                }
            }
        } else {
            CarAPI.updateCar(car) { [weak self] (result) in
                DispatchQueue.main.async {
                    self?.checkResult(result, withError: "Falha ao atualizar o carro")
                }
            }
        }
    }
}
