//
//  booksDataManager.swift
//  eLibrary
//
//  Created by Sabal on 10/17/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class booksDataManager: ObservableObject{
    @Published var books = [Book]()
    
    
    //add function to db
    func addBooks(name: String, genere: String, author: String, numberOfBooks: String, ISBN: String){
        let db = Firestore.firestore()
        db.collection("Books").addDocument(data: ["name":name, "genere":genere, "author":author, "numberOfBooks":numberOfBooks, "ISBN": ISBN]) { error in
            if error == nil{
                //so that views get updated after data is entered
                self.fetchBooks()
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    init(){
        fetchBooks()
    }
    
    
    //fetch function
    func fetchBooks(){
        
        let db = Firestore.firestore()
        db.collection("Books").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.books = snapshot.documents.map{d in
                            return Book(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        genere: d["genere"] as? String ?? "",
                                        author: d["author"] as? String ?? "",
                                        numberOfBooks: d["numberOfBooks"] as? String ?? "",
                                        ISBN: d["ISBN"] as? String ?? "")
                        }
                    }
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
}



