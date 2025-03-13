//
//  CountriesViewModel.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

class CountriesViewModel {
    var countries: [Country] = []
    var filteredCountries: [Country] = []
    var networkClient: NetworkClientProtocol
    var onDataUpdated: (() -> Void)?
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCountries() async {
        do {
            let data = try await networkClient.performRequest(for: DataRequestType.countries)
            let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
            
            self.countries = decodedCountries
            self.filteredCountries = decodedCountries
        } catch {
            print("Error fetching countries: \(error)")
        }
    }
    
    func filterCountries(searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            let lowercasedText = searchText.lowercased()
            filteredCountries = countries.filter { country in
                country.name.lowercased().hasPrefix(lowercasedText) ||
                country.capital.lowercased().hasPrefix(lowercasedText)
            }
        }
        onDataUpdated?()
    }
}
