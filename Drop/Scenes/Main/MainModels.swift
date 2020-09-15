//
//  MainModels.swift
//  Drop
//
//  Created by Emre Değirmenci on 14.09.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

enum ListToday
{
    // MARK: Data structure
    enum FetchToday {
        struct Request {
        }
        struct Response : Codable {
            var todo: Todo?
        }
        struct ViewModel {
            var displayedTodo: Todo
        }
    }
}
