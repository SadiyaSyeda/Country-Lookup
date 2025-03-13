//
//  Country.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let code: String
    let capital: String
}
