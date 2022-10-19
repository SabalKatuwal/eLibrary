//
//  bookListView.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import SwiftUI

struct bookListView: View {
    @EnvironmentObject var dataManager:booksDataManager
    
    
    @State private var showPopup = false
    
    var body: some View {
        
        NavigationView {
            List(dataManager.books){ item in
                    Text(item.name)
                }
            .navigationTitle("Books")
            .navigationBarItems(trailing: Button(action: {
                //add
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }) )
            .sheet(isPresented: $showPopup){
                addBookView()
            }
        }
        
        
    }
//    init(){
//        dataManager.fetchBooks()
//    }
}



struct bookListView_Previews: PreviewProvider {
    static var previews: some View {
        bookListView()
    }
}
