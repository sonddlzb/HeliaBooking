//
//  UserEntity.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 09/03/2023.
//

import Foundation

struct UserEntity: Codable {
    var id: String
    var fullName: String
    var nickname: String
    var dateOfBirth: String
    var phoneNumber: String
    var gender: String
    var avtURL: String
}
