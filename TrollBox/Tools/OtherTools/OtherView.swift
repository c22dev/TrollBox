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
                Section(header: Text("Gestures")) {
                    Toggle("Enabled", isOn: $homeGesture)
                        .disabled(homeGestureToggleDisabled())
                    Button("Apply") {
                        applyHomeGuesture(homeGesture)
                        showingAlerty.toggle()
                    }.disabled(homeGestureButtonDisabled(homeGesture))
                }
                Section {
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
                    Toggle(isOn: $enabled) {
                        Text("Disable locking after respiring")
                    }
                        }
                    }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        respring()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onChange(of: enabled) { isEnabled in
                do {
                    let url = URL(fileURLWithPath: "/var/preferences/com.apple.springboard.plist")
                    if !FileManager.default.fileExists(atPath: url.path) {
                        let templatePlistURL = Bundle.main.url(forResource: "com.apple.springboard", withExtension: "plist")!
                        try RootHelper.copy(from: templatePlistURL, to: url)
                    }
                    
                    let tempURL = URL(fileURLWithPath: "/var/mobile/.DO-NOT-DELETE-TrollBox/.temp-\(url.lastPathComponent)")
                    try RootHelper.copy(from: url, to: tempURL)
                    try RootHelper.setPermission(url: tempURL)
                    
                    guard let data = try? Data(contentsOf: tempURL), var plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not find carrier name"]) }
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
