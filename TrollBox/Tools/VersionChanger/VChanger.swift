//
//  OtherModsView.swift
//  DockHider
//
//  Created by lemin on 1/6/23.
//

import SwiftUI

struct VChangerView: View {
    @State private var CurrentVersion: String = getSystemVersion()
    
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
    }
}

struct VChangerView_Previews: PreviewProvider {
    static var previews: some View {
        VChangerView()
    }
}
