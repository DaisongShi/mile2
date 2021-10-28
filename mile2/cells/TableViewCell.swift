//
//  TableViewCell.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-04-21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    
    func configureCell(user: User) {
        nameLabel.text = user.username
        titleLabel.text = user.titleInput
        if let profileImageUrl = user.profileImage {
            let url = URL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.userImg.image = UIImage(data: data!)
                }
            }).resume()
        }
        
        if let postImageUrl = user.postImage {
            let url = URL(string: postImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.imageCell.image = UIImage(data: data!)
                }
            }).resume()
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
