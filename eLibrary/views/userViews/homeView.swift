//
//  homeView.swift
//  eLibrary
//
//  Created by Sabal on 10/17/22.
//

import SwiftUI

struct homeView: View {
    @State var selectedTab: Tabs = .home    //onboardingView
    @State private var showSideMenu = false
    var body: some View {
        
        if selectedTab == .home{
            NavigationView{
                ZStack(alignment: .topLeading){
                    bookListView()
                    
                    if showSideMenu{
                        ZStack{
                            Color(.black)
                                .opacity(showSideMenu ? 0.25 : 0.0)
                        }.onTapGesture {
                            withAnimation(.easeInOut){
                                showSideMenu = false
                            }
                        }
                        .ignoresSafeArea()
                    }
                    
                    sideMenuView()
                        .frame(width: 350)
                        .offset(x: showSideMenu ? 0 : -350, y: 0)
                        .background(showSideMenu ? Color.theme.lightShadow : Color.clear)
                }
                .navigationTitle("Books")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(showSideMenu ? true : false)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            //notification button
                            withAnimation(.easeInOut){
                                showSideMenu.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "bell.badge.circle.fill")
                                .frame(width: 25, height: 25)
                                .font(.title3)
                                .foregroundColor(Color.theme.accent)
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            
            
        }else {
            profileView()
        }
        
        
        Spacer()
        
        tabBar(selectedTab: $selectedTab)
        
    }
    
}





struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
