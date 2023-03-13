//
//  MyBookmarkViewModel.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

import Foundation

struct MyBookmarkViewModel {
    var listFavoriteHotels: [Hotel]

    static func makeEmpty() -> MyBookmarkViewModel {
        return MyBookmarkViewModel(listFavoriteHotels: [])
    }

    func item(at index: Int) -> MyBookmarkItemViewModel {
        return MyBookmarkItemViewModel(favoriteHotel: self.listFavoriteHotels[index])
    }

    func numberOfFavoriteHotels() -> Int {
        return self.listFavoriteHotels.count
    }
}
