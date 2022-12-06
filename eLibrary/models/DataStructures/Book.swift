//
//  Book.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Book:Identifiable{
    var id: String
    var name: String
    var genere: String
    var author: String
    var numberOfBooks: Int
    var ISBN: String
    var bookImageUrl: String
    var remainingDays: Int?
    var edition: String
    var bookLocation: String
    
    init(id: String, name: String, genere: String, author: String, numberOfBooks: Int, ISBN: String, bookImageUrl: String, remainingDays: Int?, edition: String, bookLocation: String){
        self.id = id
        self.name = name
        self.genere = genere
        self.author = author
        self.numberOfBooks = numberOfBooks
        self.ISBN = ISBN
        self.bookImageUrl = bookImageUrl
        self.remainingDays = remainingDays
        self.bookLocation = bookLocation
        self.edition = edition
    }
    
}

//struct arrayOfTakenBooks: Identifiable{
//    var id: String
//    var b_id: String
//}
struct TakenBook: Identifiable, Decodable{
//    var id: ObjectIdentifier
    @DocumentID var id: String?
    var s_id: String
    
//    var b_ids: [arrayOfTakenBooks] = [arrayOfTakenBooks]()
    var b_ids: [String]
//    var daysRemaining: Int
    var takenDate: String
    var returnDate: String

//    init(id: String, b_ids:[String], takenDate: Date, returnDate: Date){
//        self.id = id
//        self.b_ids = b_ids
//        self.takenDate = takenDate
//        self.returnDate = returnDate
////        self.daysRemaining = daysRemaining
//    }
}
