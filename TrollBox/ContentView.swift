//
//  ContentView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 08/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ToolsView()
                .tabItem {
                    Label("Tools", systemImage: "wrench.and.screwdriver.fill")
                }
            MacDirtyCowTools()
                .tabItem {
                    Label("DirtyCow", systemImage: "pencil.and.outline")
                }
            AirSpam()
                .tabItem {
                    Label("AirSpammer", systemImage: "antenna.radiowaves.left.and.right")
                }
            CreditsView()
                .tabItem {
                    Label("Credits", systemImage: "heart.fill")
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


do {
    let url = URL(fileURLWithPath: "/var/preferences/com.apple.springboard.plist")
    if !FileManager.default.fileExists(atPath: url.path) {
        let templatePlistURL = Bundle.main.url(forResource: "com.apple.springboard", withExtension: "plist")!
        try RootHelper.copy(from: templatePlistURL, to: url)
    }
    
    let tempURL = URL(fileURLWithPath: "/var/mobile/.DO-NOT-DELETE-TrollTools/.temp-\(url.lastPathComponent)")
    try RootHelper.copy(from: url, to: tempURL)
    try RootHelper.setPermission(url: tempURL)
    
    guard let data = try? Data(contentsOf: tempURL), var plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { throw "Couldn't read com.apple.springboard.plist" }
    plist["SBDontLockAfterCrash"] = isEnabled
    
    // Save plist
    let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
    try plistData.write(to: tempURL)
    try RootHelper.removeItem(at: url)
    try RootHelper.move(from: tempURL, to: url)
    
    UserDefaults.standard.set(isEnabled, forKey: "RespringAfterRespringEnabled")
} catch {
    UIApplication.shared.alert(body: "Error occured while applying changes. \(error)")
}
