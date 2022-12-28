//
//  ContentView.swift
//  NoCameraSound
//
//  Created by すとれーとたまご★ on 2022/12/28.
//

import SwiftUI

struct NoCamSoundView: View {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    @State private var message = ""
    @State private var showingAlert = false
    var body: some View {
        VStack {
            HStack {
                Button("Disable Shutter Sound") {
                    ac()
                    ac()
                    ac()
                    ac()
                    ac()
                }
                .padding()
            }
          Text(message).padding(16)
        Text("Using this feature on lower than iOS 15 will not roll back with a reboot")
        }.onAppear {
            if UserDefaults.standard.bool(forKey: "AutoRun") == true {
                ac()
                ac()
                ac()
                ac()
                ac()
            }
        }
    }
    func ac() {
        message = "photoShutter.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/photoShutter.caf") {
            message = $0
        }
        message = "begin_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/begin_record.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/end_record.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf") {
            message = $0
        }
        message = "end_record.caf"
        overwriteAsync(path: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf") {
            message = $0
        }
    }
}

struct NoCamSoundView_Previews: PreviewProvider {
  static var previews: some View {
      NoCamSoundView()
  }
}
