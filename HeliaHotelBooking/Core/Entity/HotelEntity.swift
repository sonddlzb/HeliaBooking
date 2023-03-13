//
//  HotelEntity.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import Foundation

struct HotelEntity: Codable {
    var galleryURL: [String]
    var name: String
    var area: Double
    var location: String
    var facilities: [String]
    var price: Double
    var countryName: String
    var accomadationType: String
    var tag: String
    var numberOfBookedTimes: Int
    var isFavorite: Bool
    var description: String
}
