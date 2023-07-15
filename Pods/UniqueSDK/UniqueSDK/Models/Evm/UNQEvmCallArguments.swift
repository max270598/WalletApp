//
//  UNQEvmCallArguments.swift
//  UniqueSDK
//
//  Created by Мах Ol on 28.11.2022.
//

import Foundation

public struct UNQEvmCallArguments: Codable {
    public let address: String
    public let abi: [UNQAny]
    public let contractAddress: String
    public let funcName: String
    public let args: [UNQAny]?
    public let nonce: Int?
    public let at: String?

    public init(address: String, abi: [UNQAny], contractAddress: String, funcName: String, args: [UNQAny]?, nonce: Int?, at: String?) {
        self.address = address
        self.abi = abi
        self.contractAddress = contractAddress
        self.funcName = funcName
        self.args = args
        self.nonce = nonce
        self.at = at
    }
}
