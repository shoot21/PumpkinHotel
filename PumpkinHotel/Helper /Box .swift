//
//  Box .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 07.12.2022.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
