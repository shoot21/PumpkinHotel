//
//  HotelDetailCoordinator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

final class HotelDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let hotel: Hotel
    
    init(hotel: Hotel, navigationController: UINavigationController) {
        self.hotel = hotel
        self.navigationController = navigationController
    }
    
    func start() {
        let hotelDetailViewController = HotelDetailConfigurator.createHotelDetail(
            hotel: hotel,
            serviceLocator: ServiceLocator.shared
        )
        navigationController.pushViewController(hotelDetailViewController, animated: true)
    }
}
