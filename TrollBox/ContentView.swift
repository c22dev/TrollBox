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
            AirSpam()
                .tabItem {
                    Label("AirSpammer", systemImage: "antenna.radiowaves.left.and.right.circle")
                }
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
