//
//  sideMenuView.swift
//  eLibrary
//
//  Created by Sabal on 11/22/22.
//

import SwiftUI
import Kingfisher

struct sideMenuView: View {
    @EnvironmentObject var viewModel: authViewModel
    var body: some View {
        
            
            VStack(alignment: .leading, spacing: 8){
                profile
                notificatins
                    .padding(.vertical, 40)
                
                Spacer()
            }
            
            
            
            
        
    }
}


extension sideMenuView{
    var profile: some View{
        VStack(spacing: 6){
            KFImage(URL(string: viewModel.currentUserIs?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 140, height: 140)
                .offset(x: 5)
            
            Text(viewModel.currentUserIs?.username ?? "username")
                .font(.title2.bold())
            Text(viewModel.currentUserIs?.email ?? "@user")
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
        }
        
    }
    
    var notificatins: some View{
        VStack(alignment: .leading, spacing: 1) {
            Text("Notifications")
                .font(.title.bold())
            
            ForEach(sideMenuViewModel.allCases, id: \.rawValue) { option in
               
                    Text(option.description)
                        .fontWeight(.light)
                        .padding(.vertical, 15)
                        .frame(width: 300, alignment: .leading)
                        .background(.gray.opacity(0.08))
                        .padding(.vertical, 7)
                  
            }
            
        }
        
    }
        
}






struct sideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        sideMenuView()
            .environmentObject(authViewModel())
    }
}

