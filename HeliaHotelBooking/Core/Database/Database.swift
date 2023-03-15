//
//  Database.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 09/03/2023.
//

private struct Const {
    static let usersCollectionName = "users"
    static let hotelsCollectionName = "hotels"
    static let avatarPath = "avatar"
}

private struct ConstFirebaseField {
    static let numberOfBookedTimes = "numberOfBookedTimes"
}

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit

class Database {
    private var database = Firestore.firestore()
    static var shared = Database()

    func getAllUser() {
        self.database.collection(Const.usersCollectionName).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }

    func uploadAvatar(name: String, image: UIImage, completion: @escaping (_ url: String?, _ error: Error?) -> Void) {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(Const.avatarPath + "/\(name).png")
        if let uploadData = image.pngData() {
            fileRef.putData(uploadData) { _, error in
                if let error = error {
                    print("Error when uploading data \(error)")
                    completion(nil, error)
                } else {
                    fileRef.downloadURL { url, error in
                        guard let url = url, error == nil else {
                            print("Failed to get avatar url")
                            completion(nil, error)
                            return
                        }

                        print("Upload file to \(url.absoluteString)")
                        completion(url.absoluteString, nil)
                    }
                }
            }
        }
    }

    func addNewUser(email: String,
                    password: String,
                    userEntity: UserEntity,
                    image: UIImage,
                    completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let authResult = authResult, error == nil else {
                completion(error)
                return
            }

            self.uploadAvatar(name: authResult.user.uid, image: image) { url, error in
                guard let url = url else {
                    completion(error)
                    return
                }

                let userEntityWithURL = UserEntity(fullName: userEntity.fullName,
                                                   nickname: userEntity.nickname,
                                                   dateOfBirth: userEntity.dateOfBirth,
                                                   phoneNumber: userEntity.phoneNumber,
                                                   gender: userEntity.gender, avtURL: url,
                                                   favoriteHotels: userEntity.favoriteHotels)
                guard let userData = try? JSONSerialization.jsonObject(with: JSONEncoder().encode(userEntityWithURL)) as? [String: Any] else {
                    print("Failed to convert entity to dictionary!")
                    return
                }

                self.database.collection(Const.usersCollectionName).document(authResult.user.uid).setData(userData)
                completion(nil)
            }
        }
    }

    func getHotelsBy(topic: String, completion: @escaping (_ listHotels: [Hotel]) -> Void) {
        self.database.collection(Const.hotelsCollectionName)
            .whereField("tag", isEqualTo: topic)
            .getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else if let querySnapshot = querySnapshot {
                var listHotels: [Hotel] = []
                for document in querySnapshot.documents {
                    let hotelId = document.documentID
                    guard let hotelData = try? JSONSerialization
                        .data(withJSONObject: document.data(), options: []) else {
                        continue
                    }

                    if let hotelEntity = try? JSONDecoder().decode(HotelEntity.self, from: hotelData) {
                        listHotels.append(Hotel(id: hotelId, entity: hotelEntity))
                    }
                }
                completion(listHotels)
            }
        }
    }

    func getHotelsSortBynumberOfBookedTimes(size: Int, completion: @escaping (_ listHotels: [Hotel]) -> Void) {
        self.database.collection(Const.hotelsCollectionName)
            .order(by: ConstFirebaseField.numberOfBookedTimes, descending: true)
            .limit(to: size)
            .getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else if let querySnapshot = querySnapshot {
                var listHotels: [Hotel] = []
                for document in querySnapshot.documents {
                    let hotelId = document.documentID
                    guard let hotelData = try? JSONSerialization
                        .data(withJSONObject: document.data(), options: []) else {
                        continue
                    }

                    if let hotelEntity = try? JSONDecoder().decode(HotelEntity.self, from: hotelData) {
                        listHotels.append(Hotel(id: hotelId, entity: hotelEntity))
                    }
                }
                completion(listHotels)
            }
        }
    }

    func getFavoriteHotels(completion: @escaping (_ listHotels: [Hotel]) -> Void) {
        guard let authResult = UserManager.shared.authResult else {
            completion([])
            return
        }

        self.database.collection(Const.usersCollectionName).document(authResult.user.uid).getDocument { document, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else if let document = document {
                var listHotels: [Hotel] = []
                guard let listHotelsId = document.get("favoriteHotels") as? [String] else {
                    completion([])
                    return
                }

                listHotelsId.forEach { hotelId in
                    self.database.collection(Const.hotelsCollectionName).document(hotelId).getDocument { document, error in
                        if let error = error {
                            print("Error getting documents: \(error)")
                            completion([])
                        } else if let document = document {
                            guard let hotelData = try? JSONSerialization.data(withJSONObject: document.data() ?? [:], options: []) else {
                                completion([])
                                return
                            }

                            if let hotelEntity = try? JSONDecoder().decode(HotelEntity.self, from: hotelData) {
                                listHotels.append(Hotel(id: hotelId, entity: hotelEntity))
                            }

                            if listHotels.count == listHotelsId.count {
                                completion(listHotels)
                            }
                        }
                    }
                }
            }
        }
    }

    func updateHotelsFavoriteStatus(at hotel: Hotel, isFavorite: Bool, completion: @escaping (_ result: Bool) -> Void) {
        guard let authResult = UserManager.shared.authResult else {
            completion(false)
            return
        }

        self.database.collection(Const.usersCollectionName).document(authResult.user.uid).getDocument { document, err in
            if let err = err {
                print("Error update documents: \(err)")
                completion(false)
            } else if let document = document {
                guard var listHotelsId = document.get("favoriteHotels") as? [String] else {
                    completion(false)
                    return
                }

                if isFavorite {
                    if !listHotelsId.contains(hotel.id) {
                        listHotelsId.append(hotel.id)
                    }
                } else {
                    listHotelsId.removeObject(hotel.id)
                }

                document.reference.updateData(["favoriteHotels": listHotelsId])
                completion(true)
            }
        }
    }

    func getUserDetails(completion: @escaping (_ user: User?) -> Void) {
        guard let authResult = UserManager.shared.authResult else {
            completion(nil)
            return
        }

        self.database.collection(Const.usersCollectionName).document(authResult.user.uid).getDocument { document, err in
            if let err = err {
                print("Error get documents: \(err)")
                completion(nil)
            } else if let document = document {
                guard let userData = try? JSONSerialization.data(withJSONObject: document.data() ?? [:],
                                                                 options: []) else {
                    completion(nil)
                    return
                }

                if let userEntity = try? JSONDecoder().decode(UserEntity.self, from: userData) {
                    completion(User(id: authResult.user.uid, userEntity: userEntity))
                }
            }
        }
    }
}
