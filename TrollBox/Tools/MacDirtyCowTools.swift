//
//  MacDirtyCowTools.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//

import SwiftUI

struct MacDirtyCowTools: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: NoCamSoundView()) {
                        HStack {
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("No Shutter Sound")
                        }
                    }
                    NavigationLink(destination: FCView()) {
                        HStack {
                            Image(systemName: "character.cursor.ibeam")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("iOS System Font Changer")
                        }
                    }
                    NavigationLink(destination: DockView()) {
                        HStack {
                            Image(systemName: "rectangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("Dock Options")
                        }
                    }
                    NavigationLink(destination: VChangerView())  {
                        HStack {
                            Image(systemName: "i.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("iOS Version Number Editor")
                        }
                    }
                }
            }
            .navigationTitle("MacDirtyCow Tools")
        }
    }
}



struct MacDirtyCowTools_Previews: PreviewProvider {
    static var previews: some View {
        MacDirtyCowTools()
    }
}
