//
//  LikeVC.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-04-21.
//

import UIKit
import Firebase

class LikeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
 /*
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
   */
    
    private var db = Firestore.firestore()
    private var userpost = [User]()
    private var userpostCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userpostCollectionRef = Firestore.firestore().collection("like")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userpost.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userpostCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    
                    let username = data["username"] as? String ?? "Anonymous"
                    let text = data["text"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let postImageUrl = data["postImageUrl"] as? String
                    let profileImageUrl = data["profileImageUrl"] as? String
                    let documentId = document.documentID
                    
                    let newUserPostCollection = User(username: username, titleInput: title, profileImage: profileImageUrl, postImage: postImageUrl)
                    self.userpost.append(newUserPostCollection)
                }
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        as! TableViewCell
        /*
        cell.imageCell.image = self.imgF[indexPath.row]
        cell.titleLabel.text = self.titlesF[indexPath.row]
        cell.nameLabel.text = self.nameF[indexPath.row]
        cell.userImg.image = self.userImgF[indexPath.row]
        */
        cell.configureCell(user: userpost[indexPath.row])
        return cell
    }
    

}
