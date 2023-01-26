//
//  HotelDetailConfigurator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

final class HotelDetailConfigurator {
    
    static func createHotelDetail(hotel: Hotel, serviceLocator: ServiceLocating) -> UIViewController {
        
        let viewController = HotelDetailViewController()
        
        let networkService: DefaultNetworkService = serviceLocator.resolve()!
        let imageService: ImageManager = serviceLocator.resolve()!
        let dataService: DataManager = serviceLocator.resolve()!
        
        let viewModel = HotelDetailViewModel(hotel: hotel,
                                             imageService: imageService,
                                             dataService: dataService,
                                             networkService: networkService)
                
        viewController.hotelDetailViewModel = viewModel
        return viewController
    }
}
