//
//  PeticionBuilder.swift
//  Bonbon
//
//  Created by Felipe Garza on 14/06/21.
//

import Foundation

class PeticionBuilder{
    
    private var endpoint: String
    private var operacion: Operacion
    private var receta: Receta?
    
    init(endpoint: String, operacion: Operacion, receta: Receta){
        self.endpoint = endpoint
        self.operacion = operacion
        self.receta = receta
    }
    
    init(endpoint: String, operacion: Operacion){
        self.endpoint = endpoint
        self.operacion = operacion
    }
    
    
    func build() throws -> URLRequest{
        guard let url = URL(string: self.endpoint + "?operacion=\(operacion.rawValue)") else{
            throw ErrorManager.runtimeError("No se ha logrado crear la instancia de URL")
        }
        
        var peticion = URLRequest(url: url)
        
        peticion.httpMethod = "GET"
        peticion.httpBody = obtenerParametros().data(using: .utf8)
        
        return peticion;
    }
    
    
    func obtenerParametros() -> String{
        if(receta != nil){
            return "";
        }
        
        var cadenaDeParametros = ""
        
        switch self.operacion{
            case Operacion.alta, Operacion.edicion:
                cadenaDeParametros =  "?Nombre=\(self.receta?.Nombre)&Descripcion=\(self.receta?.Dificultad)&Dificultad=\(self.receta?.Dificultad)&TiempoCoccion=\(self.receta?.TiempoCoccion)&Categoria\(self.receta?.Categoria)"
                if(self.operacion == Operacion.edicion){
                    cadenaDeParametros += "&recetaID="+String(self.receta!.RecetaID!)
                }
            case Operacion.baja, Operacion.consulta:
                if(self.receta?.RecetaID != nil){
                    cadenaDeParametros = "?RecetaID="+String(self.receta!.RecetaID!)
                }
        }
        
        return cadenaDeParametros
    }
    
    
    
}
