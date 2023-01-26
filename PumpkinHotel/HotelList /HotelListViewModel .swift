//
//  HotelListViewModel .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 07.12.2022.
//

import Foundation

// MARK: - Enums

enum SortState: CaseIterable {
    case defaultState
    case distanceState
    case suitesState
}

// MARK: - Protocols 

protocol HotelListViewModelProtocol {
    var buttonStateName: Box<String> { get }
    
    var onSelect: (Hotel) -> Void { get set }
    
    func fetchHotels(completion: @escaping () -> ())
    func numberOfRows() -> Int
    
    func sortButtonPressed()
    
    func hotelCellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol
    
    func didSelectRow(at indexPath: IndexPath)
}

final class HotelListViewModel: HotelListViewModelProtocol {
    
    // MARK: - Private properties
    
    private var hotels: [Hotel] = []

    private var defaultOrderHotels: [Hotel] = []
    
    private var buttonStateCounter = 0 {
        didSet {
            switch self.buttonStateCounter {
            case 0:
                buttonState = .defaultState
                buttonStateName.value =  "Sort by distance ⬇️"
            case 1:
                buttonState = .distanceState
                buttonStateName.value = "Sort by suites ⬆️"
            case 2:
                buttonState = .suitesState
                buttonStateName.value = "Sort by default"
            default:
                break
            }
        }
    }
    
    private let userService: DefaultNetworkService
    
    private var buttonState: SortState = .defaultState {
        didSet {
            switch self.buttonState {
            case .defaultState:
                hotels = defaultOrderHotels
            case .distanceState:
                hotels = hotels.sorted {$0.distance < $1.distance}
            case .suitesState:
                hotels = hotels.sorted {
                    Utils.shared.calculateSuites(suites: $0.suitesAvailability).count >
                    Utils.shared.calculateSuites(suites: $1.suitesAvailability).count
                }
            }
        }
    }
    
    private let buttonStateList = SortState.allCases
    
    // MARK: - Internal properties
    
    var coordinator: HotelListCoordinator? 
    
    var buttonStateName: Box<String> = Box("Sort by distance ⬇️")
    
    var onSelect: (Hotel) -> Void = { _ in }
    
    var viewModelDidChange: ((HotelListViewModelProtocol) -> ())?
    
    // MARK: - Init
    
    init(userService: DefaultNetworkService) {
        self.userService = userService
    }
    
    // MARK: - Methods
    
    func fetchHotels(completion: @escaping () -> ()) {
        let request = HotelRequest()
       
       userService.request(request) { [unowned self] result in
            switch result {
            case .success(let hotels):
                self.hotels = hotels
                self.defaultOrderHotels = hotels
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        hotels.count
    }
    
    func sortButtonPressed() {
        buttonStateCounter += 1
        
        if buttonStateCounter == buttonStateList.count {
            buttonStateCounter = 0
        }
        
        
    }
    
    func hotelCellViewModel(at indexPath: IndexPath) -> HotelCellViewModelProtocol {
        HotelCellViewModel(hotel: hotels[indexPath.item])
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator?.onSelect(hotels[indexPath.item])
    }
}
