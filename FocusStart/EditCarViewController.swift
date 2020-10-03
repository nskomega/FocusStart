//
//  EditCarViewController.swift
//  FocusStart
//
//  Created by Mikhail Danilov on 03.10.2020.
//

import UIKit

protocol EditCarViewControllerDelegate {
    func reloadData()
}

class EditCarViewController: UIViewController {

    @IBOutlet weak var markaText: UITextField!
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    var selectCar: Car?
    var delegate: EditCarViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let car = selectCar {
            markaText.text = car.marka
            modelText.text = car.model
            typeText.text = car.type
            yearText.text = String(car.year)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButtonSave(_ sender: Any) {
        
        let marka = markaText.text ?? ""
        let model = modelText.text ?? ""
        let type = typeText.text ?? ""
        let year: Int = Int(yearText.text ?? "0") ?? 0
        
        if let car = selectCar {
            DataService.shared.updateCar(id: car.id, marka: marka, model: model, type: type, year: year)
        } else {
            let car = Car()
            car.update(marka, model, type, year)
            DataService.shared.addCar(car: car)
        }
        
        
        self.dismiss(animated: true, completion: nil)
        delegate?.reloadData()
    }
    
    @IBAction func tapButtonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
