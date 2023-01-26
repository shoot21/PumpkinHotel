//
//  ApplicationCoordinator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

class ApplicationCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let hotelListCoordinator = HotelListCoordinator(navigationController: navigationController)
        
        hotelListCoordinator.start()
        
        childCoordinators.append(hotelListCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
