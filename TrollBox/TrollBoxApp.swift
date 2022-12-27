//
//  TSSwissKnifeApp.swift
//  TrollBox
//
//  Created by Constantin Clerc on 16/12/2022.
//

import SwiftUI

@main
struct TSSwissKnifeApp: App {
    var showit = "false"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    for url in (try? FileManager.default.contentsOfDirectory(at: FileManager.default.temporaryDirectory, includingPropertiesForKeys: nil)) ?? [] {
                        try? FileManager.default.removeItem(at: url)
                    }
                    
                    // root ?
                    do {
                        try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
                    } catch {
                        UIApplication.shared.alert(body: "The app needs to be installed either using TrollStore or on Jailbroken devices error: \(error)", withButton: false)
                    }
                    //update ?
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/c22dev/TrollBox/releases/latest") {
                        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                            guard let data = data else { return }
                            
                            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                if json["tag_name"] as? String != version {
                                    //Pop-up alert. Replace with anything you want (keep temp end)
                                    UIApplication.shared.confirmAlert(title: "Update available", body: "Do you want to download the update from the Github ?", onOK: {
                                        UIApplication.shared.open(URL(string: "https://github.com/c22dev/TrollBox/releases/latest")!)
                                    }, noCancel: false)
                                    //keep resume if you cut things from here
                                }
//                                if let url2 = URL(string: "https://raw.githubusercontent.com/c22dev/TrollBox/main/feed.json") {
//                                    let task = URLSession.shared.dataTask(with: url2) {(data, response, error) in
//                                        guard let data = data else { return }
//
//                                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                                            if json["showpopup"] as! String == "yes" {
//                                                if json["skippable"] as! String == "no" {
//                                                    UIApplication.shared.alert(title: json["popuptitle"] as! String, body: json["popupcontent"] as! String, animated: false, withButton: false)
//                                                }
//                                                    else {
//                                                        UIApplication.shared.confirmAlert(title: json["popuptitle"] as! String, body: json["popupcontent"] as! String, onOK: {
//                                                            let x = 5
//                                                            if x > 10 {
//                                                            }
//                                                        }, noCancel: json["nocancel"] as! Bool)
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    task.resume()
//                                    }
                            }
                        }
                        task.resume()
                    }
                    }
                }
        }
    }
