//
//  STA_View.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//


import SwiftUI

struct STA_View: View {
    @State var filePath = "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist"
    @State var filePathURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.apple.ScreenTimeAgent.plist")
    var body: some View {
        let fileManager = FileManager.default
        var enabled = true
        if fileManager.fileExists(atPath: filePath) {
            var enabled = true
        } else {
            var enabled = false
        }
        GeometryReader { proxy in
            VStack {
                HStack {
                    Text("Enabled")
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
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Screen Time")
        .onChange(of: enabled) { isEnabled in
            do {
                try RootHelper.removeItem(at: filePathURL)
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
