//
//  HotelCellViewModel .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 07.12.2022.
//

import Foundation

// MARK: - Protocols

protocol HotelCellViewModelProtocol {
    var hotelName: String { get }
    var address: String { get }
    var distance: String { get }
    var starCount: String { get }
    var suitesAvailability: String { get }
    
    init(hotel: Hotel)
}

class HotelCellViewModel: HotelCellViewModelProtocol {
    
    // MARK: - Private properties
    
    private var hotel: Hotel
    
    // MARK: - Internal properties

    var hotelName: String {
        hotel.name
    }
    
    var address: String {
        hotel.address.capitalized
    }
    
    var distance: String {
        "Distance from center: \(hotel.distance)"
    }
    
    var starCount: String {
        "\(Float(hotel.stars))"
    }
    
    var suitesAvailability: String {
        "Suites Availability: \(Utils.shared.calculateSuites(suites: hotel.suitesAvailability).count) suites"
    }
    
    // MARK: - Init 
    
    required init(hotel: Hotel) {
        self.hotel = hotel
    }
}
