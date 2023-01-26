//
//  HotelNetworkService .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import Foundation

final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        // define the url components
        guard var urlComponent = URLComponents(string: request.url) else {
            completion(.failure(Errors.invalideURL))
            return
        }
        
        // define each querry item for urlComponents
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        urlComponent.scheme = request.httpScheme.rawValue
        
        // getting url from urlComponents
        guard let url = urlComponent.url else {
            completion(.failure(Errors.invalideURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            switch (data, error) {
            case let (.some(data), nil):
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    completion(.failure(Errors.invalidStatusCode))
                    return
                }
                
                do {
                    try completion(.success(request.decode(data)))
                } catch let error {
                    completion(.failure(error))
                }
            case let (nil, .some(error)):
                completion(.failure(error))
            default:
                completion(.failure(Errors.invalidState))
            }
        }
        .resume()
    }
}
