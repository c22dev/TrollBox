////
////  BadgeColorChangerView.swift
////  DebToIPA
////
////  Created by exerhythm on 15.10.2022.
////
//

import SwiftUI
struct BadgeChangerView: View {
    @State private var dotColour = Color.red
    @State private var showingAlert = false
    var body: some View {
            List {
                Section {
                    ColorPicker(selection: $dotColour) {
                        Text("Colour")
                    }
                    Button("Apply") {
                        changeColour(colour: UIColor(dotColour))
                        showingAlert.toggle()
                    }.disabled(badgeButtonDiabled())
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Done!"),
                                message: Text("Respring your device to apply changes."),
                                primaryButton: .default(
                                    Text("Respring"),
                                    action: {
                                        let helper = ObjcHelper.init()
                                        helper.respring()
                                    }
                                ),
                                secondaryButton: .cancel(
                                    Text("Later"),
                                    action: {}
                                )
                            )
                        }
                }
            }
    }
}


struct BadgeChangerView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeChangerView()
    }
}
