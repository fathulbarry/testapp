//
//  Detail.swift
//  TestApp
//
//  Created by Prijo on 4/8/21.
//  Copyright © 2021 Tawk. All rights reserved.
//

import Foundation

struct Detail: Codable {
    var login: String
    var id: Int16
    var name: String
    var blog: String?
    var company: String?
    var location: String?
    var email: String?
    var followers: Int16
    var following: Int16
}
