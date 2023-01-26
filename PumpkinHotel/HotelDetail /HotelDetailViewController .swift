//
//  HotelDetailViewController .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 04.12.2022.
//

import UIKit

class HotelDetailViewController: UIViewController {
    
    // MARK: - CGFloat constant 
    
    private let padding: CGFloat = 8
    private let cornerRadius: CGFloat = 10
    private let systemFont16: CGFloat =  16
    private let systemFont21: CGFloat =  21
    private let systemFont26: CGFloat =  26
    private let imageViewHeight: CGFloat = 200
    private let favouriteButtonDim: CGFloat = 50
    
    // MARK: - Private properties
    
    private lazy var hotelImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .hotelLightPurple
        iv.clipsToBounds = true
        iv.layer.cornerRadius = cornerRadius
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var activityIndicator: UIActivityIndicatorView?

    private lazy var hotelNameLabel = UILabel(text: "",
                                         font: .boldSystemFont(ofSize: FS.s(systemFont26)),
                                 textColor: .hotelDarkGray)
    
    private lazy var addressLabel = UILabel(text: "",
                                       font: .systemFont(ofSize: FS.s(systemFont21)),
                                       textColor: .hotelGray)
    
    private lazy var distanceLabel = UILabel(text: "",
                                             font: .systemFont(ofSize: FS.s(systemFont16)),
                                             textColor: .hotelGray)
    
    private lazy var suitesLabel = UILabel(text: "",
                                           font: .systemFont(ofSize: FS.s(systemFont16)),
                                           textColor: .hotelGreen)
    
    private lazy var favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        button.setDimensions(width: favouriteButtonDim, height: favouriteButtonDim)
        return button
    }()
    
    // MARK: - Properties
    
    var hotelDetailViewModel: HotelDetailViewModelProtocol! {
        didSet {
            hotelDetailViewModel.fetchHotelDetail { [weak self] imageData in
                self?.activityIndicator?.stopAnimating()
                guard let imageData = imageData else {
                    self?.hotelImageView.image = UIImage(named: "hotel")
                    self?.hotelImageView.contentMode = .scaleAspectFit
                    return
                }
                
                let cropedImage = Utils.shared.cropImage(sourceImage: UIImage(data: imageData))
                self?.hotelImageView.image = cropedImage
            }
            
            hotelNameLabel.text = hotelDetailViewModel.hotelName
            addressLabel.text = hotelDetailViewModel.address
            distanceLabel.text = hotelDetailViewModel.distance
            suitesLabel.text = hotelDetailViewModel.suitesAvailability
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        activityIndicator = showActivityIndicator(in: hotelImageView)
    }
    
    // MARK: - Selectors
    
    @objc private func favouriteButtonPressed() {
        hotelDetailViewModel.favouriteButtonPressed()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .hotelBgColor
        
        setStatusForFavouriteButton(hotelDetailViewModel.isFavourite.value)
        
        hotelDetailViewModel.isFavourite.bind { [unowned self] value in
            setStatusForFavouriteButton(value)
        }
        
        view.addSubview(hotelImageView)
   
        hotelImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: CGFloat(2) * padding,
                              paddingLeft: padding,
                              paddingRight: padding,
                              height: imageViewHeight)
        
        view.addSubview(hotelNameLabel)
        
        hotelNameLabel.anchor(top: hotelImageView.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: CGFloat(2) * padding,
                              paddingLeft: padding,
                              paddingRight: padding)
        
        view.addSubview(addressLabel)
        
        addressLabel.anchor(top: hotelNameLabel.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            paddingTop: CGFloat(2) * padding,
                            paddingLeft: padding,
                            paddingRight: padding)
        
        view.addSubview(distanceLabel)
        
        distanceLabel.anchor(top: addressLabel.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor, paddingTop: CGFloat(2) * padding,
                             paddingLeft: padding,
                             paddingRight: padding)
        
        view.addSubview(suitesLabel)
        
        suitesLabel.anchor(top: distanceLabel.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: CGFloat(2) * padding,
                           paddingLeft: padding,
                           paddingRight: padding)
        
        view.addSubview(favouriteButton)
        
        favouriteButton.anchor(bottom: hotelImageView.bottomAnchor,
                               right: hotelImageView.rightAnchor)
    }
    
    private func setStatusForFavouriteButton(_ status: Bool) {
        favouriteButton.tintColor = status ? .red : .white
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .hotelDarkGray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.center(inView: view)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
