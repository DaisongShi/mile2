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

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
  //  @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleView: UITextField!
    //  @IBOutlet weak var titleView: UITextView!
    
    private let storage = Storage.storage().reference()
    private var users = [User]()
    
    @IBAction func didTapSend(){
 //       guard NSUserName() != nil else {return}
        let userID = Auth.auth().currentUser!.uid
        let userName = Auth.auth().currentUser?.displayName
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        let textInput: String = textView.text
//        let titleInput: String = titleView.text
        let titleInput: String? = titleView.text
        let db = Firestore.firestore()
      /*  db.collection("users").addDocument(data: ["post": input])
        {(error) in
            if error != nil {
                // show error message
                print("Error saving user post")
            }
        }
        */
        let inputPostCollect = db.collection("userpost")
        let inputPostDocument = inputPostCollect.document()
        let documentID = inputPostDocument.documentID
        
        let data: [String: Any] = ["postid": documentID,
                                   "title": titleInput,
                                   "text": textInput,
   //                                "username": NSUserName()]
                                   "userid": userID,
                                   "username": userName,
                                   "profileImageUrl": "",
                                   "postImageUrl": ""]
        inputPostDocument.setData(data) {
            (error) in
                if error != nil {
                    // show error message
                    print("Error saving user post")
                }
        }
        
        /*
        db.collection("userpost").document().setData(["post": input])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.performSegue(withIdentifier: "goHomePage", sender: self)
         */
    }
    
  
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
                var data: [String: Any] = ["postImageUrl": ""]
                data["postImageUrl"] = urlString
            })
        })
        
        // upload image data
        // get download url
        // save download url to userDefaults
    }
   
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
                self.imageView.image = image
            }
        })

        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
