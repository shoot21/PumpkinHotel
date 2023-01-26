//
//  HotelListConfigurator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

final class HotelListConfigurator {
    
    static func createHotelList(serviceLocator: ServiceLocating, navigationController: UINavigationController) -> UIViewController {
        let viewController = HotelListViewController()
        let userService: DefaultNetworkService = serviceLocator.resolve()!
        let viewModel = HotelListViewModel(userService: userService)
        let coordinator = HotelListCoordinator(navigationController: navigationController)
        viewController.hotelListViewModel = viewModel
        viewModel.coordinator = coordinator
        return viewController
    }
}
