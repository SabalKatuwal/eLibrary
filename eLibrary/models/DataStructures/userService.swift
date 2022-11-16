//
//  userService.swift
//  eLibrary
//
//  Created by Sabal on 11/14/22.
//

import Foundation
import Firebase

struct userService{
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else {return}
            guard let user = try? snapshot.data(as: User.self) else { return }
            print("USERNAME: \(user.username)")
        
            completion(user)
            
        } 
    }
}
