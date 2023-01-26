//
//  HotelListCoordinator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

final class HotelListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let hotelListViewController = HotelListConfigurator.createHotelList(
            serviceLocator: ServiceLocator.shared,
            navigationController: navigationController
        )
        navigationController.setViewControllers([hotelListViewController],
                                                animated: false)
    }
    
    func onSelect(_ hotel: Hotel) {
        let hotelDetailCoordinator = HotelDetailCoordinator(
            hotel: hotel,
            navigationController: navigationController)
        
        childCoordinators.append(hotelDetailCoordinator)
        hotelDetailCoordinator.start()
    }
}
