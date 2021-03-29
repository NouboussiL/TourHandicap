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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
