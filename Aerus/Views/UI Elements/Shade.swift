//
//  Shade.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/26.
//

import Foundation
import SwiftUI

struct Shade: View {
    @EnvironmentObject var sheetManager: BottomSheetManager
    
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    sheetManager.isShowing = false
                }
            }
    }
}
