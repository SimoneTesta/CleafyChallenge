//
//  DebugLogger.swift
//  SecureSDK
//
//  Created by Simone Testa on 17/02/22.
//

import Foundation

class DebugLogger: LoggerProtocol {
    let className: String
    
    init(className: String) {
        self.className = className
    }
    
    func log(_ message: String) {
        #if DEBUG
        print("\(className):\(message)")
        #endif
    }
}
