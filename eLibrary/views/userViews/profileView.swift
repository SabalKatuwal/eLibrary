//
//  profileView.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct profileView: View {
    @State var shouldShowLogoutOption = false
    @EnvironmentObject var viewModel: authViewModel
    @EnvironmentObject var BookViewModel: booksDataManager
    
    var body: some View {
        VStack(alignment: .leading){
            headerView
            userInfo
            
            VStack(alignment: .leading, spacing: 4){
                showBooksButton
                
                ScrollView{
                    ForEach(BookViewModel.takenBook){ b in
                        
                            //                        Text(b.id)
                            ForEach(b.b_ids, id: \.self){ item in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.background)
                                        .frame(width: 300, height: 100)
                                        .shadow(color: Color.theme.lightShadow, radius: 8, x: -8, y: -8)
                                        .shadow(color: Color.theme.darkShadow, radius: 8, x: 8, y: 8)
                                    Text(item)
                                        
                                        
                                    
                                }
                                .padding()
                            }
                    }
                }
                .padding()
                
            }
            .offset(y: 40)
            
            Spacer()
        }
                
    }
    
}


extension profileView{
    var headerView: some View{
        ZStack(alignment: .bottomLeading){
            Color.theme.dropShadow
                .ignoresSafeArea()
            
                KFImage(URL(string: viewModel.currentUserIs?.profileImageUrl ?? ""))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 140, height: 140)
                    .offset(x: 5, y: 40)
            
            HStack{
                Spacer()
                Button {
                    shouldShowLogoutOption.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.dropShadow)
                            .frame(width: 60, height: 25)
                            .shadow(color: Color.theme.lightShadow, radius:8, x: -4, y: -4)
                            .shadow(color: Color.theme.darkShadow, radius: 8, x: 4, y: 4)
                        Text("Logout")
                            .font(.subheadline).bold()
                            .frame(width: 60, height: 25)
                            .foregroundColor(.accentColor)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
                    }
                   
                }
                
            }
            .offset(x: -10, y: -20)
            .actionSheet(isPresented: $shouldShowLogoutOption){
                .init(title: Text("Setting"), message: Text("What do you want to do"), buttons: [
                    .destructive(Text("LogOut"), action: {
                        viewModel.logOut()
                    }),
                    .cancel()
                ])
            }
        }
        .frame(height: 60)
    }
    
    var userInfo: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(viewModel.currentUserIs?.username ?? "username")
                .font(.title2.bold())
            Text(viewModel.currentUserIs?.email ?? "@user")
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
        }
        .offset(y: 50)
        .padding(.horizontal)
    }
    
    var showBooksButton: some View{
        Button {
            BookViewModel.fetchAssignedBooks(currentUserId: viewModel.userSession?.uid ?? "")
            //                    BookViewModel.fetchAssignedBooks(currentUserId: "Svm1XfH6PBMSzEfFs6GoerSImMc2")
        } label: {
            ZStack{
                //Rounded rectangle for neumorphism
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.background)
                    .frame(width: 300, height: 30)
                    .shadow(color: Color.theme.lightShadow, radius:8, x: -8, y: -8)
                    .shadow(color: Color.theme.darkShadow, radius: 8, x: 8, y: 8)
                Text("Show My Borrowed Book List")
                    .font(.subheadline).bold()
                    .frame(width: 300, height: 30)
                    .foregroundColor(.accentColor)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
                
            }
            .padding()
            
        }

    }
    
    //    var takenBooks: some View{
    //
    //    }
    
}


struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
            .environmentObject(authViewModel())
            .environmentObject(booksDataManager())
            
    }
}


