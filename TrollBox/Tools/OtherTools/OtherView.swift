//
//  OtherView.swift
//  TSSwissKnife
//
//  Created by Constantin Clerc on 17/12/2022.
//

import SwiftUI
func writeIt(contents: String, filepath: String) {
        let fileManager = FileManager.default
        let url = URL(fileURLWithPath: filepath)
        fileManager.createFile(atPath: filepath, contents: nil)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        }
        catch {
            print("oops")
        }
    }
struct OtherView: View {
    @State private var dotColour = Color.red
    @State private var showingAlert = false
    @State private var showingAlerty = false
    @State private var showAlert = false
    @State var enabled = UserDefaults.standard.bool(forKey: "GesturesEnabled")
    var body: some View {
            List {
                Section(header: Text("Supervising"), footer: Text("Supervision gives you a greater control over the devices that you own. With supervision, your can apply extra features/restrictions to youre device by various profiles.")) {
                    Button("Supervise !") {
                                            showAlert.toggle()
                                            writeIt(contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>AllowPairing</key> <true/> <key>CloudConfigurationUIComplete</key> <true/> <key>ConfigurationSource</key> <integer>0</integer> <key>IsSupervised</key> <true/> <key>PostSetupProfileWasInstalled</key> <true/> </dict> </plist>", filepath: "/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("Now supervised !!"),
                                                message: Text("You're device have been supervised successfully ! Please go respring to apply change."),
                                                primaryButton: .default(
                                                    Text("Respring"),
                                                    action: {
                                                        respring()
                                                    }
                                                ),
                                                secondaryButton: .default(
                                                    Text("OK")
                                                )
                                            )
                                        }
                    Button("Unsupervise Your Device") {
                         showingAlert.toggle()
                         writeToFileWithContents(contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>AllowPairing</key> <true/> <key>CloudConfigurationUIComplete</key> <true/> <key>ConfigurationSource</key> <integer>0</integer> <key>IsSupervised</key> <false/> <key>PostSetupProfileWasInstalled</key> <true/> </dict> </plist>", filepath: "/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist")
                     }
                     .alert(isPresented: $showingAlert) {
                         Alert(
                             title: Text("Goodbye..."),
                             message: Text("The text at the top of settings was annoying, that's true... Please respring"),
                             primaryButton: .default(
                                 Text("Respring"),
                                 action: {
                                     respring()
                                 }
                             ),
                             secondaryButton: .default(
                                 Text("OK")
                             )
                         )
                     }
                }
                Section(header: Text("Lock after Respring"), footer: Text("Choose to go to lockscreen or go to homescreen when respringing.")) {
                    Button("Disable") {
                        showingAlert.toggle()
                        writeToFileWithContents(contents: "<?xml version=\"1.0\" encoding=\"utf-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>SBDontLockAfterCrash</key> <true/> </dict> </plist>", filepath: "/var/preferences/com.apple.springboard.plist")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("Tada, respring now and you'll see"),
                            primaryButton: .default(
                                Text("Respring"),
                                action: {
                                   respring()
                                }
                            ),
                            secondaryButton: .default(
                                Text("OK")
                            )
                        )
                    }
                    Button("Enable") {
                        showingAlert.toggle()
                        writeToFileWithContents(contents: "welcome there, i'm c22dev lol", filepath: "/var/preferences/com.apple.springboard.plist")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("Voila. Respring and test"),
                            primaryButton: .default(
                                Text("Respring"),
                                action: {
                                    respring()
                                }
                            ),
                            secondaryButton: .default(
                                Text("OK")
                            )
                        )
                    }
                }
                Section(header: Text("Show an iPad only feature in your control center"), footer: Text("Please remember to add it through Settings -> Control Center")) {
                    Button("Show The Mute Switch In Control Center") {
                        showingAlert.toggle()
                        writeToFileWithContents(contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>SBIconVisibility</key> <true/> </dict> </plist>", filepath: "/var/Managed Preferences/mobile/com.apple.control-center.MuteModule.plist")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("It worked ! Respring and check you're control center settings !"),
                            primaryButton: .default(
                                Text("Respring"),
                                action: {
                                    respring()
                                }
                            ),
                            secondaryButton: .default(
                                Text("OK")
                            )
                        )
                    }
                    Button("Hide The Mute Switch In Control Center") {
                        showingAlert.toggle()
                        writeToFileWithContents(contents: "Placeholder text that was edited by Jaility.", filepath: "/var/Managed Preferences/mobile/com.apple.control-center.MuteModule.plist")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("It worked ! Respring and check you're control center settings !"),
                            primaryButton: .default(
                                Text("Respring"),
                                action: {
                                   respring()
                                }
                            ),
                            secondaryButton: .default(
                                Text("OK")
                            )
                        )
                    }
                }
                Section(header: Text("Remove some restrictions on you're device"), footer: Text("This will allow you to remove region restrictions on you're device, enabling services such as FaceTime. This is not working for everyone.")) {
                    Button("Disable region restrictions") {
                        setRegion()
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("It worked ! Respring or restarting should apply it."),
                            primaryButton: .default(
                                Text("Respring"),
                                action: {
                                    respring()
                                }
                            ),
                            secondaryButton: .default(
                                Text("OK")
                            )
                        )
                    }
                }
                    Section(header: Text("Home Gesture"), footer: Text("Device Layout to iPhone XS layout. It is totally safe but you may experience some UI glitches and screenshot is not working at the moment.")) {
                        Text("Enabled")
                            .font(.headline)
                            .padding(.horizontal, 4)
                        Toggle(isOn: $enabled) {
                            Text("Notched Device Gestures")
                        }
                        .labelsHidden()
                    }
                    .onChange(of: enabled) { isEnabled in
                        do {
                            let url = URL(fileURLWithPath: "/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist")
                            let data = try Data(contentsOf: url)
                            
                            guard var plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { throw "Couldn't read com.apple.MobileGestalt.plist" }
                            let origDeviceTypeURL = URL(fileURLWithPath: "/var/mobile/TrollBox/ArtworkDeviceSubTypeBackup")
                            var origDeviceType = 0
                            
                            if !FileManager.default.fileExists(atPath: origDeviceTypeURL.path) {
                                guard let currentType = ((plist["CacheExtra"] as? [String: Any] ?? [:])["oPeik/9e8lQWMszEjbPzng"] as? [String: Any] ?? [:])["ArtworkDeviceSubType"] as? Int else { throw "Couldn't get current device subtype" }
                                origDeviceType = currentType
                                remLog(origDeviceType)
                                guard let backupData = String(currentType).data(using: .utf8) else { throw "Unable to convert device type to data" }
                                try backupData.write(to: origDeviceTypeURL)
                            } else {
                                guard let data = try? Data(contentsOf: origDeviceTypeURL), let deviceTypeStr = String(data: data, encoding: .utf8), let deviceType = Int(deviceTypeStr) else { throw "Couldn't retrieve original device type" }
                                origDeviceType = deviceType
                            }
                            
                            if var firstLevel = plist["CacheExtra"] as? [String : Any], var secondLevel = firstLevel["oPeik/9e8lQWMszEjbPzng"] as? [String: Any], var thirdLevel = secondLevel["ArtworkDeviceSubType"] as? Int {
                                thirdLevel = isEnabled ? 2436 : origDeviceType
                                secondLevel["ArtworkDeviceSubType"] = thirdLevel
                                firstLevel["oPeik/9e8lQWMszEjbPzng"] = secondLevel
                                plist["CacheExtra"] = firstLevel
                            }
                            
                            // Save plist
                            let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
                            try plistData.write(to: url)
                            
                            UserDefaults.standard.set(isEnabled, forKey: "GesturesEnabled")
                        } catch {
                            UIApplication.shared.alert(body: "Error occured while applying changes. \(error)")
                        }
                    }
                }
            }
    }
func writeToFileWithContents(contents: String, filepath: String) {
        let fileManager = FileManager.default
        let url = URL(fileURLWithPath: filepath)
        fileManager.createFile(atPath: filepath, contents: nil)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        }
        catch {
            print("error")
        }
    }
