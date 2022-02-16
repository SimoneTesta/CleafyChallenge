//
//  RequestModelProtocol.swift
//  SecureSDK
//
//  Created by Simone Testa on 15/02/22.
//

import Foundation

protocol RequestModelProtocol {
    func serialize() throws -> Data
    func validate() throws
}

extension RequestModelProtocol {
    func validate() {}
}
