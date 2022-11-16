//
//  testProfileView.swift
//  eLibrary
//
//  Created by Sabal on 11/14/22.
//

import SwiftUI

struct testProfileView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .frame(width: 300, height: 180)
                .shadow(color: Color.theme.lightShadow, radius: 8, x: -8, y: -8)
                .shadow(color: Color.theme.darkShadow, radius: 8, x: 8, y: 8)
            
        }
    }
}

struct testProfileView_Previews: PreviewProvider {
    static var previews: some View {
        testProfileView()
            
            
    }
}
//
//extension testProfileView{
//    var headerView: some View{
//        ZStack(alignment: .bottomLeading){
//            Color.theme.dropShadow
//                .ignoresSafeArea()
//            HStack{
//                Image(systemName: "person.crop.circle.fill")
//                    .font(.system(size: 70))
//                    .offset(x: 16, y: 20)
//            }
//            HStack{
//                Spacer()
//                Button {
//                    shouldShowLogoutOption.toggle()
//                } label: {
//                    Text("Logout")
//                        .font(.subheadline).bold()
//                        .frame(width: 60, height: 25)
//                        .foregroundColor(.accentColor)
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
//                }
//
//            }
//            .offset(x: -10, y: -20)
//            .actionSheet(isPresented: $shouldShowLogoutOption){
//                .init(title: Text("Setting"), message: Text("What do you want to do"), buttons: [
//                    .destructive(Text("LogOut"), action: {
////                        viewModel.logOut()
//                    }),
//                    .cancel()
//                ])
//            }
//        }
//        .frame(height: 30)
//    }
//
//    var userInfo: some View{
//        VStack(alignment: .leading, spacing: 4){
//            Text("Sabal Katuwal")
//                .font(.title2.bold())
//            Text("@user1")
//                .font(.subheadline)
//                .foregroundColor(Color.theme.secondaryText)
//        }
//        .offset(y: 35)
//        .padding(.horizontal)
//    }
//
//    var takenBooks: some View{
//        Button {
////                BookViewModel.fetchAssignedBooks(currentUserId: viewModel.userSession?.uid ?? "")
//            BookViewModel.fetchAssignedBooks(currentUserId: "Svm1XfH6PBMSzEfFs6GoerSImMc2")
//        } label: {
//            Text("Show all books Taken by this user")
//        }
//        List{
//            ForEach(BookViewModel.takenBook){ b in
//                VStack{
//
////                        Text(b.id)
//                    ForEach(b.b_ids, id: \.self){ item in
//                        Text(item)
//                    }
//                }.padding()
//
//            }
//        }
//    }
//
//}

//Image(systemName: "bell.badge")
//    .font(.title)
//    .padding(6)
//    .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
