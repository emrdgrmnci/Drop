//
//  Seed.swift
//  DropTests
//
//  Created by Emre Değirmenci on 17.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
@testable import Drop

struct Seeds {
    struct Todos {
        static let kahvalti = Todo(id: 1,
        title: "Kahvaltı",
        isCompleted: false)

        static let cantaHazirligi = Todo(id: 2,
        title: "Çanta Hazırlığı",
        isCompleted: false)

        static let kiyafetleriniUtule = Todo(id: 3,
        title: "Kıyafetlerini ütüle",
        isCompleted: false)

        static let all = [kahvalti, cantaHazirligi, kiyafetleriniUtule]
    }
}
