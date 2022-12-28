//
//  FCView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 27/12/2022.
//

import SwiftUI

struct FontToReplace {
  var name: String
  var postScriptName: String
  var repackedPath: String
}

let fonts = [
  FontToReplace(
    name: "DejaVu Sans Condensed", postScriptName: "DejaVuSansCondensed",
    repackedPath: "DejaVuSansCondensed.woff2"),
  FontToReplace(
    name: "DejaVu Serif", postScriptName: "DejaVuSerif", repackedPath: "DejaVuSerif.woff2"),
  FontToReplace(
    name: "DejaVu Sans Mono", postScriptName: "DejaVuSansMono", repackedPath: "DejaVuSansMono.woff2"
  ),
  FontToReplace(name: "Go Regular", postScriptName: "GoRegular", repackedPath: "Go-Regular.woff2"),
  FontToReplace(name: "Go Mono", postScriptName: "GoMono", repackedPath: "Go-Mono.woff2"),
  FontToReplace(
    name: "Fira Sans", postScriptName: "FiraSans-Regular",
    repackedPath: "FiraSans-Regular.2048.woff2"),
]

struct FCView: View {
  @State private var message = "Pick a font - Make sure that Bold Text is turned off in settings - Warning ! Using this feature on lower than iOS 15 will not roll back with a reboot"
  var body: some View {
    VStack {
      Text(message).padding(16)
      ForEach(fonts, id: \.name) { font in
        Button(action: {
          message = "Running"
          overwriteWithFont(name: font.repackedPath) {
            message = $0
          }
        }) {
          Text(font.name).font(.custom(font.postScriptName, size: 18))
        }.padding(8)
      }
    }
  }
}

struct FCView_Previews: PreviewProvider {
  static var previews: some View {
    FCView()
  }
}
