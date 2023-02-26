//
//  CarrierNameManager.swift
//  TrollTools
//
//  Created by exerhythm on 13.11.2022.
//

import Foundation

class CarrierNameManager {
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
