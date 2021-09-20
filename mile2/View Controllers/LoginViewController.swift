//
//  LoginViewController.swift
//  mile2
//
//  Created by Boqian Wen on 2021-04-04.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(usernameTextField)
        
        
        Utilities.styleTextField(passwordTextField)
        
        
        Utilities.styleFilledButton(loginBtn)
        
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.performSegue(withIdentifier: "ShowHomeViewController", sender: self)
                //let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                //self.view.window?.rootViewController = homeViewController
                //self.view.window?.makeKeyAndVisible()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginTapped(_sender: Any){
        
    }

}
