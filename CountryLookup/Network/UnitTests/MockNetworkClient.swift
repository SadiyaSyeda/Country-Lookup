//
//  MockNetworkClient.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

class MockNetworkClient: NetworkClientProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func performRequest(for requestType: DataRequestType) async throws -> Data {
        if let error = mockError {
            throw error
        }
        return mockData ?? Data()
    }
}
