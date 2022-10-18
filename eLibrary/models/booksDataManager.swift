//
//  booksDataManager.swift
//  eLibrary
//
//  Created by Sabal on 10/17/22.
//

import SwiftUI
import Firebase

class booksDataManager: ObservableObject{
    @Published var books: [Book] = []
    
    
    //fetch function
    func fetchBooks(){
        books.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Books")
        ref.getDocuments{snapshot, error in
            guard error == nil else{
                print (error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let genere = data["genere"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let numberOfBooks = data["numberOfBooks"] as? String ?? ""
                    let uuid = data["uuid"] as? String ?? ""
                    let book = Book(id:id, name:name, genere:genere, author:author, numberOfBooks:numberOfBooks, uuid:uuid)
                    self.books.append(book)
                }
            }
        }
    }
    
    //look 24:18 for fetching data
}



