//
//  Utils.swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 06.12.2022.
//

import UIKit

class Utils {
    
    static let shared = Utils()
    
    private init() {}
    
    func createButton(withTitle title: String, titleColor: UIColor, bgColor: UIColor, titleFont: UIFont = .systemFont(ofSize: 16)) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.backgroundColor = bgColor
        
            
            button.layer.cornerRadius = 16
            button.titleLabel?.font = titleFont
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
    
    func makeShadow(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 0.047, green: 0.102,
                                    blue: 0.294, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func calculateSuites(suites: String) -> [String] {
        let array = suites.components(separatedBy: ":")
        let filtered = array.filter { $0 != "" }
        
        return filtered
    }
    
    func cropImage(sourceImage: UIImage?) -> UIImage {
        guard let sourceImage = sourceImage else {
            return UIImage()
        }

        let sourceSize = sourceImage.size
        let xOffset: CGFloat = 1
        let yOffset: CGFloat = 1
        
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sourceSize.width - xOffset * 2,
            height: sourceSize.height - yOffset * 2
        ).integral
        
        guard let sourceCGImage = sourceImage.cgImage else { return UIImage() }
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: sourceImage.imageRendererFormat.scale,
            orientation: sourceImage.imageOrientation
        )
        
        return croppedImage
    }
}
