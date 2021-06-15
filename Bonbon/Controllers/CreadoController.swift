//
//  CreadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


class CreadoController: UIViewController {
    @IBOutlet weak var nombreRecetaText: UITextField!
    @IBOutlet weak var procedimientoText: UITextField!
    @IBOutlet weak var dificultadControl: UISegmentedControl!
    @IBOutlet weak var tiempoCoccionText: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func crearRecetaAction(_ sender: Any) {
        if nombreRecetaText.text == "" || procedimientoText.text == "" || tiempoCoccionText.text == "" {
            let alert = UIAlertController(title: "Aviso", message: "Complete el formulario", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else{
            //aqui viene la cochinada de meterle los datos a la bd xd
            let alert = UIAlertController(title: "Aviso", message: "La receta ha sido añadida", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        
        //esto hace que vibre xd
        AudioServicesPlaySystemSound(SystemSoundID(4095))
        
        
    }
}

