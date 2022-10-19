//
//  login.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import Foundation
import SwiftUI


//here just to user this isUserLoggedIn state object by all other views we made observable class
class userLogin: ObservableObject{
    
    @Published var isUserLoggedIn = false
}


//user seperate login to give prevelage
class staffLogin: ObservableObject{
    
    @Published var isStaffLoggedIn = false
}

//use environmentobject
