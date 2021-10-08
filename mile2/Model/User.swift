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
    var input: String?
    var image: URL?
    @DocumentID var id: String? = UUID().uuidString
}
