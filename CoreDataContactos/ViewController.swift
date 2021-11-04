//
//  ViewController.swift
//  CoreDataContactos
//
//  Created by Mac10 on 01/11/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var contactos = [Contactos]()
    
    //MARK: - Conexion a la base de datos
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tablaContactos: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        consultar()
        
        tablaContactos.delegate = self
        tablaContactos.dataSource = self
        
        tablaContactos.register(UINib(nibName: "ContactoTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
    }

    @IBAction func BtnAgregarContacto(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Nuevo contacto", message: "Agregar", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            print("Contacto agregado")
            
            guard let nombreAlerta = alerta.textFields?.first?.text else {return}
            guard let telefonoAlerta = alerta.textFields?[1].text else {return}
            guard let direccionAlerta = alerta.textFields?[0].text else {return}
            
            let nuevoContacto = Contactos(context: self.contexto)
            
            nuevoContacto.nombre = nombreAlerta
            nuevoContacto.telefono = telefonoAlerta
            nuevoContacto.direccion = direccionAlerta
            
            self.contactos.append(nuevoContacto)
            
            //MARK: - Guardar contacto
            self.guardar()
            self.tablaContactos.reloadData()
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alerta.addAction(aceptar)
        alerta.addAction(cancelar)
        
        alerta.addTextField { nombreAlertaTF in
            nombreAlertaTF.placeholder = "Ingresa nombre"
        }
        
        alerta.addTextField { telefonoAlertaTF in
            telefonoAlertaTF.placeholder = "Ingresa telefono"
            telefonoAlertaTF.keyboardType = .numberPad
        }
        
        alerta.addTextField { (direccionAlertaTF) in
            direccionAlertaTF.placeholder = "Ingresa direccion"
        }
        
        present(alerta, animated: true)
    }
    
    //MARK: - Metodo guardar en la BD
    func guardar(){
        do {
            try contexto.save()
        } catch let error as NSError {
            print("Error al guardar")
        }
    }
    
    //MARK: - Metodo consultar la BD
    func consultar(){
        let fetch : NSFetchRequest <Contactos> = Contactos.fetchRequest()
        
        do {
            contactos = try contexto.fetch(fetch)
        } catch let error as NSError {
            print("Error al cargar Datos")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaContactos.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! ContactoTableViewCell
        celda.LBNombre?.text = contactos[indexPath.row].nombre
        celda.LBTelefono?.text = contactos[indexPath.row].telefono
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetalleSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleSegue"{
            let destino = segue.destination as! EditarViewController
            //destino.TFNombre = 
        }
    }
    //MARK: - Opcion eliminar en la tabla
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print(indexPath.row)
            print(contactos.count)
            contexto.delete(contactos[indexPath.row])
            contactos.remove(at: indexPath.row)
            
            guardar()
            self.tablaContactos.reloadData()
        }
    }
}

