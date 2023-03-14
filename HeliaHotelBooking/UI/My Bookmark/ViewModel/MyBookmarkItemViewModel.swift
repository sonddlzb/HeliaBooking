//
//  MyBookmarkItemViewModel.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

import Foundation

struct MyBookmarkItemViewModel {
    var favoriteHotel: Hotel

    func name() -> String {
        return self.favoriteHotel.name
    }

    func price() -> String {
        return "$" + String(format: "%.1f", self.favoriteHotel.price)
    }

    func location() -> String {
        return self.favoriteHotel.location
    }

    func hotelThumbnailURL() -> URL? {
        return URL(string: self.favoriteHotel.galleryURL.first ?? "")
    }
}
