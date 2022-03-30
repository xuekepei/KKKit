//
//  Color+Extensions.swift
//  
//
//  Created by xueke on 2022/03/30.
//

import SwiftUI

extension Color {
    public init(hex: Int, alpha: Double = 1) {
        self.init(.sRGB, red: Double((hex >> 16) & 0xff), green: Double((hex >> 8) & 0xff), blue: Double(hex & 0xff), opacity: alpha)
        
    }
    
    public static var primaryBlue: Color {
        Color(hex: 0x255AA6)
    }
}
