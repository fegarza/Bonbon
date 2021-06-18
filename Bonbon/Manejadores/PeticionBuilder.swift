//
//  PeticionBuilder.swift
//  Bonbon
//
//  Created by Felipe Garza on 14/06/21.
//

import Foundation

extension URLRequest{
    
    
    
    init(endpoint: String, operacion: Operacion, receta: Receta?) throws {
       
        guard let url = URL(string: endpoint + "?operacion=\(String(operacion.rawValue))") else{
            throw ErrorManager.runtimeError("No se ha logrado crear la instancia de URL")
        }
        
        self.init(url: url)
        
        if(operacion == Operacion.consulta && receta == nil){
            self.httpMethod = "GET"
        }else{
            self.httpMethod = "POST"
        }
        
        self.httpBody = self.obtenerParametros(operacion: operacion, receta: receta).data(using: .utf8)
    }
    
    private func obtenerParametros(operacion: Operacion, receta: Receta?) -> String{
        if(receta == nil){
            return "";
        }
        
        var cadenaDeParametros = ""
        
        switch operacion{
            case Operacion.alta, Operacion.edicion:
                cadenaDeParametros =  "Nombre=\(receta!.Nombre!)&Descripcion=\(receta!.Descripcion!)&Dificultad=\(receta!.Dificultad!)&TiempoCoccion=\(receta!.TiempoCoccion!)&Categoria=\(receta!.Categoria!)"
                if(operacion == Operacion.edicion){
                    cadenaDeParametros += "&RecetaID="+String(receta!.RecetaID!)
                }
            case Operacion.baja, Operacion.consulta:
                if(receta?.RecetaID != nil){
                    cadenaDeParametros = "RecetaID="+String(receta!.RecetaID!)
                }
        }
        
        return cadenaDeParametros
    }
    
}


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
        guard let url = URL(string: self.endpoint + "?operacion=\(String(operacion.rawValue))") else{
            throw ErrorManager.runtimeError("No se ha logrado crear la instancia de URL")
        }
        
        var peticion = URLRequest(url: url)
        
        if(self.operacion == Operacion.consulta && self.receta == nil){
            peticion.httpMethod = "GET"
        }else{
            peticion.httpMethod = "POST"
        }
        
        peticion.httpBody = obtenerParametros().data(using: .utf8)
        
        return peticion;
    }
    
    
    func obtenerParametros() -> String{
        if(receta == nil){
            return "";
        }
        
        var cadenaDeParametros = ""
        
        switch self.operacion{
            case Operacion.alta, Operacion.edicion:
                cadenaDeParametros =  "Nombre=\(self.receta!.Nombre!)&Descripcion=\(self.receta!.Descripcion!)&Dificultad=\(self.receta!.Dificultad!)&TiempoCoccion=\(self.receta!.TiempoCoccion!)&Categoria=\(self.receta!.Categoria!)"
                if(self.operacion == Operacion.edicion){
                    cadenaDeParametros += "&RecetaID="+String(self.receta!.RecetaID!)
                }
            case Operacion.baja, Operacion.consulta:
                if(self.receta?.RecetaID != nil){
                    cadenaDeParametros = "RecetaID="+String(self.receta!.RecetaID!)
                }
        }
        
        return cadenaDeParametros
    }
}
