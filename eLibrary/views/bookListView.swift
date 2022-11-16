//
//  bookListView.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import SwiftUI

struct bookListView: View {
    @EnvironmentObject var dataManager:booksDataManager
    @EnvironmentObject var viewModel: authViewModel
    
    @State private var searchText = ""
    @State var studentID = ""
    @State private var logoutOption = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                //searchBarView()
                
//                if viewModel.currentUserIs?.isStaff == true{
//                    Group{
//                        TextField("studentID to whom isToBeAssigned", text: $studentID)
//                    }
//                    .frame(width: 350, height: 32, alignment: .center)
//                    .background(Color.theme.textFieldColor1)
//                    .padding()
//                }
                
                //search by name and author
                List(dataManager.books.filter{(self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText) || $0.author.localizedCaseInsensitiveContains(self .searchText))}, id: \.id){ item in
                    
                    NavigationLink(destination: bookDetailView(data: item)){
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.author)
                                    .font(.subheadline)
                                
                            }
                            Spacer()
                            //update book can only be done by staff Aaddo9r7vaVJwUg2jiGrzblWP2C3  of user12 SVm1XfH6PBMSzEfFs6GoerSImMc2  of user11

                            
//                            if viewModel.currentUserIs?.isStaff == true{
//                                Button {
//                                    //For assigning
//                                    dataManager.assignBooks(bookToAssign: item, studentID: studentID)
//                                } label: {
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color.theme.dropShadow)
//                                            .frame(width: 60, height: 25)
//                                            .shadow(color: Color.theme.lightShadow, radius:8, x: -4, y: -4)
//                                            .shadow(color: Color.theme.darkShadow, radius: 8, x: 4, y: 4)
//                                        Text("Assign")
//                                            .font(.subheadline).bold()
//                                            .frame(width: 60, height: 25)
//                                            .foregroundColor(.accentColor)
//                                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
//                                    }
//                                }
//                                .buttonStyle(BorderlessButtonStyle())
//                            }
                           
                            
                            
                            Button {
                                dataManager.updateBook(bookToUpdate: item)
                                //                                dataManager.assignBooks(bookToAssign: item, studentID: studentID)
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
                
                
                //change location of this logout button
                if viewModel.currentUserIs?.isStaff == true{
                    Button(action: {
                        logoutOption.toggle()
                    }, label: {
                        Image(systemName: "person.crop.circle.fill")
                            .frame(width: 70 , height: 70)

                    })
                }
                
                
                
                //                .sheet(isPresented: $showPopup){
                //                    addBookView()

            }
            .actionSheet(isPresented: $logoutOption){
                .init(title: Text("Setting"), message: Text("What do you want to do"), buttons: [
                    .destructive(Text("LogOut"), action: {
                        viewModel.logOut()
                    }),
                    .cancel()
                ])
            }
            
        }
    }
}



struct bookListView_Previews: PreviewProvider {
    static var previews: some View {
        bookListView()
            .environmentObject(booksDataManager())
            .environmentObject(authViewModel())
    }
}
