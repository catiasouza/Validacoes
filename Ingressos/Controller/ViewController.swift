//
//  ViewController.swift
//  Ingressos
//
//  Created by Catia Miranda de Souza on 16/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit



class ViewController: UIViewController,PIckerViewMesSelecionado {
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { (textFieldMes) in
            textFieldMes.text = mes
        }
    }
    
    
    //REFERENTE A TODOS TEXTFIELD
    @IBOutlet var textFields: [UITextField]!
    var pickerViewMes = PickerViewMes()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewMes.delegate = self
        
        
    }
    func buscaTextField(tipoDeTextField: TiposDeTextFields, completion:(_ textFieldSolicitado: UITextField) -> Void){
        for textField in textFields{
            if let textFieldAtual = TiposDeTextFields(rawValue: textField.tag){
                if textFieldAtual == tipoDeTextField{
                    completion(textField)
                }
            }
        }
    }
    @IBAction func botaoAdicionar(_ sender: UIButton) {
        
        let textFielsEstaoValidos = ValidaFormulario().verificaTexteFieldsValidos(listaDeTextField: textFields)
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFielsPreenchidos(textFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFielsEstaoValidos{
            let alerta = ValidaFormulario().exibeNotifiacaoDoPreenchimentoTestField(titulo: "Parabens!", mmensagem: "Compra realizada.")
            present(alerta, animated: true,  completion: nil)
        }else{
            let alerta = ValidaFormulario().exibeNotifiacaoDoPreenchimentoTestField(titulo: "Atencao", mmensagem: "Preencha todos campos")
            present(alerta, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        
        
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: sender.text!, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco) { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            }
            self.buscaTextField(tipoDeTextField: .bairro) { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            }
            
        }) { (error) in
            print(error)
        }
        
    }
    
    //setado como edinting did begin
    @IBAction func textFieldMesEntrou(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        //substitui teclado
        sender.inputView = pickerView
    }
}


