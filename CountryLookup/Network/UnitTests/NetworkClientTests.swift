//
//  NetworkClientTests.swift
//  CountryLookupTests
//
//  Created by Sadiya Syeda on 3/13/25.
//

import XCTest
@testable import CountryLookup

class NetworkClientTests: XCTestCase {
    
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkClient = NetworkClient(session: mockSession)
    }
    
    override func tearDown() {
        networkClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testPerformRequestSuccess() async {
        // Given: mock successful response
        let mockData = """
        [{ "name": "United States", "capital": "Washington, D.C." }]
        """.data(using: .utf8)!
        
        mockSession.mockData = mockData
        
        // When: performing request
        do {
            let data = try await networkClient.performRequest(for: .countries)
            
            // Then: check if the correct data is returned
            XCTAssertEqual(data, mockData)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testPerformRequestFailure() async {
        // Given: mock error
        let mockError = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockSession.mockError = mockError
        
        // When: performing request
        do {
            _ = try await networkClient.performRequest(for: .countries)
            XCTFail("Expected error but request succeeded.")
        } catch let error as NSError {
            // Then: ensure that the error is handled properly
            XCTAssertEqual(error.domain, "NetworkError")
            XCTAssertEqual(error.code, 500)
        }
    }
}
