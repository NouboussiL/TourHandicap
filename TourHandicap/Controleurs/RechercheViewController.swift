//
//  RechercheViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 27/03/2021.
//
import UIKit
import SwiftyJSON
import Alamofire

class RechercheViewController: UIViewController {
    

    var departementRecherche : String = ""
    var listHandicapRecherche = [String]()
    var urlAPI = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap&q="
    var listEtablissements : ListEtablissment = ListEtablissment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        
        print(listEtablissements)
        
    }
    
    func fetchData(){
        var texteURL = "\(urlAPI)&departement=\(departementRecherche)"
        for x in listHandicapRecherche{
            texteURL += "&handicap_\(x)=Oui"
        }
        print(texteURL)
        let urlEncode = texteURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard urlEncode != nil else {debugPrint("Problème d'encodage de l'URL: \(texteURL)"); return }

        let url = URL(string: urlEncode!)
        
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            if let error = error{
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                if let etablissements = try? decoder.decode(ListEtablissment.self, from: data){
                    DispatchQueue.main.async{
                        //self.listEtablissements = ListEtablissment(records: etablissements.records)
                        for x in etablissements.records{
                            self.listEtablissements.records.append(x)
                        }
                        //print(etablissements.records)
                    }
                }else{
                    print("Problème lors du décodage des données JSON : \(String(describing: error))")
                }

            }
            
        }
        task.resume()
        print(listEtablissements.records)
    }
}


