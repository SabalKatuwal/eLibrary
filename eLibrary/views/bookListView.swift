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
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                //searchBarView()
                
                List(dataManager.books.filter{(self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText))}, id: \.id){ item in
                    
                    NavigationLink(destination: bookDetailView(data: item)){
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.author)
                                    .font(.subheadline)
                                
                            }
                            Spacer()
                            //update book can only be done by staff
                            Button {
                                dataManager.updateBook(bookToUpdate: item)
                            } label: {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            //***deleting can only be donw by staff
                            Button {
                                dataManager.deleteBook(bookToDelete: item)
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }
                    
                    
                }
                .navigationTitle("Books")
                .searchable(text: $searchText)
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
