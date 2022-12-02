//
//  bookDetailView.swift
//  eLibrary
//
//  Created by Sabal on 10/22/22.
//

import SwiftUI
import Kingfisher

struct bookDetailView: View {
    let data: Book
    @EnvironmentObject var viewModel: booksDataManager
    @EnvironmentObject var authVM: authViewModel
    var body: some View {
        VStack(spacing: 5){
            VStack(alignment: .center){
                KFImage(URL(string: data.bookImageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .frame(width: 250, height: 200, alignment: .center)
            }
            
            List{
                Text("Book Name: \(data.name)")
                    
                Text("Author: \(data.author)")
                
                Text("Genere: \(data.genere)")
                
                Text("ISBN: \(data.ISBN)")
                
                Text("Number of available Books: \(data.numberOfBooks)")
                
                if data.numberOfBooks == 0{
                    Button {
                        authVM.sendSMS()
                    } label: {
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.dropShadow)
                                .frame(width: 60, height: 25)
                                .shadow(color: Color.theme.lightShadow, radius:8, x: -4, y: -4)
                                .shadow(color: Color.theme.darkShadow, radius: 8, x: 4, y: 4)
                            Text("Request")
                                .font(.subheadline).bold()
                                .frame(width: 65, height: 30)
                                .foregroundColor(.accentColor)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
                        }
                    }
                }
                
            }
            
            
            

            
                
            Spacer()
        }
        .font(.headline)
        
    }
}

struct bookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        bookDetailView(data: Book(id:"0", name: "book name", genere: "book genere", author: "book author", numberOfBooks: 0, ISBN: "isbn number", bookImageUrl: "", remainingDays: 0))
    }
}


