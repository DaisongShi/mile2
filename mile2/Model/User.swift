//
//  User.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-10-07.
//

import UIKit
import FirebaseFirestoreSwift

struct User {
    var username: String?
    var titleInput: String?
    var textInput: String?
    var profileImage: String?
    var postImage: String?
    @DocumentID var postid: String? = UUID().uuidString
    var userid: String? = UUID().uuidString
    
}
