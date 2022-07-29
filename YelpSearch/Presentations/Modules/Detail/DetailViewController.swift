//
//  DetailViewController.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet fileprivate weak var businessImageView: UIImageView!
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    @IBOutlet fileprivate weak var businessCategoriesCollectionView: UICollectionView!
    
    @IBOutlet fileprivate weak var businessHoursOperationCollectionView: UICollectionView!
    
    @IBOutlet fileprivate weak var businessAddressLabel: UILabel!
    
    @IBOutlet fileprivate weak var businessPhoneNumberLabel: UILabel!
    
    @IBOutlet fileprivate weak var businessRatingLabel: UILabel!
    
    private let disposedBag = DisposeBag()
    
    var viewModel: DetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI() 
        bindViewModel()
    }
    
    fileprivate func prepareUI() {
        businessImageView.layer.cornerRadius = 8.0
        navigationItem.leftBarButtonItem = nil
        configCollectionView()
    }
    
    fileprivate func configCollectionView() {
        let tagCollectionCellSize = CGSize(width: 100, height: 30)
        businessCategoriesCollectionView.register(UINib(nibName: TagCollectionViewCell.reuseID, bundle: nibBundle),
                                                  forCellWithReuseIdentifier: TagCollectionViewCell.reuseID)
        
        businessHoursOperationCollectionView.register(UINib(nibName: TagCollectionViewCell.reuseID, bundle: nibBundle),
                                                  forCellWithReuseIdentifier: TagCollectionViewCell.reuseID)
        
        if let layout = businessCategoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = tagCollectionCellSize
        }
        
        if let layout = businessHoursOperationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = tagCollectionCellSize
        }
        
        
    }
    
    fileprivate func bindViewModel() {
        let output = viewModel.output
        
        let businessData = output
            .onUpdateDetailBusiness
 
        businessData
            .compactMap { URL(string: $0.imageUrl ?? "") }
            .bind(to: businessImageView.kf.rx.image())
            .disposed(by: disposedBag)
        
       let name = businessData
            .map { $0.name }
            
        name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposedBag)
        
        name
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposedBag)
        
        businessData
            .map { $0.location?.description }
            .bind(to: businessAddressLabel.rx.text)
            .disposed(by: disposedBag)
        
        businessData
            .map { $0.phoneNumber }
            .bind(to: businessPhoneNumberLabel.rx.text)
            .disposed(by: disposedBag)
        
        businessData
            .map { "\($0.rating ?? 0.0)"}
            .bind(to: businessRatingLabel.rx.text)
            .disposed(by: disposedBag)
        
        businessData
            .compactMap { $0.categories }
            .bind(to: businessCategoriesCollectionView.rx.items(cellIdentifier: TagCollectionViewCell.reuseID, cellType: TagCollectionViewCell.self)) { index, viewModel, cell in
            cell.bind(viewModel.title ?? "")
        }
            .disposed(by: disposedBag)
        
        output
            .onUpdateOpenHours
            .bind(to: businessHoursOperationCollectionView.rx.items(cellIdentifier: TagCollectionViewCell.reuseID, cellType: TagCollectionViewCell.self)) { index, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposedBag)
    }

}
