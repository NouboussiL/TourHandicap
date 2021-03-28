//
//  RechercheViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 27/03/2021.
//
import UIKit
import Foundation

class RechercheViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewEtablissements: UITableView!
    var departementRecherche : String = ""
    var listHandicapRecherche = [String]()
    var urlAPI = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap&q=&rows=13"
    
    var listEtablissements : ListEtablissment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var texteURL = "\(urlAPI)&refine.departement=\(departementRecherche)"
        for x in listHandicapRecherche{
            texteURL += "&refine.handicap_\(x)=Oui"
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
//                        for x in etablissements.records{
//                            self.listEtablissements?.records.append(x)
//                        }
                        //self.listEtablissements = etablissements
                        //print(self.listEtablissements!)
                        //self.updateTable()
                        
                        //self.tableViewEtablissements.insertSections(IndexSet(0...self.listEtablissements!.records.count-1), with: .automatic)
                        self.listEtablissements = etablissements
//                        for i in 0...etablissements.records.count-1 {
//                            self.tableViewEtablissements.beginUpdates()
//                            self.listEtablissements!.records.append(etablissements.records[i])
//                            self.tableViewEtablissements.insertRows(at: [IndexPath.init(row: etablissements.records.count-1, section: 0)], with: .automatic)
//                            self.tableViewEtablissements.endUpdates()
//                        }
                        self.tableViewEtablissements.reloadData()
                        
                    }
                }else{
                    print("Problème lors du décodage des données JSON : \(String(describing: error))")
                }

            }
            
        }
        task.resume()
        
        

//        print("Après sorti de tache")
//        print(listEtablissements!)
        tableViewEtablissements.delegate = self
        tableViewEtablissements.dataSource = self
        tableViewEtablissements.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    func updateTable () {
        self.tableViewEtablissements.beginUpdates()
        //self.tableViewEtablissements.insertSections(IndexSet(0...self.listEtablissements!.records.count-1), with: .automatic)
        for i in 0...self.listEtablissements!.records.count-1 {
            
            self.tableViewEtablissements.insertRows(at: [IndexPath.init(row: i, section: 0)], with: .automatic)
        }
        self.tableViewEtablissements.endUpdates()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEtablissements?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(listEtablissements != nil){
            cell.textLabel?.text = listEtablissements!.records[indexPath.row].fields.etablissement
        }
        return cell
    }
    

    
}


