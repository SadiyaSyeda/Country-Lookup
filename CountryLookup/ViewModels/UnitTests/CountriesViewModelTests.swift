//
//  CountriesViewModelTests.swift
//  CountryLookupTests
//
//  Created by Sadiya Syeda on 3/13/25.
//

import XCTest
@testable import CountryLookup

class CountriesViewModelTests: XCTestCase {
    
    var viewModel: CountriesViewModel!
    var mockNetworkClient: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        viewModel = CountriesViewModel(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async {
        // Given: mock countries data
        let mockCountriesData = """
        [
            { "name": "United States", "capital": "Washington, D.C.", "region": "Americas", "code": "US" },
            { "name": "Canada", "capital": "Ottawa", "region": "Americas", "code": "CA" }
        ]
        """.data(using: .utf8)!
        
        mockNetworkClient.mockData = mockCountriesData
        
        // When: fetching countries
        await viewModel.fetchCountries()
        
        // Then: check if countries are fetched correctly
        XCTAssertEqual(viewModel.countries.count, 2)
        XCTAssertEqual(viewModel.countries[0].name, "United States")
        XCTAssertEqual(viewModel.countries[1].name, "Canada")
        XCTAssertEqual(viewModel.countries[0].region, "Americas")
        XCTAssertEqual(viewModel.countries[1].region, "Americas")
        XCTAssertEqual(viewModel.countries[0].code, "US")
        XCTAssertEqual(viewModel.countries[1].code, "CA")
    }
    
    func testFetchCountriesFailure() async {
        // Given: mock error
        let mockError = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockNetworkClient.mockError = mockError
        
        // When: fetching countries
        await viewModel.fetchCountries()
        
        // Then: countries should remain empty on error
        XCTAssertTrue(viewModel.countries.isEmpty)
    }
    
    func testFilterCountriesSuccess() {
        // Given: preloaded countries
        let country1 = Country(name: "United States", region: "Washington, D.C.", code: "Americas", capital: "US")
        let country2 = Country(name: "Canada", region: "Ottawa", code: "Americas", capital: "CA")
        viewModel.countries = [country1, country2]
        
        // When: filtering with "Can"
        viewModel.filterCountries(searchText: "Can")
        
        // Then: filtered countries should include only "Canada"
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries[0].name, "Canada")
        XCTAssertEqual(viewModel.filteredCountries[0].region, "Ottawa")
        XCTAssertEqual(viewModel.filteredCountries[0].code, "Americas")
    }
    
    func testFilterCountriesEmptySearchText() {
        // Given: preloaded countries
        let country1 = Country(name: "United States", region: "Washington, D.C.", code: "Americas", capital: "US")
        let country2 = Country(name: "Canada", region: "Ottawa", code: "Americas", capital: "CA")
        viewModel.countries = [country1, country2]
        
        // When: filtering with empty text
        viewModel.filterCountries(searchText: "")
        
        // Then: filtered countries should match all countries
        XCTAssertEqual(viewModel.filteredCountries.count, 2)
    }
    
    func testFilterCountriesNoMatches() {
        // Given: preloaded countries
        let country1 = Country(name: "United States", region: "Washington, D.C.", code: "Americas", capital: "US")
        let country2 = Country(name: "Canada", region: "Ottawa", code: "Americas", capital: "CA")
        viewModel.countries = [country1, country2]
        
        // When: filtering with a non-matching string
        viewModel.filterCountries(searchText: "France")
        
        // Then: filtered countries should be empty
        XCTAssertTrue(viewModel.filteredCountries.isEmpty)
    }
}
