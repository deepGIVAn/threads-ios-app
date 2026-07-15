//
//  User.swift
//  Threads
//
//  Created by Deepak on 14/07/26.
//
import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
