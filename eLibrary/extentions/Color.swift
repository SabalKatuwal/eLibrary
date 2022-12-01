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
    let dropShadow = Color("dropShadow")
    let backColor = Color("BackColor")
    let textFieldColor = Color("TextFieldColor")
    let darkShadow = Color("darkShadow")
    let lightShadow = Color("lightShadow")
    let textFieldColor1 = Color("textFieldColor1")
    let tabBarColor = Color("tabBarColor")
    let sideBarBackgroundColor = Color("sideBarBackgroundColor")
}

