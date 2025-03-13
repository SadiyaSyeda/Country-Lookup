//
//  RequestBuilder.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

struct RequestBuilder {
    
    func buildRequest(for requestType: RequestType) throws -> URLRequest {
        guard let url = URL(string: requestType.baseDomain.getBaseDomain() + "/" + requestType.endpoint) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.httpMethod.getHttpMethod()
        
        // If there is body data (e.g., POST), set it to the request
        if let requestType = requestType as? DataRequestType, let body = requestType.bodyData {
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}
