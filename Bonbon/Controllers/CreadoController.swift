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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func crearRecetaAction(_ sender: Any) {
    
        if(!self.verificarFormulario()){
            return;
        }
        
        var recetaNueva = Receta(
            RecetaID: nil,
            Nombre: self.nombreRecetaText.text,
            Descripcion: self.procedimientoText.text,
            Dificultad:  self.dificultadControl.titleForSegment(at: self.dificultadControl.selectedSegmentIndex),
            TiempoCoccion: self.tiempoCoccionText.text,
            Categoria: "testing",
            NUsuario: ""
        )
        
       
            var creadorDePeticion = PeticionBuilder(endpoint: puntoDeAcceso, operacion: Operacion.alta, receta: recetaNueva)
                    
            do{
                var peticion = try creadorDePeticion.build()
                URLSession.shared.dataTask(with: peticion)
                {
                    (data, response, error) in
                    DispatchQueue.main.async
                    {
                        guard let datos =  data else { return }
                        do
                        {
                            print(datos)
                            var recetasDevueltas = try JSONDecoder().decode([Receta].self, from: datos)
                            recetas.append(recetasDevueltas.first!)
                            self.mostrarMensajeCorrecto(mensaje: "La receta ha sido añadida")
                            
                        }catch let jsonError{
                            print(jsonError)
                            self.mostrarMensajeDeError(mensaje:  jsonError.localizedDescription)
                        }
                         
                    }
                    
                }.resume()
            }catch let error{
                print(error)
                self.mostrarMensajeCorrecto(mensaje: "Error al crear receta")
            }
    }
    
    
    func verificarFormulario() -> Bool{
        return true
    }
    
    func mostrarMensajeDeError(mensaje: String){
        if(defaults.bool(forKey: "vibracion")){
            AudioServicesPlaySystemSound(SystemSoundID(4095))
        }
        let alert = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func mostrarMensajeCorrecto(mensaje: String){
        let alert = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
}

