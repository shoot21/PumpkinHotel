//
//  HotelDetailViewModel .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 07.12.2022.
//

import Foundation

protocol HotelDetailViewModelProtocol {
    
    var hotelName: String { get }
    var address: String { get }
    var distance: String { get }
    var suitesAvailability: String { get }
    var isFavourite: Box<Bool> { get }
    
    func fetchHotelDetail(completion: @escaping (Data?) -> ())
    func favouriteButtonPressed()
    
    init(hotel: Hotel,
         imageService: ImageManager,
         dataService: DataManager,
         networkService: DefaultNetworkService)
}

final class HotelDetailViewModel: HotelDetailViewModelProtocol {
    
    // MARK: - Private properties
    
    private var hotel: Hotel
    
    private let imageService: ImageManager
    private let dataService: DataManager
    private let networkService: DefaultNetworkService
    
    // MARK: - Internal properties
    
    var hotelName: String {
        hotel.name
    }
    
    var address: String {
        hotel.address.capitalized
    }
    
    var distance: String {
        "Distansce from center: \(hotel.distance)"
    }
    
    var isFavourite: Box<Bool>
    
    var suitesAvailability: String {
        var suitesString = "Suites Availability: "
        
        let stringArray = Utils.shared.calculateSuites(suites: hotel.suitesAvailability)
        
        stringArray.forEach { suitesString.append("\($0), ") }
        suitesString.removeLast(2)
        
        return suitesString
    }
    
    // MARK: - Init
    
    required init(hotel: Hotel,
                  imageService: ImageManager,
                  dataService: DataManager,
                  networkService: DefaultNetworkService) {
        self.hotel = hotel
        
        self.imageService = imageService
        self.dataService = dataService
        self.networkService = networkService
        
        isFavourite = Box(self.dataService.getFavouriteStatus(for: hotel.name))
    }
    
    // MARK: - Methods
    
    func favouriteButtonPressed() {
        isFavourite.value.toggle()
        
        dataService.setFavouriteStatus(for: hotel.name, with: isFavourite.value)
    }
        
    func fetchHotelDetail(completion: @escaping (Data?) -> ()) {
        let request = HotelDetailRequest(hotelID: hotel.id)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let data):
                guard let imageId = data.image else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                let imageData = self?.imageService.fetchImageData(with: imageId)
                DispatchQueue.main.async {
                    completion(imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
