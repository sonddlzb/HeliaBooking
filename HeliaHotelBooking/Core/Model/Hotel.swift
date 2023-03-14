//
//  Hotel.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import Foundation

class Hotel {
    var id: String
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
    var description: String

    init(id: String, galleryURL: [String], name: String, area: Double,
         location: String, facilities: [String], price: Double,
         countryName: String, accomadationType: String, tag: String,
         numberOfBookedTimes: Int, description: String) {
        self.id = id
        self.galleryURL = galleryURL
        self.name = name
        self.area = area
        self.location = location
        self.facilities = facilities
        self.price = price
        self.countryName = countryName
        self.accomadationType = accomadationType
        self.tag = tag
        self.numberOfBookedTimes = numberOfBookedTimes
        self.description = description
    }

    init(id: String, entity: HotelEntity) {
        self.id = id
        self.galleryURL = entity.galleryURL
        self.name = entity.name
        self.area = entity.area
        self.location = entity.location
        self.facilities = entity.facilities
        self.price = entity.price
        self.countryName = entity.countryName
        self.accomadationType = entity.accomadationType
        self.tag = entity.tag
        self.numberOfBookedTimes = entity.numberOfBookedTimes
        self.description = entity.description
    }
}
