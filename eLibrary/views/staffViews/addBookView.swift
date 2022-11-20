//
//  addBookView.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import SwiftUI

struct addBookView: View {
    @EnvironmentObject var dataManager: booksDataManager
    @EnvironmentObject var viewModel: authViewModel
    
    @State var name = ""
    @State var author = ""
    @State var genere = ""
    @State var numberOfBooks = ""
    @State var ISBN = ""
    @State private var showAddAlert = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center, spacing: 20){
                
                    imagePickerView
                
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
                    
                    
                    Button {
                        showAddAlert.toggle()
                        
                    } label: {
                        Text("ADD BOOK")
                            .frame(width: 100, height: 20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                    }
            }
            .padding(.bottom, 100)
            .navigationBarItems(leading: cancelButton)
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .alert("Add this Book to Database?", isPresented: $showAddAlert, actions: {
                Button(role: .cancel) {
                    //HANDLE ACTION
                } label: {
                    Text("Cancel")
                }

                if let selectedImage = selectedImage {
                    Button {
                        //add book operation
                        dataManager.addBooks(name: name, genere: genere, author: author, numberOfBooks: numberOfBooks, ISBN: ISBN)
                        
                        //add image to database
                        
                        dataManager.uploadBookImage(selectedImage, ISBN: ISBN)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                        
                    } label: {
                        Text("Confirm")
                    }
                }
                


            }) {
                Text("Add book")
            }
        }
        
        
        
        
    }
    func loadImage(){
        guard let selectedImage = selectedImage else {
            return
        }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct addBookView_Previews: PreviewProvider {
    static var previews: some View {
        addBookView()
            .environmentObject(booksDataManager())
            .environmentObject(authViewModel())
    }
}


extension addBookView{
    var cancelButton: some View{
        HStack{
            Button {
                //cancel
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .foregroundColor(Color.blue)
            }
            Spacer()
        }
    }
    
    var imagePickerView: some View{
        Button {
            showImagePicker.toggle()
        } label: {
            
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .modifier(imageModifier())
            }else{
                VStack{
                    Image("add")
                        .resizable()
                        .modifier(imageModifier())
                        
                        
                    Text("Add Book Cover")
                        .font(.subheadline)
                }
                .padding(.bottom, 40)
            }
            
        }
    }
}


//modifier can be grouped like this for readability
private struct imageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 180, height: 180)
            .clipShape(Circle())
    }
}

