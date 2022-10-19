//
//  Color.swift
//  eLibrary
//
//  Created by Sabal on 10/19/22.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

