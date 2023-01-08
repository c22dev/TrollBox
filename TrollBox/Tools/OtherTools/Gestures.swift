//
//  Gestures.swift
//  TrollBox
//
//  Created by Constantin Clerc on 24/12/2022.
//

func applyHomeGuesture(_ enabled: Bool) {
    if enabled {
        // Enable
        let helper = ObjcHelper.init()
        checkAndCreateBackupFolder()
        
        let prefs = MGPreferences.init(identifier: "live.cclerc.TrollBox")
        if prefs.dictionary["DeviceSubType"] == nil {
            prefs.dictionary.setValue(helper.getDeviceSubType(), forKey: "DeviceSubType")
            prefs.updatePlist()
        }
        helper.updateDeviceSubType(2436)
    } else {
        // Disable
        checkAndCreateBackupFolder()
        let helper = ObjcHelper.init()
        let prefs = MGPreferences.init(identifier: "live.cclerc.TrollBox")
        if prefs.dictionary["DeviceSubType"] != nil {
            helper.updateDeviceSubType(prefs.dictionary["DeviceSubType"] as! Int)
        }
        let olddevicesubtype = UserDefaults.standard.string(forKey: "devicesubits")!
        helper.updateDeviceSubType(Int(olddevicesubtype) ?? 569)
    }
}

func checkAndCreateBackupFolder() {
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: "/private/var/mobile/TrollBox/") {
        try? fileManager.createDirectory(atPath: "/private/var/mobile/TrollBox", withIntermediateDirectories: true)
    }
    
    if !fileManager.fileExists(atPath: "/private/var/mobile/TrollBox/Themes") {
        try? fileManager.createDirectory(atPath: "/private/var/mobile/TrollBox/Themes", withIntermediateDirectories: true)
    }
}

func getCurrentState() -> Bool {
    checkAndCreateBackupFolder()
    let helper = ObjcHelper.init()
    let prefs = MGPreferences.init(identifier: "live.cclerc.TrollBox")
    if prefs.dictionary["DeviceSubType"] != nil {
        if prefs.dictionary["DeviceSubType"] as! Int != helper.getDeviceSubType() as! Int {
            return true
        }
    }
    UserDefaults.standard.set(prefs.dictionary, forKey: "devicesubits")
    
    return false
}

func homeGestureToggleDisabled() -> Bool {
    if checkSandbox() {
        return true
    }
    
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    let unsupported: [String] = ["iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8", "iPhone12,1", "iPhone12,3", "iPhone12,5", "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5"]
    
    if unsupported.contains(identifier) {
        return true
    }
    
    return false
}

func homeGestureButtonDisabled(_ enabled: Bool) -> Bool {
    if homeGestureToggleDisabled() || checkSandbox() {
        return true
    }
    
    checkAndCreateBackupFolder()
    let prefs = MGPreferences.init(identifier: "live.cclerc.TrollBox")
    if prefs.dictionary["DeviceSubType"] == nil && !enabled {
        return true
    }
    
    return false
}

func checkSandbox() -> Bool {
    let fileManager = FileManager.default
    fileManager.createFile(atPath: "/var/mobile/tboxtemp", contents: nil)
    if fileManager.fileExists(atPath: "/var/mobile/tboxtemp") {
        do {
            try fileManager.removeItem(atPath: "/var/mobile/tboxtemp")
        } catch {
            print("Failed to remove sandbox check file")
        }
        return false
    }
    
    return true
}