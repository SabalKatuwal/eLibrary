//
//  profileView.swift
//  eLibrary
//
//  Created by Sabal on 10/18/22.
//

import SwiftUI
import Firebase

struct profileView: View {
    @State private var shouldShowLogoutOption = false
    
//    @EnvironmentObject var userdatamanager:userDataManager
    @EnvironmentObject var viewModel: authViewModel

    var body: some View {
        VStack {
            
            HStack {
                Text("Profile view ")
                
                Spacer()
                Button {
                    shouldShowLogoutOption.toggle()
                } label: {
                    Image(systemName: "gear")
                }

            }
            .padding()
            .actionSheet(isPresented: $shouldShowLogoutOption){
                .init(title: Text("Setting"), message: Text("What do you want to do"), buttons: [
                    .destructive(Text("LogOut"), action: {
                        viewModel.logOut()
                    }),
                    .cancel()
                ])
            }
//            .fullScreenCover(isPresented: $userdatamanager.isUserLoggedOut, onDismiss: nil) {
////                loginView(didCompleteLoginProcess: {
////                    self.logout.isUserLoggedOut = false
////                })
//                loginView()
//            }
        
            //Text("User: \(userdatamanager.userInfo?.email ?? "")")
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
//            .environmentObject(userDataManager())
    }
}
