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
    @IBOutlet weak var moteur: UIButton!
    @IBOutlet weak var mental: UIButton!
    @IBOutlet weak var auditif: UIButton!
    @IBOutlet weak var visuel: UIButton!
    
    var etablissement : Etablissement?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moteur.isUserInteractionEnabled = false
        mental.isUserInteractionEnabled = false
        auditif.isUserInteractionEnabled = false
        visuel.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
