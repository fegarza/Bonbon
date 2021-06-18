//
//  ListadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation

import UIKit

class ListadoController: UITableViewController, UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        traerDatos()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
           longPressGesture.minimumPressDuration = 0.5
           self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            let alerta = UIAlertController(title: "Eliminar", message: "Esta seguro que desea eliminarlo?", preferredStyle: .alert)
            let btnSi = UIAlertAction(title: "SI", style: .destructive,  handler: {
                (alert: UIAlertAction) in
                self.eliminarReceta(alert: alert, indexPath: indexPath!)
            })
            
            let btnNo = UIAlertAction(title: "NO", style: .cancel,  handler: {
                (alert: UIAlertAction) in
                return
            })
            
            alerta.addAction(btnSi)
            alerta.addAction(btnNo)
            
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    func eliminarReceta(alert: UIAlertAction, indexPath: IndexPath){
        do{
            let peticion = try  URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.baja, receta: recetas[indexPath.row])
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    self.traerDatos()
                }
                
            }.resume()
        }catch let error{
            print(error)
            //self.mostrarMensajeDeError(mensaje: "Error al crear receta")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        traerDatos()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = recetas[indexPath.row].Nombre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recetaSeleccionada = recetas[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let editadoViewController = storyBoard.instantiateViewController(withIdentifier: "editarView") as! EditadoController
        self.present(editadoViewController, animated: true, completion: nil)
    }
    
    
    func traerDatos(){
        do{
            
            let peticion = try URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.consulta, receta: nil)
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    guard let datos =  data else { return }
                    do
                    {
                        recetas = try JSONDecoder().decode([Receta].self, from: datos)
                    }catch let jsonError{
                        print(jsonError)
                    }
                    self.tableView.reloadData();
                }
                
            }.resume()
            
        }catch{
            
        }
    }
    
    
    
}

