//
//  CarFormViewModel.swift
//  Carangas
//
//  Created by Cleilton Feitosa on 08/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

protocol CarFormViewModelDelegate: class {
    func onCarCreated(result: Result<Void,APIError>)
    func onCarUpdated(result: Result<Void,APIError>)
}

class CarFormViewModel {
    private var car: Car
    weak var delegate: CarFormViewModelDelegate?
    
    init(car: Car? = nil) {
        self.car = car ?? Car()
    }
    
    private var isEditing: Bool {
        car._id != nil
    }
    
    var name: String {
        car.name
    }
    
    var brand: String {
        car.brand
    }
    
    var title: String {
        !isEditing ? "Cadastro" : "Edição"
    }
    
    var buttonTitle: String {
        !isEditing ? "Cadastrar carro" : "Alterar carro"
    }
    
    var fuelIndex: Int {
        car.gasType
    }
    
    var price: String {
        Formatter.decimalFormatter.string(from: NSNumber(value: car.price)) ?? "0,00"
    }
    
    func saveCar(
        name: String,
        brand: String,
        gasType: Int,
        price: String
    ) {
        car.name = name
        car.brand = brand
        car.gasType = gasType
        car.price = Formatter.decimalFormatter.number(from: price)?.doubleValue ?? 0.0
        if isEditing {
            CarAPI.updateCar(car) { [weak self] (result) in
                self?.delegate?.onCarUpdated(result: result)
            }
        } else {
            CarAPI.createCar(car) { [weak self] (result) in
                self?.delegate?.onCarCreated(result: result)
            }
        }
    }
}
