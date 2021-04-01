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
    var etablissementSelectionne : Etablissement?
    var urlAPI = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap&q=&rows=162"
    
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
                do{
                    let etablissements = try decoder.decode(ListEtablissment.self, from: data)
                    DispatchQueue.main.async{

                        self.listEtablissements = etablissements
                        self.tableViewEtablissements.reloadData()
                        
                    }

                }catch(let error){
                    print(error)
                }

            }
            
        }
        task.resume()
        
        

        tableViewEtablissements.delegate = self
        tableViewEtablissements.dataSource = self
        self.navigationItem.backBarButtonItem?.title = "Retour"
        self.navigationItem.title = "Etablissements \(departementRecherche)"
        let nib = UINib(nibName: "EtablissementCell", bundle: nil)
        tableViewEtablissements.register(nib, forCellReuseIdentifier: "celluleCustom")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detail"){
            let destination = segue.destination as! DetailViewController
            destination.etablissement = etablissementSelectionne!
        }

    
    }

    
}
    


// MARK : - TableViewDelegate _ TableViewDataSource
extension RechercheViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEtablissements?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleCustom", for: indexPath) as! EtablissementCell
        //print(listEtablissements!)
        
        let etab = listEtablissements!.records[indexPath.row].fields
        
        cell.etablissement = listEtablissements!.records[indexPath.row]
        cell.nomEtablissement?.text = etab.etablissement
        cell.ville?.text = etab.ville
        cell.recordid = listEtablissements!.records[indexPath.row].recordid

        if(cell.etablissement!.fields.handicap_moteur == "Non"){
            cell.moteur?.alpha = 0.2
        }
        if(cell.etablissement!.fields.handicap_mental == "Non"){
            cell.mental?.alpha = 0.2
        }
        if(cell.etablissement!.fields.handicap_auditif == "Non"){
            cell.auditif?.alpha = 0.2
        }
        if(cell.etablissement!.fields.handicap_visuel == "Non"){
            cell.visuel?.alpha = 0.2
        }
//        print(listEtablissements!.records[indexPath.row])
//        print(cell.etablissement ?? "pas dans cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! EtablissementCell
        etablissementSelectionne = currentCell.etablissement!
//        print(currentCell.etablissement ?? "rien")
        currentCell.isSelected = false
        performSegue(withIdentifier: "detail", sender: self)
    }

}

