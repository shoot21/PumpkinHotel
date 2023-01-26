//
//  Coordinator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start() 
}
