//
//  RequestType.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import Foundation

protocol RequestType {
    var baseDomain: BaseDomain { get }
    var endpoint: String { get }
    var httpMethod: HttpMethodType { get }
}

enum DataRequestType: RequestType {
    case countries
    
    var baseDomain: BaseDomain {
        switch self {
        case .countries:
            return .countries
        }
    }
    
    var endpoint: String {
        switch self {
        case .countries:
            return "/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        }
    }
    
    var httpMethod: HttpMethodType {
        switch self {
        case .countries:
            return .get
        default: // Incase if there will be a new endpoint with POST method in future
            return .post
        }
    }
    
    var bodyData: Data? {
        switch self {
        default:
            return nil
        }
    }
}
