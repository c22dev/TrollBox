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
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button("Supervise !") {
                                            showAlert.toggle()
                                            writeIt(contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>AllowPairing</key> <true/> <key>CloudConfigurationUIComplete</key> <true/> <key>ConfigurationSource</key> <integer>0</integer> <key>IsSupervised</key> <true/> <key>PostSetupProfileWasInstalled</key> <true/> </dict> </plist>", filepath: "/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("Now supervised !!"),
                                                message: Text("You're device have been supervised successfully ! Please go respiring to apply change."),
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
                    Button("No more lock after respiring") {
                                            showAlert.toggle()
                                            writeIt(contents: "<?xml version=\"1.0\" encoding=\"utf-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>SBDontLockAfterCrash</key> <true/> </dict> </plist>", filepath: "/var/Managed Preferences/mobile/com.apple.springboard.plist")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("What a shot !"),
                                                message: Text("You can now hold your breath to get ready to the adventure of you're life..."),
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
                    Button("Disable supervising") {
                                            showAlert.toggle()
                                            writeIt(contents: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>AllowPairing</key> <true/> <key>CloudConfigurationUIComplete</key> <true/> <key>ConfigurationSource</key> <integer>0</integer> <key>IsSupervised</key> <false/> <key>PostSetupProfileWasInstalled</key> <true/> </dict> </plist>", filepath: "/var/Managed Preferences/mobile/com.apple.springboard.plist")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("Goodbye..."),
                                                message: Text("We know that the supervising text can be annoying. Goodbye then ! (respire to apply changes)"),
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
//                    Button("Disable LocSim") {
//                                            
//                                        }
//                                        .alert(isPresented: $showAlert) {
//                                            Alert(
//                                                title: Text("Are you sure ?"),
//                                                message: Text("This will shutdown the current LocSim. Do you want to proceed ?"),
//                                                primaryButton: .default(
//                                                    Text("Yes"),
//                                                    action: {
//                                                        stopLocSim()
//                                                    }
//                                                ),
//                                                secondaryButton: .default(
//                                                    Text("No")
//                                                )
//                                            )
//                                        }
                        }
                    }
                }
            }
        }
