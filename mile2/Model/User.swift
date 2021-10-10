//
//  User.swift
//  mile2
//
//  Created by Kirito24K Shi on 2021-10-07.
//

import UIKit
import FirebaseFirestoreSwift

class User: Identifiable, Codable {
    var username: String?
    var titleInput: String?
    var textInput: String?
    var profileImage: URL?
    var postImage: URL?
    @DocumentID var id: String? = UUID().uuidString
}
