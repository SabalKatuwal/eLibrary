//
//  booksDataManager.swift
//  eLibrary
//
//  Created by Sabal on 10/17/22.
//

import SwiftUI
import Firebase


class booksDataManager: ObservableObject{
    @Published var books = [Book]()
    init(){
        fetchBooks()
    }
    
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
    
    
    
    
//    func assignBooks(bookToAssign: Book, studentID: String){
//        let db = Firestore.firestore()
//        //set the data to update
//        db.collection("AssignBooks").document(bookToAssign.id).setData(["numberOfBooks": bookToAssign.numberOfBooks - 1], merge: true){error in
//            if error == nil{
//                self.fetchBooks()
//            }
//        }
//    }
    
    
    
    
//    func noOfBooks(){
//        //self.fetchBooks()
//        let noBook = books.map { $0.numberOfBooks }
//    }
    
    
    
    //fetch/get book function
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
                                        numberOfBooks: d["numberOfBooks"] as? Int ?? 0,
                                        ISBN: d["ISBN"] as? String ?? "")
                        }
                    }
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    
    @Published var takenBook = [TakenBook]()
    
    func fetchAssignedBooks(currentUserId: String){
        var takenBookIDs:[String] = []
        let db = Firestore.firestore()
        db.collection("AssignBooks").whereField("s_id", isEqualTo: currentUserId)
            .getDocuments() { (snapshot, err) in
                
//                print("RESULT \(snapshot.data())")
                if let err = err {
                    print("Error HAPPEN in getting documents: \(err)")
                } else {
                    
                    if let docsnapshot = snapshot?.documents {
                        for doc in docsnapshot {
//                            print("AHAHHAHAHA: \(doc.data()["b_id"]!)")
                            takenBookIDs.append(doc.data()["b_id"]! as! String)
                            
                        }
                        self.takenBook.append(TakenBook(id: currentUserId, b_ids: takenBookIDs))
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.takenBook = snapshot!.documents.map{d in
                            return TakenBook(id: d.documentID,
                                             b_ids: takenBookIDs)
//                                             b_ids: d["b_id"] as? [String] ?? [""])
                        }
                    }
                    
//                    for document in snapshot!.documents {
//                        return TakenBook(id: document.documentID,
//                                         b_ids: document["b_id"] as? Array ?? [])
//                        print("\(document.documentID) =>\(document.data())")
//                    }
//                    
                
                }
        }
        
        
//        let db = Firestore.firestore()
//        let result = db.document("AssignBoks/Svm1XfH6PBMSzEfFs6GoerSImMc2")
//        print("FINAL DEBUG: \(result)")
    }
    
    func deleteBook(bookToDelete:Book){
        let db = Firestore.firestore()
        db.collection("Books").document(bookToDelete.id).delete { error in
            if error == nil{
                
                //update the UI from main thread
                DispatchQueue.main.async {
                    //remove the book that is just deleted from UI
                    self.books.removeAll { Book in
                        return Book.id == bookToDelete.id
                    }
                    
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    func updateBook(bookToUpdate: Book){
        let db = Firestore.firestore()
        //set the data to update
        db.collection("Books").document(bookToUpdate.id).setData(["name":"updated  \(bookToUpdate.name)"], merge: true){error in
            if error == nil{
                self.fetchBooks()
            }
        }
    }
    
    func assignBooks(bookToAssign: Book, studentID: String){
        Firestore.firestore().collection("AssignBooks").addDocument(data: ["s_id": studentID, "b_id": bookToAssign.id]) { error in
            if error == nil{
                self.decreaseNumberOfBook(bookToDecrease: bookToAssign)
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    func decreaseNumberOfBook(bookToDecrease: Book){
        let db = Firestore.firestore()
        //set the data to update
        db.collection("Books").document(bookToDecrease.id).setData(["numberOfBooks": bookToDecrease.numberOfBooks - 1], merge: true){error in
            if error == nil{
                self.fetchBooks()
            }
        }
    }
    
}



