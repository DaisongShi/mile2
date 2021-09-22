//
//  SignUpViewController.swift
//  mile2
//
//  Created by Boqian Wen on 2021-04-04.
//


import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(confirmTextField)
        Utilities.styleFilledButton(signUpBtn)
        
    }

    
    // check the fields and validate that the data is correct. if right, return nil. otherwise return error message
    
    func validateFields() -> String? {
        // check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        // check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordVaild(cleanedPassword) == false {
            // password isnt secure enough
            return "Please make your password stronger, at least 8 characters, contains a number and a special character"
        }
        return nil
    }
    

    
    @IBAction func signUpTapped (_sender: Any){
        // validate the fields
        let error = validateFields()
        if error != nil{
            // there's something wrong with the fields, show error message
            showError(error!)
        }
        else
        {
            // create cleaned versions of the data
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // create users
            Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
                // check errors
                if  err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                } else {
                    // User was created successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["username": username, "uid": result!.user.uid])
                    {(error) in
                        if error != nil {
                            // show error message
                            self.showError("Error saving user data")
                        }
                    }
                    db.collection("users").document("info").setData(["email": email, "password": password, "username": username], merge: true)
                    { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    // Transition to the home screen
                    // self.transitionToHome()
                    self.performSegue(withIdentifier: "ShowLogInPage", sender: self)
                    // add user input to firestore
                    // self.addUser(email: email, password: password, username: username)

                }
            }
        }
    }
  /*
    func addUser(email: String, password: String, username: String){
        let db = Firestore.firestore()
        db.collection("users").document().setData(["email": email, "password": password, "username": username])
    }
    */
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
        HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
