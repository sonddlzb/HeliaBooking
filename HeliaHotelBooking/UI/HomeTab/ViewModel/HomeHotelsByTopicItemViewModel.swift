//
//  HomeHotelsByTopicItemViewModel.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import Foundation
import UIKit

struct HomeHotelsByTopicItemViewModel {
    var hotel: Hotel

    func hotelThumbnailURL() -> URL? {
        return URL(string: self.hotel.galleryURL.first ?? "")
    }

    func checkFavoriteStatus(completion: @escaping (_ isSuccess: Bool) -> Void) {
        Database.shared.getUserDetails { user in
            guard let user = user else {
                completion(false)
                return
            }

            completion(user.favoriteHotels.contains(hotel.id))
        }
    }
}
