//
//  UserListResponse.swift
//  PlayGround
//
//  Created by Vasanthakumar Annadurai on 29/10/22.
//

import Foundation

struct UserListResponse: Codable{
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: Array<User>
}
