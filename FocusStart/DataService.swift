//
//  DataService.swift
//  FocusStart
//
//  Created by Mikhail Danilov on 03.10.2020.
//

import Foundation
import RealmSwift

class DataService {
    
    static let shared = DataService()
    
    let realm = try! Realm()

    lazy var cars: Results<Car> = { self.realm.objects(Car.self) }()

    
    func addCar(car: Car) {
        if car.id.isEmpty {
            car.id = String(Int.random(in: 12...99999))
        }
        try! realm.write(){
            realm.add(car)
        }
    }
    
    
    func updateCar(id: String, marka:String, model:String, type:String, year:Int) {
        
        let workouts = realm.objects(Car.self).filter("id = %@", id)
        let realm = try! Realm()
        if let workout = workouts.first {
            try! realm.write {
                workout.marka = marka
                workout.model = model
                workout.year = year
                workout.type = type
            }
        }
        
    }
    
    func delete(car: Car) {
        try! DataService.shared.realm.write{
            realm.delete(car)
        }
    }
    
}

