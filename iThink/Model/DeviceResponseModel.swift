//
//  DeviceResponseModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation

/// Model representing a device returned from the API.
/// Conforms to `Codable` for decoding from JSON and `Identifiable` for use in SwiftUI lists.
struct DeviceResponseModel: Codable, Identifiable {
    let id: String
    let name: String
    let data: [String: CodableValue]? // Flexible dictionary for dynamic key-value pairs
}

/// Enum to support decoding and encoding dynamic types (String, Int, Double, Bool) from JSON.
enum CodableValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)

    /// Decodes a single value of an unknown type from JSON.
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else {
            throw DecodingError.typeMismatch(
                CodableValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Value cannot be decoded")
            )
        }
    }

    /// Encodes the associated value back to JSON based on its type.
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .string(let str): try container.encode(str)
            case .int(let int): try container.encode(int)
            case .double(let dbl): try container.encode(dbl)
            case .bool(let bool): try container.encode(bool)
        }
    }

    /// Returns a human-readable `String` representation of the value.
    var stringValue: String {
        switch self {
            case .string(let str): return str
            case .int(let i): return "\(i)"
            case .double(let d): return String(format: "%.2f", d)
            case .bool(let b): return b ? "true" : "false"
        }
    }
}
