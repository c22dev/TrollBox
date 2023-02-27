//
//  AboutView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//

import SwiftUI

struct AboutView: View {
    let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var body: some View {
           VStack(alignment: .center) {
               Image("mypage-icon")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 100, height: 100)
                   .clipShape(Circle())

               Text("fartlocation")
                   .font(.largeTitle)
                   .padding()

               Text("Welcome to my fork of TrollBox, it's just trollbox but with MDC support to most tools so I hope you enjoy it !")
                   .font(.body)
                   .padding()

               Button(action: {
                   if let url = URL(string: "https://github.com/diyar2137237243/TrollBox") {
                       UIApplication.shared.open(url)
                   }
               }) {
                   Text("Visit the GitHub repo")
               }
               .padding()
               Button(action: {
                   if let url = URL(string: "https://github.com/diyar2137237243/TrollBox/releases/latest") {
                       UIApplication.shared.open(url)
                   }
               })  {
                   Text("Version :  \(String(version))")
               }
               .padding()
           }
       }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}


