//
//  SecurityError.swift
//  SecureSDK
//
//  Created by Simone Testa on 12/02/22.
//

import Foundation

enum SecurityError: LocalizedError {
    case EmulatedDevice
    case RootedDevice
    case LongPackageName(String)
    case UnsupportedIOSVersion
    case ActiveVPN
    
    public var errorDescription: String? {
        switch self {
        case .EmulatedDevice:
            return "Cannot run on emulated devices"
        case .RootedDevice:
            return "Cannot run on rooted devices"
        case .LongPackageName(let packageName):
            return "\(packageName) is longer than 20 charcters"
        case .UnsupportedIOSVersion:
            return "Cannot run on iOS lower than iOS 13.1"
        case .ActiveVPN:
            return "Cannot run while VPN is acrive"
        }
    }
}
