//
//  HomeViewController.swift
//  mile2
//
//  Created by Boqian Wen on 2021-04-04.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var SliderCollectionView: UICollectionView!
    @IBOutlet weak var PageView: UIPageControl!
    
    var imgArr = [UIImage(named: "dog2"),
                  UIImage(named: "dog3"),
                  UIImage(named: "dog4")]
    
    @IBOutlet weak var homeTableView: UITableView!
/*
    let fileImg = [UIImage(named: "doge"),
                   UIImage(named: "img1"),
                   UIImage(named: "img2"),
                   UIImage(named: "img3")]
    
    let nameLbl = [("Eric"), ("VV"), ("Joseph"), ("Boss")]
    
    let postImg = [UIImage(named: "dog1"),
                   UIImage(named: "dog2"),
                   UIImage(named: "dog3"),
                   UIImage(named: "dog4")]
    
    let postTxt = [("title"), ("title"), ("title"), ("title")]
*/
    private var db = Firestore.firestore()
    private var userpost = [User]()
    private var userpostCollectionRef: CollectionReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(PageView)
        PageView.currentPage = 0
        homeTableView.delegate = self
        homeTableView.dataSource = self
        userpostCollectionRef = Firestore.firestore().collection("userpost")
//        fetchData()
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
                self.homeTableView.reloadData()
            }
        }
    }

/*
    func fetchData() {
        db.collection("userpost").addSnapshotListener {(QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No documents")
                return
            }
            self.users = documents.compactMap{ (QuerySnapshot) -> User? in
                return try? QuerySnapshot.data(as: User.self)
            }
        }
    }
 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return nameLbl.count
        return userpost.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235;
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        as! HomePageTableViewCell
        cell.configureCell(user: userpost[indexPath.row])
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func postTapped(_ sender: Any) {

    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomeCollectionViewCell
        cell?.img.image = imgArr[indexPath.row]

        return cell!
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = SliderCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
}
