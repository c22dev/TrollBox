//
//  ToolsView.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//


import SwiftUI
struct ToolsView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: AirSpamView()) {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.purple)
                            Text("AirSpam")
                        }
                    }
                    NavigationLink(destination: CarrierNameChangerView()) {
                        HStack {
                            Image(systemName: "network")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.purple)
                            Text("Carrier Changer")
                        }
                    }
                    NavigationLink(destination: LocationSimulationView()) {
                        HStack {
                            Image(systemName: "map.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.purple)
                            Text("LocSim")
                        }
                    }
                    NavigationLink(destination: GesturesView()) {
                        HStack {
                            Image(systemName: "iphone")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.purple)
                            Text("Enable Gestures")
                        }
                    }
                    NavigationLink(destination: OtherView()) {
                        HStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.purple)
                            Text("Other minor tools")
                        }
                    }
                }
            }
            .navigationBarTitle("TrollBox")
            .padding(.top, 10) 
        }
    }
}



struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
