//
//  STA_View.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//


import SwiftUI
import Foundation

struct STA_View: View {
    @State var enabled = true
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    @State var backupURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist")
    var body: some View {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            var enabled = true
        }
        else {
            var enabled = false
        }
        GeometryReader { proxy in
            VStack {
                HStack {
                    Text("Enabled")
                        .font(.headline)
                        .padding(.horizontal, 4)
                    Toggle(isOn: $enabled) {
                        Text("Screen Time")
                    }
                    .labelsHidden()
                }
                .padding(.top, 20)
                Group {
                    if enabled {
                        Image("scenabled")
                            .resizable()
                            .aspectRatio(contentMode:. fit)
                    } else {
                        Image("scdisabled")
                            .resizable()
                            .aspectRatio(contentMode:. fit)
                    }
                }
                .frame(maxWidth: proxy.size.width * 0.9)
                .padding()
                Text("Note : This is not guaranteed to work on every devices, or on iCloud Screen Time.")
                    .frame(width: 300, height: 100)
//                Button("Restore Backup File", action: {
//                    UIApplication.shared.confirmAlert(title: "Restore backup file ?", body: "We assume that you already disabled screen time in the app. Do you want to proceed and restore saved Screen Time ?", onOK: {
//                    do {
//                        try FileManager.default.removeItem(atPath: filePath)
//                    }
//                    catch {
//                        UIApplication.shared.alert(title: "ERROR !", body: "\(error)")
//                    }
//                    do {
//                        try FileManager.default.copyItem(at: backupURL, to: filePathURL)
//                    }
//                    catch {
//                        UIApplication.shared.alert(title: "ERROR !", body: "\(error)")
//                    }
//                    }, noCancel: false)
//                } )
//                Button("Delete Backup File", action: {
//                    UIApplication.shared.confirmAlert(title: "Delete backup file ?", body: "By deleting this file, you won't be able to restore this backup. Are you sure you want to proceed ?", onOK: {
//                    do {
//                        try FileManager.default.removeItem(atPath: backup)
//                    }
//                    catch {
//                        UIApplication.shared.alert(title: "ERROR !", body: "\(error)")
//                    }
//                        UIApplication.shared.alert(title: "Succes ! Please restart.", body: "Success ! Please be sure to restart you're device.")
//                    }, noCancel: false)
//                } )
//                     .frame(width: 300, height: 100)
                 .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Screen Time Disabler")
        .onChange(of: enabled) { isEnabled in
            removeST()
        }
    }
}


// Screen time function

func removeST() {
    // Some vars for paths
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    @State var backupURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist")
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    // File manager var
    let fileManager = FileManager.default
    // Script start
        UIApplication.shared.confirmAlert(title: "Remove screen time ?", body: "This will disable screen time and parental restrictions. Please note that this may not work for you're device !", onOK: {
//        if !fileManager.fileExists(atPath: backup) {
//            do {
//                try FileManager.default.copyItem(at: filePathURL, to: backupURL)
//            }
//            catch {
//                UIApplication.shared.alert(title: "ERROR !", body: "\(error)")
//            }
//        }
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            UIApplication.shared.alert(title: "error while removing file !", body: "\(error)")
        }
        killall("ScreenTimeAgent")
        UIApplication.shared.alert(title: "Succes ! Please restart.", body: "Success ! As we couldn't kill ScreenTimeAgent, please be sure to restart you're device.")
        }, noCancel: false)
}


struct STA_View_Previews: PreviewProvider {
    static var previews: some View {
        STA_View()
    }
}
