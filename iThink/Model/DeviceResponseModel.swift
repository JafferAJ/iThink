//
//  DeviceResponseModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation

struct DeviceResponseModel: Codable, Identifiable {
    let id: String
    let name: String
    let data: [String: CodableValue]?
}

enum CodableValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)

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

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .string(let str): try container.encode(str)
            case .int(let int): try container.encode(int)
            case .double(let dbl): try container.encode(dbl)
            case .bool(let bool): try container.encode(bool)
        }
    }

    var stringValue: String {
        switch self {
            case .string(let str): return str
            case .int(let i): return "\(i)"
            case .double(let d): return String(format: "%.2f", d)
            case .bool(let b): return b ? "true" : "false"
        }
    }
}
