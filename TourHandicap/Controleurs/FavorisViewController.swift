//
//  FavorisViewController.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 31/03/2021.
//

import UIKit

class FavorisViewController: UIViewController {

    @IBOutlet weak var tableViewEtablissements: UITableView!
    var listEtablissements : ListEtablissment?
    var etablissementSelectionne : Etablissement?
    
    //MARK: - Ajout de la cellule custom
    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "EtablissementCell", bundle: nil)
        tableViewEtablissements.register(nib, forCellReuseIdentifier: "celluleCustom")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewEtablissements.delegate = self
        tableViewEtablissements.dataSource = self
        
        
        //MARK: - Récupération des données de favoris
        let defaults = UserDefaults.standard
        listEtablissements = defaults.getObject(dataType: ListEtablissment.self, key: "favoris") ?? ListEtablissment()
        tableViewEtablissements.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detail"){
            let destination = segue.destination as! DetailViewController
            destination.etablissement = etablissementSelectionne!
        }
    }
    
    
    // MARK: - Recharger les données quand la vue doit s'afficher
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        listEtablissements = defaults.getObject(dataType: ListEtablissment.self, key: "favoris") ?? ListEtablissment()
        tableViewEtablissements.reloadData()
    }

}



// MARK: - Extension pour la TableView
extension FavorisViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEtablissements?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleCustom", for: indexPath) as! EtablissementCell
        
        let etab = listEtablissements!.records[indexPath.row].fields
        
        cell.etablissement = listEtablissements!.records[indexPath.row]
        cell.nomEtablissement?.text = etab.etablissement
        cell.ville?.text = etab.ville

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

        return cell
    }
    
    // MARK: - Choix de la cellule
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! EtablissementCell
        etablissementSelectionne = currentCell.etablissement!
        currentCell.isSelected = false
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    
}


