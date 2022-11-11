//
//  addBookView.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import SwiftUI

struct addBookView: View {
    @EnvironmentObject var dataManager: booksDataManager
    
    @State var name = ""
    @State var author = ""
    @State var genere = ""
    @State var numberOfBooks = ""
    @State var ISBN = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 5){
            HStack{
                Button {
                    //cancel
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.blue)
                }
                Spacer()
                
                Button {
                    dataManager.addBooks(name: name, genere: genere, author: author, numberOfBooks: numberOfBooks, ISBN: ISBN)
                    
                    //clear the textfield
                    name = ""
                    author = ""
                    genere = ""
                    numberOfBooks = ""
                    ISBN = ""
                    
                } label: {
                    Text("ADD BOOK")
                        .frame(width: 100, height: 20)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                }
                
            }
            
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Author", text: $author)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Genere", text: $genere)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Number of Books In Library", text: $numberOfBooks)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("ISBN number", text: $ISBN)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
        }
        .padding()
        Spacer()
        
    }
}

struct addBookView_Previews: PreviewProvider {
    static var previews: some View {
        addBookView()
    }
}
