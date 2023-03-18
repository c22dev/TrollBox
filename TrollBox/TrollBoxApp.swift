//
//  TrollBoxApp.swift
//  TrollBox
//
//  Created by Constantin Clerc on 08/01/2023.
//

import SwiftUI
import Foundation
import Darwin
@main
struct TrollBoxApp: App {
    var showit = "false"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    var latsandbox = ""
                    var sbxed = checkSandbox()
                    if ProcessInfo().operatingSystemVersion.majorVersion != 14 {
                        if sbxed == true {
                            // grant r/w access
                            grant_full_disk_access() { error in
                                
                            }
                            var sbxed = checkSandbox()
                            if sbxed == false {
                                var latsandboxede = UserDefaults.standard.string(forKey: "latsandbox")
                                if latsandboxede != "false" {
                                    UIApplication.shared.alert(title: "Sandbox is now disabled !", body: "You're now able to use TrollBox on iOS 16.")
                                }
                                var latsandboxed = "false"
                                UserDefaults.standard.set(latsandboxed, forKey: "latsandbox")
                            }
                            else if sbxed == true {
                                let latsandboxed = "true"
                                UserDefaults.standard.set(latsandboxed, forKey: "latsandbox")
                                UIApplication.shared.confirmAlert(title: "Sandbox maybe was disabled", body: "The app will now quit. Please open it again", onOK: {exit(0)}, noCancel: false)
                            }
                        }
                    }
                    else {
                        var latsandbox = "blank"
                        UserDefaults.standard.set(latsandbox, forKey: "blank")
                    }
                    var havee = "unknown"
                    let fileManager = FileManager.default
                    let checkfilepath = "/var/mobile/TrollBox/havee.txt"
                    if fileManager.fileExists(atPath: checkfilepath) {
                        let uselessvar = 0
                    }
                    else {
                        fileManager.createFile(atPath: checkfilepath, contents: nil, attributes: nil)
                    }
                    do {
                      let fileText = try String(contentsOf: URL(fileURLWithPath: checkfilepath))
                      let lines = fileText.components(separatedBy: .newlines)
                      let firstLine = lines[0]

                      // define a variable from the first line
                      havee = firstLine
                    } catch {
                      print("Error reading file: \(error)")
                    }
                    let operatingSystemVersion = ProcessInfo().operatingSystemVersion
                    if operatingSystemVersion.majorVersion >= 15 && operatingSystemVersion.minorVersion >= 6 &&  latsandbox == "blank" {
                        if havee != "yes" {
                            UIApplication.shared.confirmAlert(title: "You're using iOS \(operatingSystemVersion.majorVersion).\(operatingSystemVersion.minorVersion)", body: "You're probably using palera1n. Please note that TrollBox is not stable on these versions. Do not use Gestures or you may not be able to revert back. If any issue is found, please report it to us.", onOK: {}, noCancel: true)
                            writeIt(contents: "yes", filepath: "/var/mobile/TrollBox/havee.txt")
                        }
                    }
                    else if operatingSystemVersion.majorVersion == 14 {
                        if havee != "yes"{
                            UIApplication.shared.confirmAlert(title: "You're using iOS \(operatingSystemVersion.majorVersion).\(operatingSystemVersion.minorVersion)", body: "The app is at the moment mostly designed for iOS 15. You may experience some UI glitches, and various bugs. Please report them to us on our Discord server. ", onOK: {}, noCancel: true)
                            writeIt(contents: "yes", filepath: "/var/mobile/TrollBox/havee.txt")
                        }
                    }
                    for url in (try? FileManager.default.contentsOfDirectory(at: FileManager.default.temporaryDirectory, includingPropertiesForKeys: nil)) ?? [] {
                        try? FileManager.default.removeItem(at: url)
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
