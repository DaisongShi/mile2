//
//  BreedDetailViewController.swift
//  mile2
//
//  Created by Joseph Du on 2021-10-31.
//
//get data from ScanMain and print the description of the  first breed

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class BreedDetailViewController: ViewController {
    
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var breedDescriptionLabel: UILabel!
    
    //load Firebase
    private var db = Firestore.firestore()
    private var breedInfo = [Breed]()
    private var breedInfoCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breedInfoCollectionRef = Firestore.firestore().collection("dogBreedsInfo")
    }
    
    @IBAction func unwindToFirstView(segue: UIStoryboardSegue)
    {
        //change breed_string(name) to breed_name(returnName)
        let returnName = ""
        //get data from firebase
        breedInfoCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let breedName = data["breed_name"] as? String ?? ""
                    let breedString = data["breed_string"] as? String ?? ""
                    let documentId = document.documentID
                    
                    let newBreedCollection = Breed(breedName: breedName, BreedString: breedString)
                    self.breedInfo.append(newBreedCollection)
                    
                    
                    
                }
            }
        }
        // get subview viewcontroller
        if let vc = segue.source as? ScanMainViewController
        {
            // update label using incoming data
            //self.breedNameLabel.text = vc.formatPredictions.name
        }
    }
}
