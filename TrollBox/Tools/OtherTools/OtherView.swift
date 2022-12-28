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
    @State private var homeGesture = getCurrentState()
    @State private var showingAlert = false
    @State private var showingAlerty = false
    @State private var showAlert = false
    @State var enabled = UserDefaults.standard.bool(forKey: "RespringAfterRespringEnabled")
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
                        writeToFileWithContents(contents: "<?xml version=\"1.0\" encoding=\"utf-8\"?> <!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"apple.com/DTDs/PropertyList-1.0.dtd\"> <plist version=\"1.0\"> <dict> <key>SBDontLockAfterCrash</key> <true/> </dict> </plist>", filepath: "/var/Managed Preferences/mobile/com.apple.springboard.plist")
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
                        writeToFileWithContents(contents: "Placeholder text that was edited by Jaility.", filepath: "/var/Managed Preferences/mobile/com.apple.springboard.plist")
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
                Section(header: Text("Show an iPad only feature in you're control center"), footer: Text("Please remember to add it trough Settings -> Control Center")) {
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
                    Section(header: Text("Home Gesture"), footer: Text("Device Layout to iPhone XS layout. It is totally safe but you may experience some UI glitches and screenshot is not working at the moment.")) {
                        Toggle("Enabled", isOn: $homeGesture)
                            .disabled(homeGestureToggleDisabled())
                        Button("Apply") {
                            applyHomeGuesture(homeGesture)
                            showingAlert.toggle()
                        }.disabled(homeGestureButtonDisabled(homeGesture))
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("It worked ! Respring and check you're gestures will be working !"),
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
