//
//  MacDirtyCowTools.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/01/2023.
//

import SwiftUI
struct MacDirtyCowTools: View {
    @State private var CurrentVersion: String = getSystemVersion()
    let operatingSystemVersion = ProcessInfo().operatingSystemVersion
    var body: some View {
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
//            .navigationBarTitle("MacDirtyCow Tools")
//            .padding(.top, 10)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        UIApplication.shared.confirmAlert(title: "WARNING !", body: "Using this tool on jailbreak and other versions of iOS may be irreversible. More information by clicking Yes.", onOK: {
//                            UIApplication.shared.open(URL(string: "https://www.reddit.com/r/jailbreak/comments/zxm9i7/tip_do_not_install_wdbfontoverwrite_via/")!)
//                        }, noCancel: false)
//                    }) {
//                        Image(systemName: "exclamationmark.triangle")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 24, height: 24)
//                }
//            }
//        }
//            .onAppear{
//                if operatingSystemVersion.majorVersion <= 14 && operatingSystemVersion.minorVersion <= 8 {
//                    UIApplication.shared.confirmAlert(title: "WARNING !", body: "Using this tool on jailbreak and other versions of iOS may be irreversible. More information by clicking Yes.", onOK: {
//                        UIApplication.shared.open(URL(string: "https://www.reddit.com/r/jailbreak/comments/zxm9i7/tip_do_not_install_wdbfontoverwrite_via/")!)
//                    }, noCancel: false)
//                }
//            }
    }
}

struct MacDirtyCowTools_Previews: PreviewProvider {
    static var previews: some View {
        MacDirtyCowTools()
    }
}
