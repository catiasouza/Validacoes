//
//  Localizacao.swift
//  Ingressos
//
//  Created by Catia Miranda de Souza on 17/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario:Dictionary<String, String>){
        
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["uf"] ?? ""
        uf = dicionario["uf"] ?? ""
        
    }
}
