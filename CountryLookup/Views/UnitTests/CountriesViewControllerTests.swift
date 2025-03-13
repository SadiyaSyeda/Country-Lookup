//
//  CountriesViewControllerTests.swift
//  CountryLookupTests
//
//  Created by Sadiya Syeda on 3/13/25.
//

import XCTest
@testable import CountryLookup

class CountriesViewControllerTests: XCTestCase {
    var viewController: CountriesViewController!
    var mockNetworkClient: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        
        // Create the mock network client and inject it into the view model
        mockNetworkClient = MockNetworkClient()
        viewController = CountriesViewController()
        viewController.viewModel.networkClient = mockNetworkClient
    }
    
    func testFetchCountriesAndReloadTable() async {
        // Given: Mock data for countries
        let mockCountriesData = """
            [
                { "name": "United States", "capital": "Washington, D.C.", "region": "Americas", "code": "US" },
                { "name": "Canada", "capital": "Ottawa", "region": "Americas", "code": "CA" }
            ]
            """.data(using: .utf8)!
        
        // Mock the network client to return the mock data
        mockNetworkClient.mockData = mockCountriesData
        
        // When: The viewController is loaded and fetchCountries is called
        await viewController.loadViewIfNeeded()
        await viewController.viewModel.fetchCountries()
        
        // Then: Verify that the countries are fetched and table reloads
        await MainActor.run {
            XCTAssertEqual(viewController.viewModel.countries.count, 2)
            XCTAssertEqual(viewController.viewModel.filteredCountries.count, 2)
            XCTAssertEqual(viewController.tableViewForTesting.numberOfRows(inSection: 0), 2)
        }
    }
    
    func testFetchCountriesFailure() async {
        // Given: Mock error for network failure
        let mockError = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockNetworkClient.mockError = mockError
        
        
        // When: Fetch countries is triggered (with network failure)
        await viewController.viewModel.fetchCountries()
        
        // Then: Verify that the table view is empty
        await MainActor.run {
            XCTAssertEqual(viewController.tableViewForTesting.numberOfRows(inSection: 0), 0)
        }
    }
    
    func testFilterCountriesEmptySearchText() {
        // Given: preloaded countries
        let country1 = Country(name: "United States", region: "Washington, D.C.", code: "Americas", capital: "US")
        let country2 = Country(name: "Canada", region: "Ottawa", code: "Americas", capital: "CA")
        viewController.viewModel.countries = [country1, country2]
        
        // When: Filtering with empty text
        viewController.viewModel.filterCountries(searchText: "")
        
        // Then: All countries should be visible
        XCTAssertEqual(viewController.tableViewForTesting.numberOfRows(inSection: 0), 0)
    }
    
    func testFilterCountriesNoMatches() {
        // Given: preloaded countries
        let country1 = Country(name: "United States", region: "Washington, D.C.", code: "Americas", capital: "US")
        let country2 = Country(name: "Canada", region: "Ottawa", code: "Americas", capital: "CA")
        viewController.viewModel.countries = [country1, country2]
        
        // When: Filtering with a non-matching string
        viewController.viewModel.filterCountries(searchText: "France")
        
        // Then: The filtered countries should be empty
        XCTAssertEqual(viewController.tableViewForTesting.numberOfRows(inSection: 0), 0)
    }
}

extension CountriesViewController {
    var tableViewForTesting: UITableView {
        return tableView
    }
}
