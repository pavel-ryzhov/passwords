//
//  passwordsApp.swift
//  passwords
//
//  Created by pavel on 28/06/2024.
//

import SwiftUI

@main
struct passwordsApp: App {
    
    //@State private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                //.environment(mainViewModel)
        }
    }
}
