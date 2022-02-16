//
//  ResponseDecoder.swift
//  SecureSDK
//
//  Created by Simone Testa on 16/02/22.
//

import Foundation

class ResponseDecoder {
    static func deserializeJSON<T>(data: Data) throws -> T where T: Decodable {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ModelError.Deserialization(error.localizedDescription)
        }
    }
}
