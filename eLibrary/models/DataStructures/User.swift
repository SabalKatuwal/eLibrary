//
//  User.swift
//  eLibrary
//
//  Created by Sabal on 10/29/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable{
    @DocumentID var id: String?
//    let uid: String
    let email: String
    let username: String
    let isStaff: Bool
    
}
