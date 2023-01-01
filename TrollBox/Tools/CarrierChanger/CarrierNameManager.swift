//
//  CarrierNameManager.swift
//  TrollTools
//
//  Created by exerhythm on 13.11.2022.
//

import Foundation

class CarrierNameManager {
    static func change(to str: String) throws {
        let fm = FileManager.default
        let fileManager = FileManager.default
        
        for url in try fm.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile/Library/Carrier Bundles/Overlay/"), includingPropertiesForKeys: nil) {
            remLog(url)
            let tempURL = URL(fileURLWithPath: "/var/mobile/Library/Application Support/TrollBox/\(url.lastPathComponent)")
            guard let data = try? Data(contentsOf: url) else { continue }
            guard var plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { continue }
            
            // Modify values
            let fileManager = FileManager.default
            let folderURL = URL(fileURLWithPath: "/var/mobile/Library/Carrier Bundles/Overlay/")

            do {
                let plistFiles = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
                    .filter { $0.pathExtension == "plist" }

                for plistFile in plistFiles {
                    do {
                        try? RootHelper.removeItem(at: tempURL)
                        let data = try Data(contentsOf: plistFile)
                        try? RootHelper.copy(from: plistFile, to: tempURL)
                        if var plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
                            // Modify the plist dictionary as needed
                            if var images = plist["StatusBarImages"] as? [[String: Any]] {
                                 for var (i, image) in images.enumerated() {
                                     image["StatusBarCarrierName"] = str
                                     
                                     images[i] = image
                                 }
                                 plist["StatusBarImages"] = images
                             }

                            // Write the modified plist dictionary back to the file
                            guard let plistData = try? PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0) else { continue }
                            try? plistData.write(to: tempURL)
                            try? RootHelper.move(from: tempURL, to: plistFile)
                        }
                    } catch {
                        throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error edditing plist file: \(error)"])
                    }
                }
            } catch {
                throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error listing files in folder: \(error)"])
            }
            
            remLog("moving")
        }
    }
    
    static func getCarrierName() throws -> String {
        let fm = FileManager.default

        for url in try fm.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile/Library/Carrier Bundles/Overlay/"), includingPropertiesForKeys: nil) {
            guard let data = try? Data(contentsOf: url) else { continue }
            guard let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { continue }

            // read the value
            if let images = plist["StatusBarImages"] as? [[String: Any]] {
                for var (_, image) in images.enumerated() {
                    if image["StatusBarCarrierName"] != nil {
                        return image["StatusBarCarrierName"] as! String
                    }
                }
            }
        }

        // no value was found
        throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not find carrier name"])
    }
}
