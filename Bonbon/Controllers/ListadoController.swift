//
//  ListadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation

import UIKit

class ListadoController: UITableViewController{
    
    var recetas: Array<Receta> = Array()
    
    override func viewDidLoad() {
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
    
    
    
    func llenarDatos(){
        for x in 1...5{
            recetas.append(Receta(RecetaID: x,Nombre:"Ejemplo",Descripcion: "", Dificultad: "",TiempoCoccion:  "", Categoria: "", NUsuario: ""))
        }
       
    }
    
    func traerDatos(){
        let direccion = "https://fegarza.com/api/?operacion=3"
        
        guard let url = URL(string: direccion) else { return }
        
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: peticion)
        {
            (data, response, error) in
            DispatchQueue.main.async
            {
                guard let datos =  data else { return }
                do
                {
                    self.recetas = try JSONDecoder().decode([Receta].self, from: datos)
                }catch let jsonError{
                    print(jsonError)
                }
                self.tableView.reloadData();
            }
            
        }.resume()
    }
    
    
    
}

