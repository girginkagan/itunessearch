//
//  HomeViewController.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Home
    var viewModel: HomeViewModel?
    let disposeBag = DisposeBag()

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        navigationItem.title = "Search"
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.isError
            .bind { [weak self] data in
                if let errorData = data {
                    guard let self = self else { return }
                    AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: errorData))
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.isDataLoaded
            .bind { [weak self] data in
                if data {
                    guard let self = self else { return }
                    self.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex.subscribe { [weak self] event in
            if viewModel.segmentControlInit {
                DataProvider.shared.data.accept(nil)
                self?.viewModel?.wrapperType = self?.viewModel?.wrapperTypes[event.element ?? 0] ?? .movie
                self?.viewModel?.noMorePage = false
                self?.viewModel?.isLoadingList = false
                self?.viewModel?.getData()
            } else {
                viewModel.segmentControlInit = true
            }
        }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ $0.count > 2 })
            .subscribe { [weak self] event in
                viewModel.q = event.element ?? ""
                DataProvider.shared.data.accept(nil)
                self?.viewModel?.noMorePage = false
                self?.viewModel?.isLoadingList = false
                self?.viewModel?.getData()
                self?.searchBar.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.subscribe { [weak self]_ in
            self?.searchBar.endEditing(true)
        }.disposed(by: disposeBag)
        
        viewModel.setBindings()
        
        setCollectionView()
    }
}

extension HomeViewController {
    private func setCollectionView() {
        guard let viewModel = viewModel else { return }
        
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.register(UINib(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        viewModel.collectionViewDelegate.subscribe { [weak self] _ in
            if let delegate = viewModel.collectionViewDelegate.value {
                guard let self = self else { return }
                self.collectionView.rx.setDelegate(delegate).disposed(by: self.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        viewModel.items.bind(to: collectionView.rx.items(dataSource: viewModel.dataSource)).disposed(by: disposeBag)
    }
}
