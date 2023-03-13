//
//  HomeHotelsByTopicViewModel.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import Foundation
import UIKit

struct HomeHotelsByTopicViewModel {
    var listHotels: [Hotel]

    static func makeEmpty() -> HomeHotelsByTopicViewModel {
        return HomeHotelsByTopicViewModel(listHotels: [])
    }

    func item(at index: Int) -> HomeHotelsByTopicItemViewModel {
        return HomeHotelsByTopicItemViewModel(hotel: self.listHotels[index])
    }

    func numberOfHotels() -> Int {
        return self.listHotels.count
    }
}
