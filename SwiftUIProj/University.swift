//
//  University.swift
//  SwiftUIProj
//
//  Created by Himesh on 2/13/22.
//

import Foundation

// MARK: - UniversityListElement
struct UniversityListElement: Codable, Identifiable {
    let id = UUID()
    let stateProvince: String?
    let domains: [String]?
    let country: Country?
    let webPages: [String]?
    let name: String?
    let alphaTwoCode: AlphaTwoCode?
    
    enum CodingKeys: String, CodingKey {
        case stateProvince = "state-province"
        case domains, country
        case webPages = "web_pages"
        case name
        case alphaTwoCode = "alpha_two_code"
    }
}

enum AlphaTwoCode: String, Codable {
    case us = "US"
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

typealias UniversityList = [UniversityListElement]
