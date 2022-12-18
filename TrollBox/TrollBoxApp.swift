//
//  TSSwissKnifeApp.swift
//  TrollBox
//
//  Created by Constantin Clerc on 16/12/2022.
//

import SwiftUI

@main
struct TSSwissKnifeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    for url in (try? FileManager.default.contentsOfDirectory(at: FileManager.default.temporaryDirectory, includingPropertiesForKeys: nil)) ?? [] {
                        try? FileManager.default.removeItem(at: url)
                    }
                    
                    // root ?
                    do {
                        try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
                    } catch {
                        UIApplication.shared.alert(body: "The app needs to be installed either using TrollStore or on Jailbroken devices error: \(error)", withButton: false)
                    }
                    //update ?
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let url = URL(string: "https://api.github.com/repos/c22dev/TrollBox/releases/latest") {
                        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                            guard let data = data else { return }
                            
                            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                if json["tag_name"] as? String != version {
                                    //Pop-up alert. Replace with anything you want (keep temp end)
                                    UIApplication.shared.confirmAlert(title: "Update available", body: "Do you want to download the update from the Github ?", onOK: {
                                        UIApplication.shared.open(URL(string: "https://github.com/c22dev/TrollBox/releases/latest")!)
                                    }, noCancel: false)
                                    //keep resume if you cut things from here
                                }
                            }
                        }
                        task.resume()
                    }
                }
            }
        }
    }

// Sourceloc code
var currentUIAlertController: UIAlertController?

extension UIApplication {
    func dismissAlert(animated: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController?.dismiss(animated: animated)
        }
    }
    func alert(title: String = "Error", body: String, animated: Bool = true, withButton: Bool = true) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if withButton { currentUIAlertController?.addAction(.init(title: "OK", style: .cancel)) }
            self.present(alert: currentUIAlertController!)
        }
    }
    func confirmAlert(title: String = "Error", body: String, onOK: @escaping () -> (), noCancel: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if !noCancel {
                currentUIAlertController?.addAction(.init(title: "Cancel", style: .cancel))
            }
            currentUIAlertController?.addAction(.init(title: "OK", style: noCancel ? .cancel : .default, handler: { _ in
                onOK()
            }))
            self.present(alert: currentUIAlertController!)
        }
    }
    func change(title: String = "Error", body: String) {
        DispatchQueue.main.async {
            currentUIAlertController?.title = title
            currentUIAlertController?.message = body
        }
    }
    
    func present(alert: UIAlertController) {
        if var topController = self.windows[0].rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true)
            // topController should now be your topmost view controller
        }
    }
}

