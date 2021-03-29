//
//  DetailViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 29/03/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var etablissement : Etablissement?
    @IBOutlet weak var nomEtablissement: UILabel!
    @IBOutlet weak var departement: UILabel!
    @IBOutlet weak var ville: UILabel!
    
    
    @IBOutlet weak var moteur: UIImageView!
    @IBOutlet weak var mental: UIImageView!
    @IBOutlet weak var auditif: UIImageView!
    @IBOutlet weak var visuel: UIImageView!
    
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var adresse: UILabel!
    
    @IBOutlet weak var siteweb: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(etablissement ?? "Rien")
        
        if(etablissement != nil){
            if(etablissement?.fields.handicap_moteur == "Non"){
                moteur.alpha = 0.2
            }
            if(etablissement?.fields.handicap_mental == "Non"){
                mental.alpha = 0.2
            }
            if(etablissement?.fields.handicap_auditif == "Non"){
                auditif.alpha = 0.2
            }
            if(etablissement?.fields.handicap_visuel == "Non"){
                visuel.alpha = 0.2
            }
            nomEtablissement.text = etablissement?.fields.etablissement
            departement.text = etablissement?.fields.departement
            ville.text = etablissement?.fields.ville
            telephone.text = " Tel : +33\(etablissement?.fields.telephone ?? "")"
            
            if(etablissement?.fields.adresse != nil){
                let rue = etablissement!.fields.adresse!
                let codepostal = etablissement!.fields.codepostal
                
                adresse.text = "\(rue)\n\(ville.text ?? "")\n\(codepostal)"
            }else{
                adresse.text = ""
            }

            siteweb.setTitle("\(etablissement?.fields.siteweb ?? "")", for: UIControl.State.normal) 


        }

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
