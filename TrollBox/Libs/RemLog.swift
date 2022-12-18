//
//  RemLog.swift
//  TrollBox
//
//  Created by Constantin Clerc on 17/12/2022.
//

import Foundation
func remLog(_ objs: Any...) {
    for obj in objs {
        let args: [CVarArg] = [ String(describing: obj) ]
        withVaList(args) { RLogv("%@", $0) }
    }
}
