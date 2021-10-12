//
//  PostViewController.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-09-26.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    // @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    //  @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleView: UITextField!
    //  @IBOutlet weak var titleView: UITextView!
    
    private let storage = Storage.storage().reference()
    private var users = [User]()
    
    
    
    @IBAction func didTapSend(){
        
        guard let imageSelected = postImageView.image else {
            print ("error")
            return
        }
        
        guard let imageData = imageSelected.pngData() else {
            return
        }
        /*
         let imagename = NSUUID().uuidString
         storage.child("postImages/\(imagename).png").putData(imageData, metadata: nil, completion: { _, error in
         guard error == nil else {
         print("Failed to upload")
         return
         }
         self.storage.child("postImages/\(imagename).png").downloadURL(completion: { url, error in
         guard let url = url, error == nil else {
         return
         }
         let urlString = url.absoluteString
         print("Download URL: \(urlString)")
         UserDefaults.standard.set(urlString, forKey: "url")
         let userID = Auth.auth().currentUser!.uid
         let userName = Auth.auth().currentUser?.displayName
         let textInput: String = self.textView.text
         //        let titleInput: String = titleView.text
         let titleInput: String? = self.titleView.text
         let db = Firestore.firestore()
         let inputPostCollect = db.collection("userpost")
         let inputPostDocument = inputPostCollect.document()
         let documentID = inputPostDocument.documentID
         
         
         var data: [String: Any] = ["postid": documentID,
         "title": titleInput,
         "text": textInput,
         //                                "username": NSUserName()]
         "userid": userID,
         "username": userName,
         "profileImageUrl": "",
         "postImageUrl": ""]
         data["postImageUrl"] = urlString
         inputPostDocument.setData(data) {
         (error) in
         if error != nil {
         // show error message
         print("Error saving user post")
         }
         }
         })
         })
         */
        
        let imagename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: "gs://petsimg-e3c6c.appspot.com")
        let postImgRef = storageRef.child("postImages/\(imagename).png")
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
                    //                    let user = Auth.auth().currentUser?.reload(completion: nil)
                    let userName = Auth.auth().currentUser?.displayName
                    let email = Auth.auth().currentUser?.email
                    let textInput: String = self.textView.text
                    let titleInput: String? = self.titleView.text
                    let db = Firestore.firestore()
                    let inputPostCollect = db.collection("userpost")
                    let inputPostDocument = inputPostCollect.document()
                    let documentID = inputPostDocument.documentID
                    var data: [String: Any] = ["postid": documentID,
                                               "title": titleInput,
                                               "text": textInput,
                                               "userid": userID,
                                               "username": email,
                                               "profileImageUrl": metaImageUrl,
                                               "postImageUrl": metaImageUrl]
                    inputPostDocument.setData(data) {
                        (error) in
                        if error != nil {
                            // show error message
                            print("Error saving user post")
                        }
                    }
                }
            })
        })
        
        
        
        //       guard NSUserName() != nil else {return}
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
        //     picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        /*
         let userID = Auth.auth().currentUser!.uid
         let userName = Auth.auth().currentUser?.displayName
         let textInput: String = textView.text
         //        let titleInput: String = titleView.text
         let titleInput: String? = titleView.text
         let db = Firestore.firestore()
         let inputPostCollect = db.collection("userpost")
         let inputPostDocument = inputPostCollect.document()
         let documentID = inputPostDocument.documentID
         
         
         var data: [String: Any] = ["postid": documentID,
         "title": titleInput,
         "text": textInput,
         //                                "username": NSUserName()]
         "userid": userID,
         "username": userName,
         "profileImageUrl": "",
         "postImageUrl": ""]
         //        data["postImageUrl"] = urlString
         inputPostDocument.setData(data) {
         (error) in
         if error != nil {
         // show error message
         print("Error saving user post")
         }
         }
         */
    }
    
    /*
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     picker.dismiss(animated: true, completion: nil)
     guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
     return
     }
     guard let imageData = image.pngData() else {
     return
     }
     let imagename = NSUUID().uuidString
     
     storage.child("postImages/\(imagename).png").putData(imageData, metadata: nil, completion: { _, error in
     guard error == nil else {
     print("Failed to upload")
     return
     }
     //            let filename : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
     //            let imagename = NSUUID().uuidString
     self.storage.child("postImages/\(imagename).png").downloadURL(completion: { url, error in
     guard let url = url, error == nil else {
     return
     }
     let urlString = url.absoluteString
     print("Download URL: \(urlString)")
     UserDefaults.standard.set(urlString, forKey: "url")
     //                self.data["postImageUrl"] = urlString
     })
     })
     // upload image data
     // get download url
     // save download url to userDefaults
     }
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                  return
              }
        
        label.text = urlString
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.postImageView.image = image
            }
        })
        task.resume()
        // Do any additional setup after loading the view.   */
    }
    
    
}

extension PostViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            postImageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            postImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        /*
         guard let imageData = image.pngData() else {
         return
         }
         let imagename = NSUUID().uuidString
         
         storage.child("postImages/\(imagename).png").putData(imageData, metadata: nil, completion: { _, error in
         guard error == nil else {
         print("Failed to upload")
         return
         }
         
         self.storage.child("postImages/\(imagename).png").downloadURL(completion: { url, error in
         guard let url = url, error == nil else {
         return
         }
         let urlString = url.absoluteString
         print("Download URL: \(urlString)")
         UserDefaults.standard.set(urlString, forKey: "url")
         var data: [String: Any] = ["postImageUrl": ""]
         data["postImageUrl"] = urlString
         })
         })
         */
    }
}

