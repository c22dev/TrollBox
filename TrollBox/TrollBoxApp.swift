//
//  TrollBoxApp.swift
//  TrollBox
//
//  Created by Constantin Clerc on 08/01/2023.
//

import SwiftUI

@main
struct TrollBoxApp: App {
    var showit = "false"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let haveBeenShow = "no"
                    let havee = UserDefaults.standard.string(forKey: haveBeenShow)
                    let operatingSystemVersion = ProcessInfo().operatingSystemVersion
                    if operatingSystemVersion.majorVersion >= 15 && operatingSystemVersion.minorVersion >= 7 {
                        if havee == "no" {
                            UIApplication.shared.confirmAlert(title: "You're using iOS \(operatingSystemVersion.majorVersion).\(operatingSystemVersion.minorVersion)", body: "You're probably using palera1n. Please note that TrollBox is not stable on these versions. Do not use Gestures or you may not be able to revert back. If any issue is found, please report it to us.", onOK: {}, noCancel: true)
                            UserDefaults.standard.set("yes", forKey: haveBeenShow)
                            UserDefaults.standard.synchronize()
                        }
                    }
                    else if operatingSystemVersion.majorVersion == 14 && operatingSystemVersion.minorVersion <= 8 {
                        if havee == "no"{
                            UIApplication.shared.confirmAlert(title: "You're using iOS \(operatingSystemVersion.majorVersion).\(operatingSystemVersion.minorVersion)", body: "The app is at the moment mostly designed for iOS 15. You may experience some UI glitches, and various bugs. Please report them to us on our Discord server. ", onOK: {}, noCancel: true)
                            UserDefaults.standard.set("yes", forKey: haveBeenShow)
                            UserDefaults.standard.synchronize()
                        }
                    }
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
                                if let url2 = URL(string: "https://raw.githubusercontent.com/c22dev/TrollBox/main/feed.json") {
                                    let task = URLSession.shared.dataTask(with: url2) {(data, response, error) in
                                        guard let data = data else { return }

                                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                            if json["showpopup"] as! String == "yes" {
                                                if json["skippable"] as! String == "no" {
                                                    UIApplication.shared.alert(title: json["popuptitle"] as! String, body: json["popupcontent"] as! String, animated: false, withButton: false)
                                                }
                                                    else {
                                                        UIApplication.shared.confirmAlert(title: json["popuptitle"] as! String, body: json["popupcontent"] as! String, onOK: {
                                                            let x = 5
                                                            if x > 10 {
                                                            }
                                                        }, noCancel: json["nocancel"] as! Bool)
                                                    }
                                                }
                                            }
                                        }
                                    task.resume()
                                    }
                            }
                        }
                        task.resume()
                    }
                    }
                }
        }
}
