//
//  DetailViewController.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.Detail
    var viewModel: DetailViewModel?
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var data: Result?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBindings()
    }
    
    private func setUI() {
        ivCover.kf.setImage(with: URL(string: data?.artworkUrl100 ?? ""), placeholder: UIImage(named: "ic_placeholder"))
        lblName.text = data?.collectionName
        lblPrice.text = "$\(data?.collectionPrice ?? 0.0)"
        
        let date = data?.releaseDate?.toDate()
        lblDate.text = (date?.day ?? "") + "/" + (date?.monthInNumber ?? "") + "/" + (date?.year ?? "")
        lblDesc.text = data?.shortDescription
    }
    
    private func setBindings() {
        guard let viewModel = viewModel else { return }
        
        guard let data = data else {
            return
        }

        viewModel.setBindings()
    }
}
