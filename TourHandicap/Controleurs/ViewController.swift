//
//  ViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 25/03/2021.
//

import UIKit

class ViewController: UIViewController{
        
    var listHandicap : [String] = []
    
    var listDepartements = ["SEINE-ET-MARNE", "PARIS", "ESSONNE, YEVELINES", "VAL-DE-MARNE", "VAL-D\'OISE", "HAUTS-DE-SEINE", "SEINE-SAINT-DENIS"]
    
    var departement = "SEINE-ET-MARNE"
    
    
    @IBOutlet weak var DepartementSelector: UIPickerView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "recherche"){
            let destination = segue.destination as! RechercheViewController
            //destination.delegate = self
            destination.departementRecherche = self.departement
            destination.listHandicapRecherche = self.listHandicap
        }
        if(segue.identifier == "favoris"){
            
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //DepartementSelector.delegate = self
        //DepartementSelector.dataSource = self
        
    
    }
    
    
    // MARK: - Fonction d'ajout de handicap
    
    @IBAction func handicapPressed(_ sender: UIButton) {
        
        switch(sender.tag){
        case 0:
            
            if let index = listHandicap.firstIndex(of: "moteur"){
                listHandicap.remove(at:index)
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                listHandicap.append("moteur")
                sender.backgroundColor = #colorLiteral(red: 0.0971137905, green: 0.4832193975, blue: 1, alpha: 1)
            }
            break
        case 1:
            if let index = listHandicap.firstIndex(of: "mental"){
                listHandicap.remove(at:index)
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                listHandicap.append("mental")
                sender.backgroundColor = #colorLiteral(red: 0.0971137905, green: 0.4832193975, blue: 1, alpha: 1)
            }
            break
        case 2:
            if let index = listHandicap.firstIndex(of: "auditif"){
                listHandicap.remove(at:index)
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                listHandicap.append("auditif")
                sender.backgroundColor = #colorLiteral(red: 0.0971137905, green: 0.4832193975, blue: 1, alpha: 1)
            }
            break
        case 3:
            if let index = listHandicap.firstIndex(of: "visuel"){
                listHandicap.remove(at:index)
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                listHandicap.append("visuel")
                sender.backgroundColor = #colorLiteral(red: 0.0971137905, green: 0.4832193975, blue: 1, alpha: 1)
            }
            break
        default:
            break
        }
    }
    
    
    @IBAction func lancerRecherche(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "recherche", sender: self)
    }
    
}


// MARK : - Definition PickerView
extension ViewController :UIPickerViewDataSource, UIPickerViewDelegate{

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listDepartements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listDepartements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departement = listDepartements[row]
    }
}
