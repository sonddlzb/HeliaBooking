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

    public func loadImageFrom(completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let url = self.hotelThumbnailURL(), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
