//
//  MockURLSession.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        return (mockData ?? Data(), HTTPURLResponse())
    }
}
