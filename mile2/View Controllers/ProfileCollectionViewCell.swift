//
//  ProfileCollectionViewCell.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-09-26.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "ProfileCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage){
        imageView.image = image
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
    }
}
