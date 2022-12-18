//
//  RootHelper.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//

import UIKit

class RootHelper {
    static let rootHelperPath = Bundle.main.url(forAuxiliaryExecutable: "trolltoolsroothelper")?.path ?? "/"
    
    static func writeStr(_ str: String, to url: URL) throws  {
        let code = spawnRoot(rootHelperPath, ["writedata", str, url.path], nil, nil)
    }
    static func move(from sourceURL: URL, to destURL: URL) throws {
        let code = spawnRoot(rootHelperPath, ["filemove", sourceURL.path, destURL.path], nil, nil)
    }
    static func copy(from sourceURL: URL, to destURL: URL) throws {
        let code = spawnRoot(rootHelperPath, ["filecopy", sourceURL.path, destURL.path], nil, nil)
    }
    static func createDirectory(at url: URL) throws {
        let code = spawnRoot(rootHelperPath,  ["makedirectory", url.path, ""], nil, nil)
    }
    static func removeItem(at url: URL) throws  {
        let code = spawnRoot(rootHelperPath, ["removeitem", url.path, ""], nil, nil)
    }
    static func setPermission(url: URL) throws {
        let code = spawnRoot(rootHelperPath, ["permissionset", url.path, ""], nil, nil)
    }
    static func rebuildIconCache() throws {
        let code = spawnRoot(rootHelperPath, ["rebuildiconcache", "", ""], nil, nil)
    }
    static func loadMCM() throws {
        let code = spawnRoot(rootHelperPath, ["", "", ""], nil, nil)
    }
}

