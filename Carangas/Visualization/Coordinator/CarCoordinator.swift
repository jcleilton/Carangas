//
//  CarCoordinator.swift
//  Carangas
//
//  Created by Eric Alves Brito on 09/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var carViewModel: CarViewModel
    
    init(navigationController: UINavigationController, carViewModel: CarViewModel) {
        self.navigationController = navigationController
        self.carViewModel = carViewModel
    }
    
    func start() {
        let viewController = CarViewController.instantiateFromStoryboard(.visualization)
        viewController.viewModel = carViewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("CarCoordinator deinit")
    }
}


