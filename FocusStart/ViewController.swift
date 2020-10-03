//
//  ViewController.swift
//  FocusStart
//
//  Created by Mikhail Danilov on 02.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectCar: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let defaults = UserDefaults.standard
        let lastStart = defaults.bool(forKey: "firstStart")
        print("lastStart>", lastStart)
        
        if !lastStart {
            defaults.setValue(true, forKey: "firstStart")
            
            let car1 = Car()
            car1.update("BMW", "312", "cross", 2010)
            DataService.shared.addCar(car: car1)
            
            let car2 = Car()
            car2.update("Lada", "1010", "sedan", 1990)
            DataService.shared.addCar(car: car2)
            
            let car3 = Car()
            car3.update("Nissan", "gtr35", "sport", 2001)
            DataService.shared.addCar(car: car3)
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
    }

    @IBAction func tapNewCarButton(_ sender: Any) {
        showEditCarsView(car: nil)
    }
    
    func showEditCarsView(car: Car?) {
        selectCar = car
        performSegue(withIdentifier: "showEditView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditCarViewController, segue.identifier == "showEditView" {
            vc.delegate = self
            vc.selectCar = selectCar
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataService.shared.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let car = DataService.shared.cars[indexPath.row]
        cell.textLabel?.text = car.marka + " " + car.model + " " + car.type + " " + String(car.year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = DataService.shared.cars[indexPath.row]
            DataService.shared.delete(car: car)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = DataService.shared.cars[indexPath.row]
        showEditCarsView(car: car)
    }
    
}

extension ViewController: EditCarViewControllerDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
