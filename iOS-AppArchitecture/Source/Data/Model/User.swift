//
//  User.swift
//  PlayGround
//
//  Created by Vasanthakumar Annadurai on 29/10/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
}
