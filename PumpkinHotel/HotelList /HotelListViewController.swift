//
//  ViewController.swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import UIKit

class HotelListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let padding: CGFloat = 8
    
    var hotelListViewModel: HotelListViewModelProtocol! {
        didSet {
            hotelListViewModel.fetchHotels { [unowned self] in
                self.collectionView.reloadData()
                self.activityIndicator?.stopAnimating()
                self.sortButton.isUserInteractionEnabled = true 
            }
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var collectionView: UICollectionView!

    private lazy var sortButton: UIButton = {
        let button = Utils.shared.createButton(withTitle: "",
                                          titleColor: .white,
                                          bgColor: .hotelPurple)
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = showActivityIndicator(in: view)
        setupCollectionView()
        setupNavigationBar()
        configureUI()
    }
    
    // MARK: - Selectors
     
    @objc private func sortButtonPressed() {
        hotelListViewModel.sortButtonPressed()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                          at: .bottom,
                                          animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .hotelBgColor
        
        view.addSubview(collectionView)
        
        collectionView.addConstraintsToFillView(view)
        
        view.addSubview(sortButton)
        
        sortButton.setDimensions(width: UIScreen.main.bounds.width / 2,
                                 height: 50)
        sortButton.centerX(inView: view)
        sortButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: padding)
        
        hotelListViewModel.buttonStateName.bind { [unowned self] stateName in
            self.collectionView.reloadData()
            self.sortButton.setTitle(stateName, for: .normal)
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(
            HotelCell.self,
            forCellWithReuseIdentifier: HotelCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [unowned self] sectionNumber, _ in
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .fractionalHeight(1.0)))
            item.contentInsets.trailing = CGFloat(2) * self.padding
            item.contentInsets.bottom = CGFloat(2) * self.padding
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .estimated(175)),
                subitems: [item]
            )
            group.contentInsets.leading = CGFloat(2) * self.padding
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 10
            section.contentInsets.bottom = 50

            return section
        }
    }

    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .hotelDarkGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Hotels"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .hotelPurple
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
}

// MARK: - UICollectionViewDataSource

extension HotelListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hotelListViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HotelCell.id,
            for: indexPath
        ) as? HotelCell else { return UICollectionViewCell() }
        
        cell.hotelCellViewModel = hotelListViewModel.hotelCellViewModel(at: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HotelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hotelListViewModel.didSelectRow(at: indexPath)
    }
}
