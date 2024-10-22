//
//  Data.swift
//  Todoey
//
//  Created by Virgi Septian on 22/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    // Indicate to the runtime that it should use dynamic dispatch instead of the default static dispatch
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
