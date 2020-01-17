//
//  ValidaFormulario.swift
//  Ingressos
//
//  Created by Catia Miranda de Souza on 17/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit
import CPF_CNPJ_Validator
import CreditCardValidator


enum TiposDeTextFields:Int{
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVnecimento = 9
    case codigoDeSEguranca = 10
}

class ValidaFormulario: NSObject {
    func verificaTextFielsPreenchidos(textFields: Array<UITextField>) -> Bool {
        var textFieldEstaoPreenchidos = true
        
        for textField in textFields{
            if textField.text == ""{
                textFieldEstaoPreenchidos = false
            }else{
                textFieldEstaoPreenchidos = true
            }
        }
       return textFieldEstaoPreenchidos
        
    }
    
    func verificaTexteFieldsValidos(listaDeTextField:Array<UITextField>) -> Bool {
        
        var dicionarioDeTextFields:Dictionary<TiposDeTextFields, UITextField> = [:]
        
        for textField in listaDeTextField{
            if let tiposTextField = TiposDeTextFields(rawValue: textField.tag){
                dicionarioDeTextFields[tiposTextField] = textField
                 print(dicionarioDeTextFields)
            }
        }
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else{return false}
        guard let email = dicionarioDeTextFields[.email],self.verificaEmail(email: email.text!)else {return false}
        guard let numeroCartao = dicionarioDeTextFields[.numeroDoCartao],CreditCardValidator().validate(string: numeroCartao.text!) else {return false}
        return true
    }
    
    func verificaEmail(email:String)-> Bool{
        let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegex)
        
        return emailTest.evaluate(with: email)
       
        
    }
    
    func exibeNotifiacaoDoPreenchimentoTestField(titulo: String, mmensagem: String) -> UIAlertController{
        let notificacao = UIAlertController(title: titulo, message: mmensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }
}
