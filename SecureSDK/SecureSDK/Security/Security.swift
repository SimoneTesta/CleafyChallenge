//
//  Security.swift
//  SecureSDK
//
//  Created by Simone Testa on 12/02/22.
//

import Foundation

class Security: SecurityProtocol {
    
    static let shared: SecurityProtocol = Security()
    
    private static var jailbreakAppsPathToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/Checkra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app"
        ]
    }
    
    private static var jailbreakSystemPathsToCheck: [String] {
        return ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/usr/bin/sshd",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
    }
    
    private static var vpnProtocolsKeysIdentifiers: [String] {
        return [
            "tap",
            "tun",
            "ppp",
            "ipsec",
            "utun"
       ]
    }
    
    func checkDevice() throws {
        try checkEmulation()
        try checkJailbreak()
        try checkPackageName()
        try checkVersion()
        try checkActiveVPN()
    }
    
    private func checkEmulation() throws {
        #if targetEnvironment(simulator)
        throw SecurityError.EmulatedDevice
        #endif
    }
    
    private func checkJailbreak() throws {
        for path in Security.jailbreakAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                throw SecurityError.RootedDevice
            }
        }
        
        for path in Security.jailbreakSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                throw SecurityError.RootedDevice
            }
        }
        
        do {
            try "test".write(toFile: "/private/jailbreak.txt", atomically: true, encoding: .utf8)
            throw SecurityError.RootedDevice
        } catch {
        }
    }
    
    private func checkPackageName() throws {
        guard let bundle = Bundle.main.bundleIdentifier else { return }
        if bundle.count > 20 {
            throw SecurityError.LongPackageName(bundle)
        }
    }
    
    private func checkVersion() throws {
        guard #available(iOS 13.1, *) else {
            throw SecurityError.UnsupportedIOSVersion
        }
    }
    
    private func checkActiveVPN() throws {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
              let allKeys = keys.allKeys as? [String] else { return }
        
        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in Security.vpnProtocolsKeysIdentifiers
            where key.starts(with: protocolId) {
                throw SecurityError.ActiveVPN
            }
        }
    }
}
