//
//  ViewController.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    @IBOutlet fileprivate weak var searchOptionsSegment: UISegmentedControl!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var businessTableView: UITableView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var searchCityTextField: UITextField!
    
    var viewModel: SearchViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()        
        bindViewModel()
    }
    
    fileprivate func prepareUI() {
        navigationItem.title = "Search Business"
        configTableView()
        configSortOptionSegment()
    }
    
    fileprivate func configTableView() {
        businessTableView.register(UINib(nibName: BusinessTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: BusinessTableViewCell.reuseID)
        businessTableView.estimatedRowHeight = 64
        businessTableView.rowHeight = UITableView.automaticDimension
        businessTableView.separatorInset = .zero
        businessTableView.keyboardDismissMode = .onDrag
    }
    
    fileprivate func configSortOptionSegment() {
        searchOptionsSegment.setTitle(BusinessSearchSortedOptions.distance.rawValue, forSegmentAt: 0)
        searchOptionsSegment.setTitle(BusinessSearchSortedOptions.rating.rawValue, forSegmentAt: 1)
    }
    
    fileprivate func bindViewModel() {
        
        let input = viewModel.input
        let output = viewModel.output
//        Output
        output
            .businesses
            .asDriverOnErrorJustComplete()
            .drive(businessTableView.rx.items(cellIdentifier: BusinessTableViewCell.reuseID, cellType: BusinessTableViewCell.self)) { index, viewModel, cell in
                cell.bind(viewModel)
            }.disposed(by: disposeBag)
        
        output
            .trackingActivity
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.error.drive(onNext: {
            print($0.localizedDescription)
        })
        .disposed(by: disposeBag)
        
//        Input
        
        let searchText = searchBar
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
        
        let searchCity = searchCityTextField
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
        
        let sortedOption = searchOptionsSegment
            .rx
            .selectedSegmentIndex
            .distinctUntilChanged()
        
        Observable
            .combineLatest(searchText, searchCity, sortedOption) {
             ($0, $1, $2)
        }
        .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
        .bind(to: input.businessSearch)
        .disposed(by: disposeBag)
                
        businessTableView
            .rx
            .contentOffset          
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { _ in
                return self.businessTableView.isNearBottomEdge() ? Observable.just(()) : .empty()
            }
            .bind(to: input.loadMore)
            .disposed(by: disposeBag)
            
        businessTableView
            .rx
            .modelSelected(BusinessCellViewModel.self)
            .map { $0.business }
            .bind(to: input.onDetailBusiness)
            .disposed(by: disposeBag)
            
    }


}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
