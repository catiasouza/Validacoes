//
//  LocalizacaoConsultaAPI.swift
//  Ingressos
//
//  Created by Catia Miranda de Souza on 17/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit
import Alamofire

// o scaping serve pra vc ter acesso na view controller
class LocalizacaoConsultaAPI: NSObject {
    
    func consultaViaCepAPI(cep: String, sucesso:@escaping(_ localizacao: Localizacao) -> Void, falha:@escaping(_ error: Error) -> Void ){
        
        //BATENDO NA API
        Alamofire.request("https://viacep.com.br/ws/\(cep)/json/",method: .get).validate().responseJSON { (response) in
            print(response)
            
            switch response.result{
            case .success:
                //na classe localizacao passe o init
                if let resultado = response.result.value as? Dictionary<String, String>{
                    //serilizacao da instancia
                        let localizacao = Localizacao(resultado)
                        sucesso(localizacao)
                }
                break
            case .failure:
                falha(response.result.error!)
                break
            }
        }
    }
}
