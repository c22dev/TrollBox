//
//  RegionRestrict.swift
//  TrollBox
//
//  Created by Constantin Clerc on 25/01/2023.
//

import SwiftUI

// Code from lemin, thanks you dude !
func setRegion() {
    DispatchQueue.global(qos: .userInteractive).async {
        do {
            let plistPath: String = "/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist"
            let plistData = try Data(contentsOf: URL(fileURLWithPath: plistPath))
            let originalSize = plistData.count
            
            // open plist
            var plist = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as! [String: Any]
            
            func modifyKey(_ dict: [String: Any], _ key: String, newValue: String) -> [String: Any]? {
                if var firstLevel = dict["CacheExtra"] as? [String : Any], var secondLevel = firstLevel[key] as? String {
                    secondLevel = newValue
                    firstLevel[key] = secondLevel
                    return firstLevel
                }
                return nil
            }
            
            // modify values
            let keysToChange: [String: String] = [
                "h63QSdBCiT/z0WU6rdQv6Q": "LL",
                "zHeENZu+wbg7PUprwNwBWg": "LL/A",
                "IMLaTlxS7ITtwfbRfPYWuA": "A"
            ]
            var succeeded = true
            for (k, val) in keysToChange {
                let newLevel = modifyKey(plist, k, newValue: val)
                if newLevel != nil {
                    plist["CacheExtra"] = newLevel
                } else {
                    print("Error with key " + k)
                    succeeded = false
                }
            }
            
            if succeeded {
                // my part of the code
                var newData = try PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
                let nDstr = String(decoding: newData, as: UTF8.self)
                writeIt(contents: nDstr, filepath: plistPath)
            }
        } catch {
            print("An error occurred while setting region")
            UIApplication.shared.alert(body: "An error occurred while setting region")
            }
        }
    }
