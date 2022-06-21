//
//  SmartACApp.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

@main
struct SmartACApp: App {
    @StateObject var tempModelData: TempModelData = .init()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(tempModelData)
        }
    }
}
