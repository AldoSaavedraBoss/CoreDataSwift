//
//  Database.swift
//  CoreDataContactos
//
//  Created by Mac10 on 04/11/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHandler{
    var image: UIImage? = nil
    
    func guardarImagen(){
        let app = (UIApplication.shared.delegate) as! AppDelegate
        let contexto = app.persistentContainer.viewContext
        let objetoFoto = NSEntityDescription.insertNewObject(forEntityName: "Contactos", into: contexto) as! Contactos
        objetoFoto.foto = image?.jpegData(compressionQuality: 1) as Data?
        
        do {
            try contexto.save()
        } catch {
            print("Error al guardar la imagen")
        }
    }
    
    func recuperarImagen() -> [Contactos] {
        var fotos = [Contactos]()
        
        let app = (UIApplication.shared.delegate) as! AppDelegate
        let contexto = app.persistentContainer.viewContext
        
        do {
            fotos = try (contexto.fetch(Contactos.fetchRequest()))
        } catch {
            print("Error al buscar la foto")
        }
        
        return fotos
    }
}
