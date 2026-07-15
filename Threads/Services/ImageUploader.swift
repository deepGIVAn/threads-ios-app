//
//  ImageUploader.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.25) else {
            return nil
        }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        do {
            // Upload data using continuation to bridge Firebase callback API to async/await
            let _ = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<StorageMetadata, Error>) in
                storageRef.putData(imageData, metadata: nil) { metadata, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let metadata = metadata {
                        continuation.resume(returning: metadata)
                    } else {
                        continuation.resume(throwing: NSError(domain: "ImageUploader", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown upload error"]))
                    }
                }
            }

            // Fetch download URL using continuation as well
            let downloadURL = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<URL, Error>) in
                storageRef.downloadURL { url, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let url = url {
                        continuation.resume(returning: url)
                    } else {
                        continuation.resume(throwing: NSError(domain: "ImageUploader", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to obtain download URL"]))
                    }
                }
            }

            return downloadURL.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
