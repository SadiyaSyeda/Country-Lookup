//
//  BaseDomain.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

enum BaseDomain {
    case countries
    
    func getBaseDomain() -> String {
        switch self {
        case .countries:
            return "https://gist.githubusercontent.com"
        }
    }
}
