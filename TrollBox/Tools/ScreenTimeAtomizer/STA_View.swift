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
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Button("Disable", action: {
                        removeST()
                    })
                        .font(.headline)
                        .padding(.horizontal, 4)
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
                Button("Restore Backup File", action: {
                    restoreST()
                } )
                Button("Delete Backup File", action: {
                    deletebackup()
                } )
                     .frame(width: 300, height: 100)
                 .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Screen Time Disabler")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.alert(title: "Various Info", body: "If this tool is not working for you, you should delete a file located in : /var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist with the file explorer of you're chocie.")
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
            }
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
    if fileManager.fileExists(atPath: filePath) {
        UIApplication.shared.confirmAlert(title: "Remove screen time ?", body: "This will disable screen time and parental restrictions. Please note that this may not work for you're device !", onOK: {
            if fileManager.fileExists(atPath: backup) {
                try! FileManager.default.removeItem(at: backupURL)
            }
            
            if !fileManager.fileExists(atPath: backup) {
                try! FileManager.default.moveItem(at: filePathURL, to: backupURL)
            }
            killall("ScreenTimeAgent")
            UIApplication.shared.alert(title: "Succes ! Please restart.", body: "Success ! As we are not able to kill ScreenTimeAgent, please be sure to restart you're device.")
        }, noCancel: false)
    }
    else {
        UIApplication.shared.alert(title: "There is no screentime on you're device.", body: "Why are you doing that ?.")
    }
}


func deletebackup() {
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    UIApplication.shared.confirmAlert(title: "Delete backup file ?", body: "By deleting this file, you won't be able to restore this backup. Are you sure you want to proceed ?", onOK: {
    do {
        try FileManager.default.removeItem(atPath: backup)
    }
    catch {
        UIApplication.shared.alert(title: "ERROR !", body: "\(error)")
    }
        UIApplication.shared.alert(title: "Succes ! Please restart.", body: "Success ! Please be sure to restart you're device.")
    }, noCancel: false)
}


func restoreST() {
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    @State var backupURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist")
    if FileManager.default.fileExists(atPath: backup) {
        UIApplication.shared.confirmAlert(title: "Restore backup file ?", body: "Do you want to proceed and restore saved Screen Time ?", onOK: {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                UIApplication.shared.confirmAlert(title: "Discovered existing Screen Time", body: "Delete this ?", onOK: {
                    try! FileManager.default.removeItem(atPath: filePath)
                }, noCancel: true)
            }
            UIApplication.shared.confirmAlert(title: "Ready to move back the backup", body: "Ready ?", onOK: {
                try! FileManager.default.moveItem(at: backupURL, to: filePathURL)
                killall("ScreenTimeAgent")
                UIApplication.shared.alert(title:"Restart is required", body:"Restart you're iPhone to apply changes.")
            }, noCancel: true)
        }, noCancel: false)
    }
}
struct STA_View_Previews: PreviewProvider {
    static var previews: some View {
        STA_View()
    }
}
