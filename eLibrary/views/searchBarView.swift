//
//  searchBarView.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import SwiftUI

struct searchBarView: View {
    
    @State var searchText:String = ""
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                //.foregroundColor(Color.theme.secondaryText)
            TextField("Search by Book name", text: $searchText)
                
        }
        .font(.headline)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.brown)
                //.fill(Color.theme.background)
                //shadow(color: Color.theme.accent.opacity(0.15),radius: 0, x: 0, y: 0)
        }
        .padding()
        
    }
}

struct searchBarView_Previews: PreviewProvider {
    static var previews: some View {
        searchBarView()
    }
}
