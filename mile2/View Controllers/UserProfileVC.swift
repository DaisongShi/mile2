//
//  UserProfileVC.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-09-19.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {

    @IBOutlet weak var logputBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let auth = Auth.auth()
          do {
              try auth.signOut()
              self.dismiss(animated: true, completion: nil)
          } catch let signOutError {
            //  self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
              print(signOutError)
          }
          let storyboard = UIStoryboard(name: "Start", bundle: nil)
          let loginVC = storyboard.instantiateViewController(withIdentifier: "index")
          self.present(loginVC, animated: true, completion: nil)
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
