//
//  MutationRequest.swift
//  UniqueSDK
//
//  Created by Мах Ol on 14.11.2022.
//

import Foundation

struct MutationRequest<T: Codable>: IRequest {
    
    // MARK: - Properties
    
    private let requestParameters: UNQRequestParameters
    private let requestBody: T
    private let requestPath: String
    private let requestMethod: HTTPMethod
    
    // MARK: - Initialization
    
    public init(parameters: UNQRequestParameters, body: T, path: String, method: HTTPMethod) {
        self.requestParameters = parameters
        self.requestBody = body
        self.requestPath = path
        self.requestMethod = method
    }
    
    // MARK: - IRequest
    
    var method: HTTPMethod {
        return requestMethod
    }
    
    var path: String {
        return requestPath
    }
    
    var parameters: [String: Encodable]? {
        return [
            "use": requestParameters.use.rawValue,
            "withFee": requestParameters.withFee,
            "verify": requestParameters.verify,
            "callbackUrl": requestParameters.callbackUrl,
            "nonce": requestParameters.nonce
        ]
    }
    
    var body: Data? {
        do {
                let jsonData = try JSONEncoder().encode(requestBody)
                let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}
