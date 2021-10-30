//
//  Breed.swift
//  mile2
//
//  Created by Joseph Du on 2021-10-29.
//

import UIKit
import FirebaseFirestoreSwift

struct Breed {
    var breedName: String?
    var BreedString: String?
    var breedDescription: String?
    @DocumentID var postid: String? = UUID().uuidString
    var breedID: String? = UUID().uuidString
    
}
