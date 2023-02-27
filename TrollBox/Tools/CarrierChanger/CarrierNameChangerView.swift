//
//  CarrierNameChangerView.swift
//  TrollTools
//
//  Created by exerhythm on 13.11.2022.
//

import SwiftUI
struct CarrierNameChangerView: View {
    let fm = FileManager.default
    @Environment(\.openURL) var openURL
    @State private var carrierBoxSize: [CGFloat] = [.zero, .zero]
    @State private var carrierOffset: [CGFloat] = [.zero, .zero]
    @State private var currentText: String = "ae"
    @State private var currentcarrier: String = StatusManager.sharedInstance().getCarrierOverride()
    var body: some View {
        NavigationView {
            List {
                if (StatusManager.sharedInstance().isMDCMode()) {
                    Section (footer: Text("Your device will respring.")) {
                        Button("Apply") {
                            if fm.fileExists(atPath: "/var/mobile/Library/SpringBoard/statusBarOverridesEditing") {
                                do {
                                    _ = trz fm.replaceItemAt(URL(fileURLWithPath: "/var/mobile/Libray/SpringBoard/statusBarOverrides"), withItemAt: URL(fileURLWithPath: "/var/mobile/Libray/SpringBoard/statusBarOverridesEditing"))
                                    respringFrontBoard()
                                } catch {
                                    UIApplication.shared.alert(body: "\(error)")
                                }
                            }
                        }
                    }
                }
            }
        }
        GeometryReader { proxy in
            VStack {
                Group {
                    ZStack(alignment: .center) {
                        Image("carrier")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(GeometryReader { (geometry) -> Color in
                                DispatchQueue.main.async {
                                    // set the carrier textbox size
                                    carrierBoxSize[0] = geometry.size.width/3
                                    carrierBoxSize[1] = geometry.size.height/25
                                    
                                    // set the carrier textbox offset
                                    carrierOffset[0] = -geometry.size.width/2 + (135/640)*geometry.size.width + carrierBoxSize[0]/2
                                    carrierOffset[1] = -geometry.size.height/2 + (164/1318) * geometry.size.height + carrierBoxSize[1]/2
                                }
                                return .clear
                            })
                        TextField("carrier", text: $currentcarrier)
                            .offset(x: carrierOffset[0], y: carrierOffset[1])
                            .frame(width: carrierBoxSize[0], height: carrierBoxSize[1], alignment: .center)
                            .multilineTextAlignment(.leading)
                        
                    }
                }
                .frame(maxWidth: proxy.size.width * 0.9)
                .padding()
                
                Button("Apply") {
                    do {
                        try StatusManager.sharedInstance().setCarrier(currentText)
                        UIApplication.shared.alert(title: "Success!", body: "Please respring your device for the changes to take effect.")
                    } catch {
                        UIApplication.shared.alert(body: error.localizedDescription)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity)
        }
    }
}

struct CarrierNameChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierNameChangerView()
    }
}
