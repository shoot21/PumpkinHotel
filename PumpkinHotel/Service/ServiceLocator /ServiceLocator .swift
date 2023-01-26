//
//  ServiceLocator .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 26.01.2023.
//

import UIKit

protocol ServiceLocating {
    func resolve<T>() -> T?
}

final class ServiceLocator: ServiceLocating {
    
    static let shared = ServiceLocator()
    
    private lazy var services = [String: Any]()
    
    private init() {}
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func register<T>(service: T) {
        let key = typeName(T.self)
        services[key] = service
    }
    
    func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
}
