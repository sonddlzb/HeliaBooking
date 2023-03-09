//
//  PermissonHelper.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 08/03/2023.
//

import Foundation
import Photos

// granted, needOpenSettings
typealias RequestPermissionCompletion = (Bool, Bool) -> Void

class PermissionHelper {
    var hasCameraPermission: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    var hasPhotoPermission: Bool {
        if #available(iOS 14, *) {
            return PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized
        } else {
            return PHPhotoLibrary.authorizationStatus() == .authorized
        }
    }

    func requestPhotoPermission(completion: @escaping RequestPermissionCompletion) {
        if #available(iOS 14, *) {
            let previousStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    completion(status == .authorized, previousStatus == .denied)
                }
            }
        } else {
            let previousStatus = PHPhotoLibrary.authorizationStatus()
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized, previousStatus == .denied)
                }
            }
        }
    }

    func requestCameraPermission(mediaType: AVMediaType, completion: @escaping RequestPermissionCompletion) {
        let previousStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if self.hasCameraPermission {
            completion(true, false)
        } else {
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                DispatchQueue.main.async {
                    completion(granted, previousStatus == .denied)
                }
            }
        }
    }

    func requestMicrophonePermission(completion: @escaping RequestPermissionCompletion) {
        let previousStatus = AVAudioSession.sharedInstance().recordPermission
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            completion(granted, previousStatus == .denied)
        }
    }
}
