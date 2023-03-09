//
//  User.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 09/03/2023.
//

import Foundation

class User {
    var id: String
    var fullName: String
    var nickname: String
    var dateOfBirth: Date
    var phoneNumber: String
    var gender: Gender
    var avtURL: String

    init(id: String, fullName: String, nickname: String,
         dateOfBirth: Date, phoneNumber: String, gender: Gender, avtURL: String) {
        self.id = id
        self.fullName = fullName
        self.nickname = nickname
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.avtURL = avtURL
    }

    init(id: String, userEntity: UserEntity) {
        self.id = id
        self.fullName = userEntity.fullName
        self.nickname = userEntity.nickname
        self.dateOfBirth = userEntity.dateOfBirth.convertToDate() ?? Date()
        self.phoneNumber = userEntity.phoneNumber
        self.gender = Gender(rawValue: userEntity.gender) ?? .others
        self.avtURL = userEntity.avtURL
    }
}
