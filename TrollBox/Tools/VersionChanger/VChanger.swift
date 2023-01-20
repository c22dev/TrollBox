//
//  OtherModsView.swift
//  DockHider
//
//  Created by lemin on 1/6/23.
//

import SwiftUI

struct VChangerView: View {
    @State private var CurrentVersion: String = getSystemVersion()
    let operatingSystemVersion = ProcessInfo().operatingSystemVersion
    var body: some View {
        VStack {
            // title
            Text("Edit iOS Version Number")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            HStack {
                Image(systemName: "gear.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                
                Text("iOS Version")
                    .minimumScaleFactor(0.5)
                    .padding(.trailing, 50)
                
                Button(CurrentVersion, action: {
                    let defaults = UserDefaults.standard
                    // create and configure alert controller
                    let alert = UIAlertController(title: "Input Product Version", message: "Please note that this will not downgrade your phone, just change it in settings app. Do not use this on iOS 14, or go at you're own risk.", preferredStyle: .alert)
                    // bring up the text prompt
                    alert.addTextField { (textField) in
                        textField.placeholder = "Version"
                        textField.text = defaults.string(forKey: "ProductVersion") ?? CurrentVersion
                    }
                    
                    // buttons
                    alert.addAction(UIAlertAction(title: "Apply", style: .default) { (action) in
                        // set the version
                        let newVersion: String = alert.textFields?[0].text! ?? CurrentVersion
                        setProductVersion(newVersion: newVersion) { succeeded in
                            if succeeded {
                                CurrentVersion = newVersion
                                // set the default
                                defaults.set(newVersion, forKey: "ProductVersion")
                            }
                        }
                    })
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                        // cancel the process
                    })
                    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                })
                    .padding(.leading, 10)
            }
        }
        .onAppear{
            if operatingSystemVersion.majorVersion <= 14 && operatingSystemVersion.minorVersion <= 8 {
                UIApplication.shared.confirmAlert(title: "WARNING !", body: "You're using this tool on a specific version of iOS, and all the modifications may be irreversible. Changing version can make you lose your jailbreak. More information by clicking Yes.", onOK: {
                    UIApplication.shared.open(URL(string: "https://www.reddit.com/r/jailbreak/comments/zxm9i7/tip_do_not_install_wdbfontoverwrite_via/")!)
                }, noCancel: false)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.confirmAlert(title: "WARNING !", body: "Using this tool on jailbreak and other versions of iOS may be irreversible, and changing version can make you lose your jailbreak. More information by clicking Yes.", onOK: {
                        UIApplication.shared.open(URL(string: "https://www.reddit.com/r/jailbreak/comments/zxm9i7/tip_do_not_install_wdbfontoverwrite_via/")!)
                    }, noCancel: false)
                }) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct VChangerView_Previews: PreviewProvider {
    static var previews: some View {
        VChangerView()
    }
}
