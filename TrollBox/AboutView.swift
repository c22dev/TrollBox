//
//  AboutView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
           VStack(alignment: .center) {
               Image("mypage-icon")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 100, height: 100)
                   .clipShape(Circle())

               Text("c22dev")
                   .font(.largeTitle)
                   .padding()

               Text("Welcome to my ToolBox app for TrollStore ! Pack up a lot of different tools for TrollStore, hope you enjoy it !")
                   .font(.body)
                   .padding()

               Button(action: {
                   if let url = URL(string: "https://github.com/c22dev/TrollBox") {
                       UIApplication.shared.open(url)
                   }
               }) {
                   Text("Visit the GitHub repo")
               }
               .padding()
               Button(action: {
                   UIApplication.shared.alert(title: "Rebuilding icon cache...", body: "Please wait", animated: false, withButton: false)
                   do {
                       try! RootHelper.rebuildIconCache()
                   }
                   catch { UIApplication.shared.change(body: error.localizedDescription) }
               }) {
                   Text("Rebuild icon cache")
               }
           }
       }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}


