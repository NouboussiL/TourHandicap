//
//  RechercheViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 27/03/2021.
//
import UIKit
import Foundation

class RechercheViewController: UIViewController {
    
    @IBOutlet weak var tableViewEtablissements: UITableView!
    var departementRecherche : String = ""
    var listHandicapRecherche = [String]()
    var urlAPI = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap&q=&rows=10"
    
    var listEtablissements : ListEtablissment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var texteURL = "\(urlAPI)&refine.departement=\(departementRecherche)"
        for x in listHandicapRecherche{
            texteURL += "&refine.handicap_\(x)=Oui"
        }
        //print(texteURL)
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

                        self.listEtablissements = etablissements
                        self.tableViewEtablissements.reloadData()
                        
                    }
                }else{
                    print("Problème lors du décodage des données JSON : \(String(describing: error))")
                }

            }
            
        }
        task.resume()
        
        

        tableViewEtablissements.delegate = self
        tableViewEtablissements.dataSource = self
        //tableViewEtablissements.register(EtablissementCell.self, forCellReuseIdentifier: "cell")

    }
    
}
    


// MARK : - TableViewDelegate _ TableViewDataSource
extension RechercheViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEtablissements?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EtablissementCell
        //print(listEtablissements!)
        
        let etab = listEtablissements!.records[indexPath.row].fields
        
        cell.etablissement? = listEtablissements!.records[indexPath.row]
        cell.nomEtablissement?.text = etab.etablissement
        cell.ville?.text = etab.ville
        if(etab.handicap_moteur == "Non"){
            cell.moteur?.isEnabled = false
        }
        if(etab.handicap_mental == "Non"){
            cell.mental?.isEnabled = false
        }
        if(etab.handicap_auditif == "Non"){
            cell.auditif?.isEnabled = false
        }
        if(etab.handicap_visuel == "Non"){
            cell.visuel?.isEnabled = false
        }
    
        print()
        print(cell.nomEtablissement ?? "pas de nom")
        return cell
    }

}

