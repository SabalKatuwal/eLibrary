//
//  loginView.swift
//  eLibrary
//
//  Created by Sabal on 10/23/22.
//

import SwiftUI

struct loginView: View {
    @State var isLogedIn = false
    @State private var email = ""
    @State private var password = ""
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
                            //profile picture add
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 100))
                        }
                    }
                    
                    Group{
                        TextField("Email Addess", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text:$password)
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
                    
                }
                .navigationTitle(isLogedIn ? "Login" : "Create Account")
            }
            .padding()
            .foregroundColor(Color.theme.accent)
            .background(Color(.init(white: 0.0, alpha: 0.08)))
        }
    }
    private func handleAction(){
        if isLogedIn{
            //refer to home screen
            
        }else{
            //create garera home screen
            
        }
    }
    
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
            
            
            
    }
}
