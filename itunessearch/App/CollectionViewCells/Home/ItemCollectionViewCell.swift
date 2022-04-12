//
//  ItemCollectionViewCell.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import UIKit
import Kingfisher

final class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var ivArtwork: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(data: Result) {
        ivArtwork.kf.setImage(with: URL(string: data.artworkUrl100 ?? ""), placeholder: UIImage(named: "ic_placeholder"))
        lblName.text = data.collectionName
        lblPrice.text = "$\(data.collectionPrice ?? 0.0)"
        
        let date = data.releaseDate?.toDate()
        lblDate.text = (date?.day ?? "") + "/" + (date?.monthInNumber ?? "") + "/" + (date?.year ?? "")
    }
}
