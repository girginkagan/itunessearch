//
//  LoadingCollectionViewCell.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell() {
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }
}
