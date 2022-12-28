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
            let tempURL = URL(fileURLWithPath: "/var/mobile/.DO-NOT-DELETE-TrollBox/\(url.lastPathComponent)")
            do {
                // Get the URL of the location where the folder should be created
                let folderURL = URL(fileURLWithPath: "/var/mobile/.DO-NOT-DELETE-TrollBox/")

                // Use the `createDirectory` method to create the folder
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false)
            } catch {
                throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "\(error)"])
            }
            do {
                // Use the `copyItem` method to copy the file to the destination directory
                try fileManager.copyItem(at: url, to: tempURL)
            } catch {
                throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "\(error)"])
            }
            do {
                try fileManager.removeItem(at: url)
            } catch {
                throw NSError(domain: "CarrierName", code: 0, userInfo: [NSLocalizedDescriptionKey: "\(error)"])
            }
            
            guard let data = try? Data(contentsOf: tempURL) else { continue }
            guard var plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else { continue }
            
            // Modify values
            if var images = plist["StatusBarImages"] as? [[String: Any]] {
                for var (i, image) in images.enumerated() {
                    image["StatusBarCarrierName"] = str
                    
                    images[i] = image
                }
                plist["StatusBarImages"] = images
            }
            
            // Save plist
            guard let plistData = try? PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0) else { continue }
            try? plistData.write(to: tempURL)
            
            remLog("moving")
            do {
                // Use the `copyItem` method to copy the file to the destination directory
                try fileManager.copyItem(at: tempURL, to: url)
            } catch {
                // Handle the error
            }
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
