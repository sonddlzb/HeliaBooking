//
//  Gender.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 08/03/2023.
//

import Foundation

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case others = "Others"

    func name() -> String {
        return self.rawValue
    }

    static func listGenders() -> [String] {
        return Gender.allCases.map {
            $0.name()
        }
    }
}
