//
//  ToolsView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//


import SwiftUI
struct ToolsView: View {
    var issbx = UserDefaults.standard.string(forKey: "latsandbox")
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: PasscodeEditorView()) {
                        HStack {
                            Image(systemName: "lock.fill")
                                .resizable() 
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("Passcode Themer")
                        }
                    }
                    if issbx == "false" {
                    }
                    else {
                        NavigationLink(destination: CarrierNameChangerView()) {
                            HStack {
                                Image(systemName: "network")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                Text("Carrier Changer")
                            }
                        }
                    }
                    if issbx == "false" {
                    }
                    else {
                        NavigationLink(destination: WalSetView()) {
                            HStack {
                                Image(systemName: "wand.and.rays")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                Text("Wallpaper Setter")
                            }
                        }
                    }
                    NavigationLink(destination: MainCardView()) {
                        HStack {
                            Image(systemName: "creditcard.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("Apple Pay Card Custom image")
                        }
                    }
                    NavigationLink(destination: LSFootnoteChangerView()) {
                        HStack {
                            Image(systemName: "arrow.down.doc.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("Lock Screen Footnote")
                        }
                    }
                    NavigationLink(destination: BadgeChangerView()) {
                        HStack {
                            Image(systemName: "app.badge.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                            Text("Badge Color Changer")
                        }
                    }
                    if issbx == "false" {
                    }
                    else {
                        NavigationLink(destination: LocationSimulationView()) {
                            HStack {
                                Image(systemName: "mappin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                Text("LocSim")
                            }
                        }
                    }
                    Section {
                        NavigationLink(destination: STA_View()) {
                            HStack {
                                Image(systemName: "hourglass")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                Text("ScreenTime Remover")
                            }
                        }
//                        NavigationLink(destination: CalculatorErrorView()) {
//                            HStack {
//                                Image(systemName: "exclamationmark.circle")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 24, height: 24)
//                                    .foregroundColor(.primary)
//                                Text("Calculator Error Changer")
//                            }
//                        }
                        NavigationLink(destination: OtherView()) {
                            HStack {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.primary)
                                Text("Other minor tools")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("TrollBox")
            .padding(.top, 10)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        respring()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if let url3 = URL(string: "https://discord.gg/8gMyK6DSnB") {
                                UIApplication.shared.open(url3)
                            }
                        }) {
                            Image("discord")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 27, height: 27)
                        }
                    }
                }
            }
    }
}

extension Color {
    static let primary = Color("AccentColor")
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
