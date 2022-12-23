//
//  ContentView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 16/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ToolsView()
                .tabItem {
                    Label("Tools", systemImage: "wrench.and.screwdriver.fill")
                }
//            ThemeView()
//                .tabItem {
//                    Label("Tools", systemImage: "wrench.and.screwdriver.fill")
//                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
