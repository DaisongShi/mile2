//
//  ViewController.swift
//  ToDoListTest
//
//  Created by Boqian Wen on 2021-09-28.
//

import UIKit

class AddingVC: UIViewController{
    
    @IBOutlet weak var input: UITextView!
    @IBAction func addItem(_ sender: AnyObject){
        if(input.text != ""){
            
            list.append(input.text!)
            input.text = ""
        }
        
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

