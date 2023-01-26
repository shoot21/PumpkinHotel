//
//  HotelRequest .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import Foundation

struct HotelRequest: DataRequest {
    
    var url: String {
        let baseURL: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master"
        let path: String = "/0777.json"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var httpScheme: HTTPScheme {
        .https
    }
    
    func decode(_ data: Data) throws -> [Hotel] {
        let decoder = JSONDecoder()
        let response = try decoder.decode([Hotel].self, from: data)
        return response
    }
}
