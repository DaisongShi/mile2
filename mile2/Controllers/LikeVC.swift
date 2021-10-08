//
//  LikeVC.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-04-21.
//

import UIKit

class LikeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let titlesF = [("This dude is amazing!!"),
                   ("This is my favorite dog!"),
                   ("What a nice day!"),
                   ("What a good boy!")]
    
    let nameF = [("VV"), ("Eric"), ("Cheng"), ("Mia")]
    
    let imgF = [UIImage(named: "dog1"),
               UIImage(named: "dog2"),
               UIImage(named: "dog3"),
               UIImage(named: "dog4")]
    
    let userImgF = [UIImage(named: "img1"),
                    UIImage(named: "doge"),
                    UIImage(named: "img2"),
                    UIImage(named: "img3")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesF.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        as! TableViewCell
        cell.imageCell.image = self.imgF[indexPath.row]
        cell.titleLabel.text = self.titlesF[indexPath.row]
        cell.nameLabel.text = self.nameF[indexPath.row]
        cell.userImg.image = self.userImgF[indexPath.row]
        
        return cell
    }
    

}
