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


class CreadoController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nombreRecetaText: UITextField!
    @IBOutlet weak var procedimientoText: UITextField!
    @IBOutlet weak var dificultadControl: UISegmentedControl!
    @IBOutlet weak var tiempoCoccionText: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoriaPicker.delegate = self
        self.categoriaPicker.dataSource = self
        self.tiempoCoccionText.delegate = self
        self.procedimientoText.delegate = self
        self.nombreRecetaText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categoria.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: Categoria.allCases[row])
    }

    @IBAction func crearRecetaAction(_ sender: Any) {
    
        if(!self.verificarFormulario()){
            return;
        }
        
        let recetaNueva = Receta(
            RecetaID: nil,
            Nombre: self.nombreRecetaText.text,
            Descripcion: self.procedimientoText.text,
            Dificultad:  self.dificultadControl.titleForSegment(at: self.dificultadControl.selectedSegmentIndex),
            TiempoCoccion: self.tiempoCoccionText.text,
            Categoria: String(describing: Categoria.allCases[self.categoriaPicker.selectedRow(inComponent: 0)]),
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
                self.mostrarMensajeDeError(mensaje: "Error al crear receta")
            }
    }
    
    func validarFormulario(){
       //self.
        
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

