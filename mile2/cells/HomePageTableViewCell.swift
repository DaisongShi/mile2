//
//  HomePageTableViewCell.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-09-23.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var fileImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var replyBtn: UIButton!
    
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var postTxt: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
