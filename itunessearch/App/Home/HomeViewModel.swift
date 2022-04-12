//
//  HomeViewModel.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewModel: BaseViewModel {
    private let services: RestClient
    var coordinator: HomeCoordinator?
    
    var q = "test"
    var loadMore = false
    var noMorePage = false
    var isLoadingList = false
    let isError = BehaviorSubject<BaseErrorModel?>(value: nil)
    let isDataLoaded = BehaviorSubject<Bool>(value: false)
    let collectionViewDelegate = BehaviorRelay<UICollectionViewDelegateFlowLayout?>(value: nil)
    let disposeBag = DisposeBag()
    var wrapperType = WrapperType.movie
    let wrapperTypes: [WrapperType] = [.movie, .music, .podcast, .ebook]
    var segmentControlInit = false
    var items = BehaviorRelay<[SectionModel<String, Result>]>(value: [])
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Result>>(
        configureCell: { (_, collectionView, indexPath, element) in
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
                cell.updateCell(data: element)
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath) as! LoadingCollectionViewCell
                cell.updateCell()
                
                return cell
            }
        }
    )
    
    init(services: RestClient) {
        self.services = services
    }
    
    func setBindings() {
        items.accept([SectionModel<String, Result>(model: "items", items: []), SectionModel<String, Result>(model: "loading", items: [Result()])])
        DataProvider.shared.data.subscribe { [weak self] event in
            var items = self?.items.value
            items?[0].items = event.element??.results ?? []
            
            if let it = items {
                self?.items.accept(it)
            }
        }.disposed(by: disposeBag)
        
        collectionViewDelegate.accept(self)
    }
    
    func getData() {
        services.getData(offset: DataProvider.shared.data.value?.results?.count ?? 0, q: q, wrapperType: wrapperType) { [weak self] data in
            if (data.results?.count ?? 0) == 0 {
                self?.noMorePage = true
            } else {
                var val = DataProvider.shared.data.value
                if val != nil {
                    val?.results?.append(contentsOf: data.results ?? [])
                    DataProvider.shared.data.accept(val)
                } else {
                    DataProvider.shared.data.accept(data)
                }
            }
            self?.isDataLoaded.onNext(true)
            self?.isDataLoaded.onNext(false)
            self?.isLoadingList = false
        } errorCompletion: { [weak self] error in
            self?.noMorePage = true
            self?.isDataLoaded.onNext(true)
            self?.isDataLoaded.onNext(false)
            self?.isLoadingList = false
        }
    }
}

extension HomeViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (UIScreen.main.bounds.size.width - 30) / 2, height: ((UIScreen.main.bounds.size.width - 30) / 2) * 1.3) //1.3 is the aspect ratio
        } else {
            return ((items.value[0].items.count < 20) || noMorePage) ? .zero : CGSize(width: UIScreen.main.bounds.size.width - 20, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.presentDetail(data: items.value[0].items[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList && !noMorePage && items.value[0].items.count > 19) {
            isLoadingList = true
            getData()
        }
    }
}
