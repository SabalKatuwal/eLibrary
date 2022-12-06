//
//  booksDataManager.swift
//  eLibrary
//
//  Created by Sabal on 10/17/22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


class booksDataManager: ObservableObject{
    @Published var books = [Book]()
    @Published var assignedBooks = [Book]() //old one
    @Published var bId_ReturnDateDict: [String: Date] = [:]
    @Published var b_id: [String] = []  //current user le lageko books
    init(){
        fetchBooks()
        
        
    }
    
    //add function to db
    func addBooks(name: String, genere: String, author: String, numberOfBooks: Int, ISBN: String, bookLocation: String, edition: String){
        let db = Firestore.firestore()
        db.collection("Books").addDocument(data: ["name":name, "genere":genere, "author":author, "numberOfBooks":numberOfBooks, "ISBN": ISBN, "bookLocation": bookLocation, "edition": edition]) { error in
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
                                        numberOfBooks: d["numberOfBooks"] as? Int ?? 500,
                                        ISBN: d["ISBN"] as? String ?? "",
                                        bookImageUrl: d["bookImageUrl"] as? String ?? "",
                                        remainingDays: nil,
                                        edition: d["edition"] as? String ?? "",
                                        bookLocation: d["bookLocation"] as? String ?? ""
                                        )
                        }
                    }
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    
    @Published var takenBook = [TakenBook]()
    
    
    
    //    //done today
    //    func fetchAssignedBooks(currentUserId: String){
    //        let db = Firestore.firestore()
    //        db.collection("AssignBooks").whereField("s_id", isEqualTo: currentUserId)
    //            .getDocuments() { (snapshot, err) in
    //
    //                //                print("RESULT \(snapshot.data())")
    //                if let err = err {
    //                    print("Error HAPPEN in getting documents: \(err)")
    //                } else {
    //                    self.takenBook = (snapshot?.documents.map{d in
    //                        return TakenBook(s_id: d["s_id"] as? String ?? "",
    //                                         b_ids: d["b_id"] as? [String] ?? [""],
    //                                         takenDate: d["takenDate"] as? String ?? "",
    //                                         returnDate: d["returnDate"] as? String ?? "")
    //                    })!
    //                }
    //            }
    //
    //    }
    
    
    
    
    
    
    
    
    
    
    
    
    //    func fetchAssignedBooks(currentUserId: String){
    //        var takenBookIDs:[String] = []
    //        let db = Firestore.firestore()
    //        db.collection("AssignBooks").whereField("s_id", isEqualTo: currentUserId)
    //            .getDocuments() { (snapshot, err) in
    //
    ////                print("RESULT \(snapshot.data())")
    //                if let err = err {
    //                    print("Error HAPPEN in getting documents: \(err)")
    //                } else {
    //
    //                    if let docsnapshot = snapshot?.documents {
    //                        for doc in docsnapshot {
    ////                            print("AHAHHAHAHA: \(doc.data()["b_id"]!)")
    //                            takenBookIDs.append(doc.data()["b_id"]! as! String)
    //
    //                        }
    //                        self.takenBook.append(TakenBook(id: currentUserId, b_ids: takenBookIDs))
    //
    //                    }
    //
    //                    DispatchQueue.main.async {
    //                        self.takenBook = snapshot!.documents.map{d in
    //                            return TakenBook(id: d.documentID,
    //                                             b_ids: takenBookIDs)
    ////                                             b_ids: d["b_id"] as? [String] ?? [""])
    //                        }
    //                    }
    //
    ////                    for document in snapshot!.documents {
    ////                        return TakenBook(id: document.documentID,
    ////                                         b_ids: document["b_id"] as? Array ?? [])
    ////                        print("\(document.documentID) =>\(document.data())")
    ////                    }
    ////
    //
    //                }
    //        }
    //
    //
    ////        let db = Firestore.firestore()
    ////        let result = db.document("AssignBoks/Svm1XfH6PBMSzEfFs6GoerSImMc2")
    ////        print("FINAL DEBUG: \(result)")
    //    }
    
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
    
    func uploadBookImage(_ image: UIImage, ISBN: String){
        var dID = ""
        Firestore.firestore().collection("Books").whereField("ISBN", isEqualTo: ISBN)
            .getDocuments() { (snapshot, err) in
                if let err = err{
                    print("DEBUG: Error while upload Book: \(err.localizedDescription)")
                }else{
                    if let snapshot = snapshot?.documents {
                        for doc in snapshot {
                            dID = doc.documentID
                        }
                    }
                    
                }
                
            }
        imageUploader.uploadImage(image: image) { bookImageUrl in
            Firestore.firestore().collection("Books")
                .document(dID)
                .updateData(["bookImageUrl": bookImageUrl])
        }
    }
    func changeDate(b_id: String, currentUser: String){
        let date = Date()
        var componenets = DateComponents()
        componenets.setValue(1, for: .month) //month matra linxa date bata
        let expirationDate = Calendar.current.date(byAdding: componenets, to: date)!
        Firestore.firestore().collection("AssignBooks").whereField("b_id", isEqualTo: b_id)
            .getDocuments() { (snapshot, err) in
                if let err = err{
                    print("DEBUG: Error while upload Book: \(err.localizedDescription)")
                }else{
                    if let snapshot = snapshot?.documents {
                        for doc in snapshot {
                            let dID = doc.documentID
                            if doc.data()["s_id"] as! String == currentUser{
                                Firestore.firestore().collection("AssignBooks").document(dID).setData(["returnDate": expirationDate], merge: true)
                            }
                        }
                    }
                    
                }
                
            }
            
    }
    
    
    func assignBooks(bookToAssign: Book, studentID: String){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
//        let todayDate = dateFormatter.string(from: date)
        
        
        var componenets = DateComponents()
        componenets.setValue(1, for: .month) //month matra linxa date bata
        let expirationDate = Calendar.current.date(byAdding: componenets, to: date)!
        dateFormatter.dateFormat = "dd/MM/yyy"
//        let oneMonthFromToday = dateFormatter.string(from: expirationDate)
        
        Firestore.firestore().collection("AssignBooks").addDocument(data: ["s_id": studentID, "b_id": bookToAssign.id, "takenDate": date ,"returnDate": expirationDate]) { error in
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
    
    
    
    func loadBookIdOfCurrentUser(currentUserId: String){
        
        let db = Firestore.firestore()
        db.collection("AssignBooks").addSnapshotListener { querySnapshot, error in
            self.bId_ReturnDateDict = [:]
            self.b_id = []
            if let e = error {
                
                print("There was an issue retriving data from the firestore. \(e.localizedDescription)")
                
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    
                    
                    
                    for bookDoc in snapShotDocuments {
                        if let requiredUserId = bookDoc.data()["s_id"] as? String {
                            
                            if requiredUserId == currentUserId {
                                
                                print("User Has taken book") //ids matched
                                
                                let studentTakenBookId: String = bookDoc.data()["b_id"] as! String
    
                                let takenBookReturnDateTimeStamp: Timestamp = bookDoc.data()["returnDate"] as! Timestamp
                                
                                
                                
                                let takenBookReturnDate = takenBookReturnDateTimeStamp.dateValue()  // converting timestamp value from Firestore to swift NSDate object
                                
                                print(takenBookReturnDate)
                             
                                
                                self.bId_ReturnDateDict[studentTakenBookId] = takenBookReturnDate
                                
//                                self.b_id.append(studentTakenBookId)
                                
                            }
                            
                            else {
                                
                                print("No Book Taken")  //no id matched
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    
    func fetchAssignedBook(){
        // load only those books with id that matches with current user
        
        Firestore.firestore().collection("Books")

                    .addSnapshotListener { querySnapshot, error in

                        self.assignedBooks = []

                        if let e = error {

                            print("There was an issue retriving book data from Firestore, \(e.localizedDescription)")

                        } else {

                            if let snapshotDocuments = querySnapshot?.documents {
                                for allBooksdoc in snapshotDocuments {
                                    let data = allBooksdoc.data()

                                    for (bookId,returnDate) in self.bId_ReturnDateDict {
                                        
                                        if bookId == allBooksdoc.documentID {
                                            
                                            let todayDate = Date()  // today date (now)
                                            
                                            
                                            
                                            let differenceOfDates = Calendar.current.dateComponents([.day], from: todayDate, to: returnDate).day
                                          
                                            
                                            
                                            if let name = data["name"] as? String,
                                               let author = data["author"] as? String,
                                               let ISBN = data["ISBN"] as? String,
                                               let genere = data["genere"] as? String,
                                               let numberOfBooks = data["numberOfBooks"] as? Int,
                                               let bookImageUrl = data["bookImageUrl"] as? String,
                                               let edition = data["edition"] as? String,
                                               let bookLocation = data["bookLocation"] as? String{
                                                
                                                
                                                
                                                let newBook = Book(id: bookId, name: name, genere: genere, author: author, numberOfBooks: numberOfBooks, ISBN: ISBN, bookImageUrl: bookImageUrl, remainingDays: differenceOfDates, edition: edition, bookLocation: bookLocation
                                                )

                                                

                                                self.assignedBooks.append(newBook)
                                                print("YETA")
                                                print(self.assignedBooks)

                                                // retrigger the table view data source methods once the messages loads up from the database and because it occurs inside a closure i.e in background, fetch it in main thread (which is happending in foreground).
                                            } else {

                                                print("can't append data")

                                            }

                                        }

                                    }
                                }

                            }

                        }

                    }
    }
    
    
}



