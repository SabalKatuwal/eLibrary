//
//  login.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import Foundation
import SwiftUI
import Firebase

//here just to user this isUserLoggedIn state object by all other views we made observable class
class userLogging: ObservableObject{
    
    @Published var isUserLoggedOut = false
    //see 9:40 of chat 07 if bug appear in logout
    func handleLogout(){
        isUserLoggedOut.toggle()
        try? Auth.auth().signOut()
    }
}


//user seperate login to give prevelage
class staffLogin: ObservableObject{
    
    @Published var isStaffLoggedIn = false
}

//use environmentobject
