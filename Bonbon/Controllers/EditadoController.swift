//
//  EditadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation
import UIKit

class EditadoController: UIViewController{
    
    @IBOutlet weak var tfNombre: UITextField!
    override func viewDidLoad() {
        tfNombre.text = recetaSeleccionada?.Nombre
    }
    
    
    
}
