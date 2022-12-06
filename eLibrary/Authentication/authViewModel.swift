//
//  authViewModel.swift
//  eLibrary
//
//  Created by Sabal on 11/11/22.
//

//BUG: register garepaxi nai fetchUser run bhunna ani profile info audaina

import Foundation
import SwiftUI
import Firebase
import Alamofire

class authViewModel: ObservableObject{
//    @Published var userSession: FirebaseAuth.User?
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUserIs: User?
    @Published var tempUserSession: FirebaseAuth.User?
    
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
    func register(withEmail email: String, password: String, userName: String, phoneNumber: String){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let error = error{
                print("DEBUG: Failed to register with error = \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.fetchUser()
            self.tempUserSession = user
            
            
            let data = ["email": email,
                        "username": userName.lowercased(),
                        "phoneNumber": phoneNumber,
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
    
    func sendSMS(userEmail: String, bookName: String){
        let url = "https://api.twilio.com/2010-04-01/Accounts/AC6d478f4a70dc90633c9883538fbf03bb/Messages"

                let parameters = ["From": "+14172166162", "To": "+9779866614278", "Body": "\(userEmail) has requested for the book \(bookName), Please return if not in use"]
        
                AF.request(url, method: .post, parameters: parameters)

                    .authenticate(username: "AC6d478f4a70dc90633c9883538fbf03bb", password: "8e37a1e55ac0c405bdf92dc94db72f67")

                    .responseJSON { response in

                        debugPrint(response)

                    }
                RunLoop.main.run()
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
    
    //upload user Image
    func uploadUserImage(_ image: UIImage){
        print("AJHA AGHI")
        guard let uid = tempUserSession?.uid else { return }
        DispatchQueue.main.async {
            imageUploader.uploadImage(image: image) { profileImageUrl in
                Firestore.firestore().collection("users")
                    .document(uid)
    //                .updateData(["profileImageUrl": profileImageUrl])
                    .updateData(["profileImageUrl": profileImageUrl], completion: { _ in
                        self.userSession = self.tempUserSession
                        self.fetchUser()
                    })
            }
        }
    }
    
    
}
