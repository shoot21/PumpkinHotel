//
//  Hotel .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import Foundation

// TODO: Look how to optimize

struct Hotel: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Int
    let distance: Double
    let suitesAvailability: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }
}

struct HotelDetail: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Int
    let distance: Double
    let image: String?
    let suitesAvailability: String
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance, image
        case suitesAvailability = "suites_availability"
        case lat, lon
    }
}
