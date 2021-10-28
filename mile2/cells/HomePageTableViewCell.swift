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
    
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        if likeBtn.tag == 0 {
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
            likeBtn.tag = 1
        }
        else {
            likeBtn.setImage(UIImage(named: "heart0"), for: .normal)
            likeBtn.tag = 0
        }
    }
    
    
    func configureCell(user: User) {
        nameLbl.text = user.username
        postTxt.text = user.titleInput
        if let profileImageUrl = user.profileImage {
            let url = URL(string: profileImageUrl)
            /*      var request: URLRequest? = nil
             let task = URLSession.shared.dataTask(with: request!, completionHandler: { data, response, error in
             if error != nil {
             print(error)
             return
             }
             DispatchQueue.main.async(
             execute: {
             self.fileImg.image = UIImage(data: data!)
             })
             })
             task.resume()
             */
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.fileImg.image = UIImage(data: data!)
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
                    self.postImg.image = UIImage(data: data!)
                }
            }).resume()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
