//
//  DataManager.swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 08.12.2022.
//

import Foundation

class DataManager {
    
    private let userDefaults = UserDefaults()
        
    func setFavouriteStatus(for hotelName: String, with status: Bool) {
        userDefaults.set(status, forKey: hotelName)
    }
    
    func getFavouriteStatus(for hotelName: String) -> Bool {
        userDefaults.bool(forKey: hotelName)
    }
}
