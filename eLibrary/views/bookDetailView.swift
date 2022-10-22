//
//  bookDetailView.swift
//  eLibrary
//
//  Created by Sabal on 10/22/22.
//

import SwiftUI

struct bookDetailView: View {
//    let data:booksDataManager
    let data: Book
    var body: some View {
        VStack{
//            List(data.books){ item in
//                Text(item.name)
//            }
            Text(data.name)
        }
    }
}

struct bookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        bookDetailView(data: Book(id:"0", name: "book name", genere: "book genere", author: "book author", numberOfBooks: "number", ISBN: "isbn number"))
    }
}


