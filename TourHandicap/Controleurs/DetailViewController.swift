//
//  DetailViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 29/03/2021.
//

import UIKit
import MapKit

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
    
    @IBOutlet weak var map: MKMapView!
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(etablissement ?? "Rien")
        
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

    }
    

    @IBAction func siteWeb(_ sender: Any) {
        performSegue(withIdentifier: "siteweb", sender: self)
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

}

extension DetailViewController: MKMapViewDelegate {
    
}
