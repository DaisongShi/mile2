//
//  HomePageTableViewCell.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-09-23.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomePageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var postTxt: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    private var userpost = [User]()
    
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
        self.likeBtn.isEnabled = false
     /*   let ref = Firestore.firestore().collection("like")
        ref.addDocument(data:["username": nameLbl.text, "title": postTxt.text, "postImage": postImg, "userImage": fileImg])
      */
        guard let imageSelected = postImg.image else {
            print ("error")
            return
        }
        
        guard let imageData = imageSelected.pngData() else {
            return
        }
        let imagename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: "gs://petsimg-e3c6c.appspot.com")
        let postImgRef = storageRef.child("likeImages/\(imagename).png")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        postImgRef.putData(imageData, metadata: metadata, completion: { (StorageMetadata, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            postImgRef.downloadURL(completion: {(url, error)in
                if let metaImageUrl = url?.absoluteString {
                    let userID = Auth.auth().currentUser!.uid
                    // let user = Auth.auth().currentUser?.reload(completion: nil)
                    let userName = Auth.auth().currentUser?.displayName
                    let email = Auth.auth().currentUser?.email
               //     let textInput: String = self.textView.text
                    let titleInput: String? = self.postTxt.text
                    let db = Firestore.firestore()
                    let inputPostCollect = db.collection("like")
                    let inputPostDocument = inputPostCollect.document()
                    let documentID = inputPostDocument.documentID
                    var data: [String: Any] = ["postid": documentID,
                                               "title": titleInput,
                          //                     "text": textInput,
                                               "userid": userID,
                                               "username": email,
                                               "profileImageUrl": metaImageUrl,
                                               "postImageUrl": metaImageUrl]
                    inputPostDocument.setData(data) {
                        (error) in
                        if error != nil {
                            // show error message
                            print("Error saving user likes")
                        }
                    }
                }
            })
        })
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
