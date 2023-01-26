//
//  NetworkEnum .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

enum HTTPScheme: String {
    case http
    case https
    
}

enum Errors: Error {
    case invalideURL
    case invalidState
    case invalidStatusCode
}
