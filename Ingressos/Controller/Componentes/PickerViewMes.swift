//
//  PickerViewMes.swift
//  Ingressos
//
//  Created by Catia Miranda de Souza on 17/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit

protocol PIckerViewMesSelecionado {
    func mesSelecionado(mes: String)
}

class PickerViewMes: NSObject, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var delegate:PIckerViewMesSelecionado?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(row+1)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil{
            delegate?.mesSelecionado(mes: "\(row+1)")
        }
    }

}
