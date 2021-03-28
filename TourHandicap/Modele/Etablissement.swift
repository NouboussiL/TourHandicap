//
//  Etablissement.swift
//  TourHandicap
//
//  Created by Lionel Nouboussi on 27/03/2021.
//


import Foundation

struct ListEtablissment : Codable{

    var records : [Etablissement]
    
    init(){
        records = []
    }

}

struct Etablissement : Codable {

    let recordid : String
    let fields : Fields
    let geometry : Geometry
    
}

struct Fields : Codable {
    
    let departement : String
    let ville : String
    let activit : String?
    let siteweb : String?
    let handicap_visuel : String
    let region : String
    let etablissement : String
    let adresse : String?
    let telephone : String
    let handicap_auditif : String
    let handicap_moteur : String
    let codepostal : Int
    let handicap_mental : String

}
struct Geometry : Codable{
    let type : String
    let coordinates : [Double]

}
