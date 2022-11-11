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
    
    @EnvironmentObject var userdatamanager:userDataManager
//    init(){
//        userdatamanager.fetchUser()
//    }
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
                        userdatamanager.handleLogout()
                        print("do logout")
                    }),
                    .cancel()
                ])
            }
            .fullScreenCover(isPresented: $userdatamanager.isUserLoggedOut, onDismiss: nil) {
//                loginView(didCompleteLoginProcess: {
//                    self.logout.isUserLoggedOut = false
//                })
                loginView()
            }
          Spacer()
            Text("User: \(userdatamanager.userInfo?.email ?? "")")
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
//            .environmentObject(userDataManager())
    }
}
