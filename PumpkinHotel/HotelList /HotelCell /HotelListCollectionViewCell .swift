//
//  HotelListCollectionViewCell .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 02.12.2022.
//

import UIKit

class HotelCell: UICollectionViewCell {
    
    // MARK: - Static Propertie
    
    static let id = "HotelCell"
    
    // MARK: - Properties
    
    var hotelCellViewModel: HotelCellViewModelProtocol! {
        didSet {
            hotelNameLabel.text = hotelCellViewModel.hotelName
            addressLabel.text = hotelCellViewModel.address
            distanceLabel.text = hotelCellViewModel.distance
            starCountLabel.text = hotelCellViewModel.starCount
            suitesAvailabilityLabel.text = hotelCellViewModel.suitesAvailability
        }
    }
    
    // MARK: - CGFloat constant
    
    private let sidePadding: CGFloat = 8
    private let systemFont20: CGFloat =  20
    private let systemFont16: CGFloat =  16
    
    // MARK: - Private properties
    
    private lazy var hotelNameLabel = UILabel(text: "",
                                              font: .boldSystemFont(ofSize: systemFont20),
                                              textColor: .hotelDarkGray)
    
    private lazy var addressLabel = UILabel(text: "",
                                            font: .systemFont(ofSize: 16),
                                            textColor: .hotelGray)
    
    private lazy var distanceLabel = UILabel(text: "",
                                             font: .systemFont(ofSize: 16),
                                             textColor: .hotelGray)
    
    // MARK: - Internal properties
    
    let starCountLabel = UILabel(text: "",
                                 font: .boldSystemFont(ofSize: 20),
                                 textColor: .hotelDarkGray)
    
    let suitesAvailabilityLabel = UILabel(text: "",
                                          font: .systemFont(ofSize: 16),
                                          textColor: .hotelGreen)
    
    let starImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "star")
        iv.clipsToBounds = true
        iv.setDimensions(width: 20, height: 20)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        Utils.shared.makeShadow(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(hotelNameLabel)
        
        hotelNameLabel.anchor(top: topAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              paddingTop: sidePadding,
                              paddingLeft: sidePadding,
                              paddingRight: sidePadding)
        
        addSubview(addressLabel)
        
        addressLabel.anchor(top: hotelNameLabel.bottomAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: sidePadding,
                            paddingLeft: sidePadding,
                            paddingRight: sidePadding)
        
        addSubview(distanceLabel)
        
        distanceLabel.anchor(top: addressLabel.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: sidePadding,
                             paddingLeft: sidePadding,
                             paddingRight: sidePadding)
        
        addSubview(starCountLabel)
        
        starCountLabel.anchor(left: leftAnchor,
                              bottom: bottomAnchor,
                              paddingLeft: sidePadding,
                              paddingBottom: sidePadding)
        
        addSubview(starImageView)
        
        starImageView.anchor(top: starCountLabel.topAnchor,
                             left: starCountLabel.rightAnchor,
                             paddingLeft: sidePadding)
        
        addSubview(suitesAvailabilityLabel)
        
        suitesAvailabilityLabel.centerY(inView: starImageView)
        suitesAvailabilityLabel.anchor(right: rightAnchor, paddingRight: sidePadding)
    }
}
