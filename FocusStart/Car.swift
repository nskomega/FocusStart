//
//  Car.swift
//  FocusStart
//
//  Created by Mikhail Danilov on 03.10.2020.
//

import Foundation
import RealmSwift

class Car: Object {
    @objc dynamic var marka = ""
    @objc dynamic var model = ""
    @objc dynamic var year = 0
    @objc dynamic var type = ""
    @objc dynamic var id = ""
    
    
    func update(_ marka: String, _ model: String, _ type: String, _ year :Int) {
        self.marka = marka
        self.model = model
        self.type = type
        self.year = year
    }
}
