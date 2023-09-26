//
//  Extensions.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//

import Foundation
import SwiftUI

//Allows use of hex codes
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

//Main background linear gradient. DARK MODE ONLY for now
extension LinearGradient {
    static var primaryDarkGradient: LinearGradient {
        return LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0, green: 0.21, blue: 0.36), location: 0.00),
            Gradient.Stop(color: Color(red: 0, green: 0.15, blue: 0.26), location: 0.28),
            Gradient.Stop(color: Color(red: 0, green: 0.1, blue: 0.17), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.02, y: 0.01),
            endPoint: UnitPoint(x: 1, y: 1)
        )
    }
}

extension EnvironmentValues {
    var primaryBackground: Color {
        get { self[PrimaryBackgroundKey.self] }
        set { self[PrimaryBackgroundKey.self] = newValue }
    }
}

private struct PrimaryBackgroundKey: EnvironmentKey {
    static let defaultValue: Color = Color("PrimaryBackground")
}

//Formats the date based on region
extension AppDateFormatter {
    func setUserPreferredFormat(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        UserDefaults.standard.set(dateStyle.rawValue, forKey: "userDateStyle")
        UserDefaults.standard.set(timeStyle.rawValue, forKey: "userTimeStyle")
    }
    
    func loadUserPreferredFormat() {
        if let dateStyleRawValueInt = UserDefaults.standard.value(forKey: "userDateStyle") as? Int,
           let timeStyleRawValueInt = UserDefaults.standard.value(forKey: "userTimeStyle") as? Int {
            let dateStyleRawValue = UInt(dateStyleRawValueInt)
            let timeStyleRawValue = UInt(timeStyleRawValueInt)
            if let dateStyle = DateFormatter.Style(rawValue: dateStyleRawValue),
               let timeStyle = DateFormatter.Style(rawValue: timeStyleRawValue) {
                formatter.dateStyle = dateStyle
                formatter.timeStyle = timeStyle
            }
        }
    }
}

// allows for swipe as a back action with NavigationView that uses a custom back button
// also allows for the child view to be a ScrollView
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

//text styles
extension Text {
    func titleLargeStyle() -> some View {
        self
            .font(.custom("Avenir", size: 40))
            .fontWeight(.bold)
    }
    
    func titleMediumStyle() -> some View {
        self
            .font(.custom("Avenir", size: 20))
            .fontWeight(.bold)
    }
    
    func titleSmallStyle() -> some View {
        self
            .font(.custom("Avenir", size: 14))
            .fontWeight(.bold)
    }
    
    func fancyTitleStyle(colorMode: AppColorMode) -> some View {
        return self
            .font(.custom("Brother 1816 Light", size: 40))
            .foregroundColor(colorMode == .dark ? Color(hex: "E5DADA") : Color(hex: "000000"))
    }
    
    func fancyBodyTextStyle(colorMode: AppColorMode) -> some View {
        return self
            .font(.custom("Brother 1816 Light", size: 16))
            .foregroundColor(colorMode == .dark ? Color(hex: "E5DADA") : Color(hex: "000000"))
    }
    
    func fancySmallTextStyle(colorMode: AppColorMode) -> some View {
        return self
            .font(.custom("Brother 1816 Light", size: 12))
            .foregroundColor(colorMode == .dark ? Color(hex: "E5DADA") : Color(hex: "000000"))
    }
    
    func chatTextStyle() -> some View {
        self
            .font(.custom("Brother 1816 Light", size: 14))
    }
    
    func bodyLargeTextStyle() -> some View {
        self
            .font(.custom("Avenir", size: 14))
    }
    
    func bodyMediumTextStyle() -> some View {
        self
            .font(.custom("Avenir", size: 12))
    }
    
    func bodySmallTextStyle() -> some View {
        self
            .font(.custom("Avenir", size: 10))
    }
}
