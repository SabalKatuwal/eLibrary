//
//  Book.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import Foundation
import SwiftUI

struct Book:Identifiable{
    var id: String
    var name: String
    var genere: String
    var author: String
    var numberOfBooks: Int
    var ISBN: String
    
    init(id: String, name: String, genere: String, author: String, numberOfBooks: Int, ISBN: String){
        self.id = id
        self.name = name
        self.genere = genere
        self.author = author
        self.numberOfBooks = numberOfBooks
        self.ISBN = ISBN
    }
    
}

//struct arrayOfTakenBooks: Identifiable{
//    var id: String
//    var b_id: String
//}
struct TakenBook: Identifiable{
//    var id: ObjectIdentifier
    var id: String
    
//    var b_ids: [arrayOfTakenBooks] = [arrayOfTakenBooks]()
    var b_ids: [String]
    
    init(id: String, b_ids:[String]){
        self.id = id
        self.b_ids = b_ids
    }
}
