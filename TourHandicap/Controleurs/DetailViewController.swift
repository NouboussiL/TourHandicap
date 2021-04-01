//
//  DetailViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 29/03/2021.
//

import UIKit
import MapKit
import Foundation

class DetailViewController: UIViewController {
    
    var etablissement : Etablissement?
    @IBOutlet weak var nomEtablissement: UILabel!
    @IBOutlet weak var departement: UILabel!
    @IBOutlet weak var ville: UILabel!
    
    
    @IBOutlet weak var moteur: UIImageView!
    @IBOutlet weak var mental: UIImageView!
    @IBOutlet weak var auditif: UIImageView!
    @IBOutlet weak var visuel: UIImageView!
    
    @IBOutlet weak var imageFavoris: UIImageView!
    
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var adresse: UILabel!
    
    @IBOutlet weak var siteweb: UIButton!
    
    @IBOutlet weak var map: MKMapView!
    
    var favoris : ListEtablissment?
    
    var url : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            url = "\(etablissement?.fields.siteweb ?? "")"
            siteweb.setTitle("\(etablissement?.fields.siteweb ?? "")", for: UIControl.State.normal) 
            self.navigationItem.title = "\(etablissement!.fields.etablissement)"

        }
        
        // MARK: - Définition de la map
        if(etablissement?.geometry != nil){
            let latitude:CLLocationDegrees = (etablissement?.geometry?.coordinates[1])!
            let longitude:CLLocationDegrees = (etablissement?.geometry?.coordinates[0])!
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01
            
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta : latDelta, longitudeDelta : longDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
            map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "\(etablissement?.fields.etablissement ?? "")"
            map.addAnnotation(annotation)
            
        }else{
            map.isHidden = true
        }
        
        //MARK: - Ajout de la fonction de l'image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageFavoris.isUserInteractionEnabled = true
        imageFavoris.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        //MARK: - Chargement des données favoris
        let defaults = UserDefaults.standard
        favoris = defaults.getObject(dataType: ListEtablissment.self, key: "favoris") ?? ListEtablissment()
        
        for x in favoris!.records{
            if x.recordid == etablissement!.recordid{
                imageFavoris.image = UIImage(systemName: "heart.fill")
            }
        }

    }
    
    //MARK: - Fonction de l'image
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        if(favoris!.records.count == 0){
            imageFavoris.image = UIImage(systemName: "heart.fill")
            favoris!.records.append(etablissement!)
        }else{
            var trouve = false
            var indice = 0
            for i in 0...favoris!.records.count-1{
                if favoris!.records[i].recordid == etablissement?.recordid{
                    trouve = true
                    indice = i
                    break
                }
            }
            if trouve{
                imageFavoris.image = UIImage(systemName: "heart")
                favoris!.records.remove(at: indice)
                UserDefaults.standard.synchronize()
            }else{
                imageFavoris.image = UIImage(systemName: "heart.fill")
                favoris!.records.append(etablissement!)
            }
        }

        UserDefaults.standard.saveObject(favoris!, forkey: "favoris")
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "siteweb"){
            let destination = segue.destination as! SiteWebViewController
            destination.url = url
        }
    }
    @IBAction func siteWeb(_ sender: Any) {
        performSegue(withIdentifier: "siteweb", sender: self)
    }

}


//MARK: - Ajout de fonctionnalités UserDefaults
extension UserDefaults {
    func saveObject<T: Codable>(_ data: T?, forkey defaultName: String){
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    
    func getObject<T: Codable>(dataType: T.Type, key: String) -> T?{
        guard let userdefaultData = data(forKey: key)else{
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userdefaultData)
    }
}
