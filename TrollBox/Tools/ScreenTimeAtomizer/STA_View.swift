//
//  STA_View.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//


import SwiftUI
import Foundation

struct STA_View: View {
    @State private var scen = checkST()
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    Button("Disable", action: {
                        removeST()
                        var scen = false
                    })
                        .font(.headline)
                        .padding(.horizontal, 4)
                    .labelsHidden()
                }
                .padding(.top, 20)
                Group {
                    if scen == true {
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
                    UIApplication.shared.alert(title: "Various Info", body: "If this tool is not working for you, you should delete a file located in : /var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist with the file explorer of you're choice. This is a tool I made myself.")
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



func checkST() -> Bool {
    var scen = true
    if FileManager.default.fileExists(atPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist") {
        scen = true
    }
    else {
        scen = false
    }
    return scen
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
        UIApplication.shared.confirmAlert(title: "Remove screen time ?", body: "This will disable screen time and parental restrictions. A backup will be created in case of issues.", onOK: {
            if fileManager.fileExists(atPath: backup) {
                try! FileManager.default.removeItem(at: backupURL)
            }
            
            if !fileManager.fileExists(atPath: backup) {
                try! FileManager.default.moveItem(at: filePathURL, to: backupURL)
                if fileManager.fileExists(atPath: filePath) {
                    try! FileManager.default.removeItem(at: filePathURL)
                }
            }
            UIApplication.shared.confirmAlert(title: "Success ! Please restart after pressing Yes on the pop-up", body: "We will now kill ScreenTimeAgent. The app may crash, you will have to restart after.", onOK : {
                killall("com.apple.ScreenTimeAgent")
                killall("com.apple.ScreenTimeAgent.plist")
                killall("com.apple.ScreenTime")
                killall("com.apple.ScreenTimeAgent")
                killall("ScreenTimeAgent")
            }, noCancel: true)
            UIApplication.shared.alert(title: "Success !", body: "Please restart your device.")
        }, noCancel: false)
    }
    else {
        UIApplication.shared.alert(title: "There is no screentime on you're device.", body: "Why are you doing that ?")
    }
}


func deletebackup() {
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    UIApplication.shared.confirmAlert(title: "Delete backup file ?", body: "By deleting this file, you won't be able to restore the backup. Are you sure you want to proceed ?", onOK: {
        if FileManager.default.fileExists(atPath: backup) {
            try! FileManager.default.removeItem(atPath: backup)
        }
        UIApplication.shared.alert(title: "Success !", body: "The backup data have been deleted.")
    }, noCancel: false)
}


func restoreST() {
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    @State var backupURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist")
    if FileManager.default.fileExists(atPath: backup) {
        UIApplication.shared.confirmAlert(title: "Restore backup file ?", body: "Do you want to proceed and restore previous Screen Time ?", onOK: {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                UIApplication.shared.confirmAlert(title: "Discovered an existing session of Screen Time", body: "Delete it ?", onOK: {
                    try! FileManager.default.removeItem(atPath: filePath)
                }, noCancel: true)
            }
            UIApplication.shared.confirmAlert(title: "Ready to move back the backup", body: "Proceed ?", onOK: {
                try! FileManager.default.moveItem(at: backupURL, to: filePathURL)
                UIApplication.shared.confirmAlert(title: "Success ! Please restart", body: "We will now kill ScreenTimeAgent. The app may crash, you will have to restart after.", onOK : {
                    killall("com.apple.ScreenTimeAgent")
                    killall("com.apple.ScreenTimeAgent.plist")
                    killall("com.apple.ScreenTime")
                    killall("com.apple.ScreenTimeAgent")
                    killall("ScreenTimeAgent")
                }, noCancel: true)
                UIApplication.shared.alert(title: "Success !", body: "Please restart your device.")
            }, noCancel: true)
        }, noCancel: false)
    }
}
struct STA_View_Previews: PreviewProvider {
    static var previews: some View {
        STA_View()
    }
}
