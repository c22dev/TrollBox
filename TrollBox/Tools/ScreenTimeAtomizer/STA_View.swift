//
//  STA_View.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//


import SwiftUI

struct STA_View: View {
    @State var enabled = true
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    @State var backupURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist")
    @State var backup = "/var/mobile/Library/Preferences/live.cclerc.ScreenTimeAgent.plist"
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
            }
            .frame(maxWidth: .infinity)
            Text("Note : This is not guaranteed to work on every devices, or on iCloud Screen Times.")
                .frame(width: 300, height: 100)
            .padding(.bottom)
        }
        .navigationTitle("Screen Time")
        .onChange(of: enabled) { isEnabled in
            do {
                if fileManager.fileExists(atPath: backup) {
                    UIApplication.shared.alert(title: "About to restore screen time !", body: "This will restore the past screen time that you disabled. No settings will be changed.")
                    try RootHelper.copy(from: backupURL, to: filePathURL)
                    UIApplication.shared.alert(title: "Succes !", body: "The screen time is back on ! We will now attempt to kill ScreenTimeAgent")
                    killall("ScreenTimeAgent")
                    UIApplication.shared.alert(title: "Oops, please restart.", body: "As we can't kill ScreenTimeAgent, please be sure to restart you're device.")
                }
                else {
                    UIApplication.shared.alert(title: "Remove screen time", body: "This will disable screen time and parental restrictions.")
                    try RootHelper.copy(from: filePathURL, to: backupURL)
                    try RootHelper.removeItem(at: filePathURL)
                    UIApplication.shared.alert(title: "Succes !", body: "The screen time were successfuly disabled ! We will now attempt to kill ScreenTimeAgent")
                    killall("ScreenTimeAgent")
                    UIApplication.shared.alert(title: "Oops, please restart.", body: "As we couldn't kill ScreenTimeAgent, please be sure to restart you're device.")
                    
                }
            }
            catch {
                print(error)
            }
        }
    }
}


struct STA_View_Previews: PreviewProvider {
    static var previews: some View {
        STA_View()
    }
}
