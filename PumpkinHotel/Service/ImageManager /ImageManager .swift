//
//  ImageManager .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 07.12.2022.
//

import Foundation

class ImageManager {
    
    func fetchImageData(with imageId: String) -> Data? {
        guard let url = URL(
            string: "https://github.com/iMofas/ios-android-test/raw/master/\(imageId)"
        ) else { return nil }
        
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
