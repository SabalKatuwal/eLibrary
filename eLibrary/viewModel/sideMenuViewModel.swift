//
//  sideMenuViewModel.swift
//  eLibrary
//
//  Created by Sabal on 11/22/22.
//

import Foundation

enum sideMenuViewModel: Int, CaseIterable{
    case RenewBook
    case CollectBook
    case RequestBook
    
    var description: String{
        switch self{
        case .RenewBook: return "Renew this book on time"
        case .CollectBook: return "Notification to collect your requested Book"
        case .RequestBook: return "Notification of requested book"
        }
    }
}
