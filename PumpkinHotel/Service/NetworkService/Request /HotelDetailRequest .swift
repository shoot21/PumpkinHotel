//
//  HotelDetailRequest .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import Foundation

struct HotelDetailRequest: DataRequest {
    
    private let hotelID: Int
    
    var url: String {
        let baseURL: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master"
        let path: String = "/\(hotelID).json"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var httpScheme: HTTPScheme {
        .https
    }
    
    init(hotelID: Int) {
        self.hotelID = hotelID
    }
    
    func decode(_ data: Data) throws -> HotelDetail {
        let decoder = JSONDecoder()
        let response = try decoder.decode(HotelDetail.self, from: data)
        return response
    }
}
