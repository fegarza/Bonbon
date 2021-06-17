//
//  ListadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation

import UIKit

class ListadoController: UITableViewController{
    
    
    override func viewDidLoad() {
        traerDatos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "editarView") as! EditadoController
        self.present(balanceViewController, animated: true, completion: nil)
    }
    
    
    func traerDatos(){
        
        var creadorDePeticion = PeticionBuilder(endpoint: puntoDeAcceso, operacion: Operacion.consulta)
                
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

