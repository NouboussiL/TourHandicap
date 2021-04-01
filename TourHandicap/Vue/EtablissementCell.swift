//
//  EtablissementCell.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 28/03/2021.
//

import UIKit

class EtablissementCell: UITableViewCell {

    @IBOutlet weak var nomEtablissement: UILabel!
    @IBOutlet weak var ville: UILabel!
    
    @IBOutlet weak var moteur: UIImageView!
    @IBOutlet weak var mental: UIImageView!
    @IBOutlet weak var auditif: UIImageView!
    @IBOutlet weak var visuel: UIImageView!
    
    
    var etablissement : Etablissement?
    var recordid : String?
    
    
    //MARK: - Remettre les alpahs à zero avant de créer une autre cellule
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moteur.alpha = 1.0
              
        mental.alpha = 1.0
               
        auditif.alpha = 1.0
               
        visuel.alpha = 1.0
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
