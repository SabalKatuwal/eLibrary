//
//  authViewModel.swift
//  eLibrary
//
//  Created by Sabal on 11/11/22.
//

import Foundation
import SwiftUI
import Firebase

class authViewModel: ObservableObject{
//    @Published var userSession: FirebaseAuth.User?
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUserIs: User?
    
    @State var didAuthenticateUser = false
    @State var notStaff = false
    private let service = userService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        // print("DEBUG: user session is \(self.userSession)")
        self.fetchUser()
        
    }
    
    //function for login
    func login(withEmail email: String, password: String){
        print("login ")
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            
            if let error = error{
                print("DEBUG: Failed to login with error = \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
            print("DEBUG: User logged In success")
        }
    }
    
    //function for register
    func register(withEmail email: String, password: String, userName: String){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let error = error{
                print("DEBUG: Failed to register with error = \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            
            let data = ["email": email,
                        "username": userName.lowercased(),
//                        "uid": user.uid,
                        "isStaff": false] as [String : Any]
            
            //uploaded addtional data to db
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data){_ in
                    self.didAuthenticateUser = true
                    self.fetchUser()
                }
            
        }
    }
    
    func logOut(){
        //making userSession to nil will determine what page to show(here login page is shown now)
        userSession = nil
        //logout from backend
        try? Auth.auth().signOut()
    }
    
    //function to pass uid to fetchUser function of userService Struct
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in   //completion handler
            self.currentUserIs = user           //will set published property currentUserIs to user
        }
    }
    
}
