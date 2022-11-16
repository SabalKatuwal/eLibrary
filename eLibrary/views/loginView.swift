//
//  loginView.swift
//  eLibrary
//
//  Created by Sabal on 10/23/22.
//

import SwiftUI
import Firebase



struct loginView: View {
    //completion handler callback
    @State private var isLogedIn = false    //isLoggedIn just tracks state
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""

//    @State private var loginErrorMessage = ""
//    @State private var vayo = false
    
    @EnvironmentObject var viewModel: authViewModel
    
//    var body: some View{
//        if isLogedIn{
//            homeViewStaff()
//        }else{
//            content
//        }
//    }
    
    var body: some View {
        NavigationView{
            
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $isLogedIn, label: Text("PickerHere")){
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if !isLogedIn{
                        Button {
                            //profile picture add see chat 03 for it
                        } label: {
                            
                            VStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 100))
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black)
                            )
                        }
                    }
                    
                    Group{
                        TextField("Email Addess", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text:$password)
                        
                        TextField("UserName", text: $userName)
                            .autocapitalization(.none)
                        
                        
                    }
                    .padding(12)
                    .background(Color.theme.textFieldColor)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLogedIn ? "Login": "Create Account")
                                .foregroundColor(Color.theme.accent)
                                .font(.system(size: 17, weight:.semibold))
                                .padding(.vertical, 9)
                            Spacer()
                        }
                        .background(Color.blue)
                    }
                    
//                    Text(loginErrorMessage)
//                        .foregroundColor(Color.red)
                    
                }
                .navigationTitle(isLogedIn ? "Login" : "Create Account")
            }
            .padding()
            .foregroundColor(Color.theme.accent)
            .background(Color(.init(white: 0.0, alpha: 0.08)))
//            .fullScreenCover(isPresented: $vayo, onDismiss: nil) {
//                homeView()
//            }
        }
    }
     func handleAction(){
        if isLogedIn{
            viewModel.login(withEmail: email, password: password)
            
            
            
        }else{
            viewModel.register(withEmail: email, password: password, userName: userName)
        }
    }
    
    
//    private func register(){
//        Auth.auth().createUser(withEmail: email, password: password){ result, error in
//            if let error = error{
//                //print("Failed to register user : \(error)")
//                self.loginErrorMessage = ("Failed to register user : \(error)")
//                return
//            }else{
//                //print("Successfully registered User : \(result?.user.uid ?? "")")
//                self.loginErrorMessage = ("Successfully registered User : \(result?.user.uid ?? "")")
//            }
//            
//        }
//    }
    
    
//    private func login(){
//        //Auth.auth().signIn(withEmail: email, password: password){result, error in
//        Auth.auth().signIn(withEmail: email, password: password){result, error in
//            if let error = error{
//                //print("Failed to login user : \(error)")
//                self.loginErrorMessage = ("Failed to login user : \(error)")
//                return
//            }else{
//                //print("Successfully loggedin: \(result?.user.uid ?? "")")
//                self.loginErrorMessage = ("Successfully loggedIn User : \(result?.user.uid ?? "")")
////                self.didCompleteLoginProcess()
//                self.vayo.toggle()
//            }
//        }
//    }
    
    
    
}


struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
            .environmentObject(authViewModel())
//        loginView()
//            .preferredColorScheme(.light)



    }
}
