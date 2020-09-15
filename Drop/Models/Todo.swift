//
//  Todo.swift
//  Drop
//
//  Created by Emre Değirmenci on 15.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct Todo: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
