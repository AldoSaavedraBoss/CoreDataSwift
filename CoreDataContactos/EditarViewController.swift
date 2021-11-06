//
//  EditarViewController.swift
//  CoreDataContactos
//
//  Created by Mac10 on 01/11/21.
//

import UIKit
import CoreData

class EditarViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //var  recibiNombre: String?
    //var  recibiTelefono: String?
    //var  recibiDireccion: String?
    //var  recibirFoto: UIImage?
    var data:Data?
    var recibirContacto: Contactos?
    
    var contacto: Contactos?
    
    //MARK: - Conexion a la base de datos
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    @IBOutlet weak var TFNombre: UITextField!
    @IBOutlet weak var TFTelefono: UITextField!
    @IBOutlet weak var IVFoto: UIImageView!
    @IBOutlet weak var TFDireccion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        contacto = recibirContacto

        TFNombre.text = contacto?.nombre
        TFTelefono.text = contacto?.telefono
        TFDireccion.text = contacto?.direccion
        
        if contacto?.foto != nil {
            IVFoto.image = UIImage(data: (contacto?.foto)!)
        }else{
            IVFoto.image = UIImage(named: "person")
        }
        
        contacto = recibirContacto!
    }
    
    @IBAction func cambiarFoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            IVFoto.image = pickedImage
        }
    }
    
    @IBAction func BtnGuardar(_ sender: UIButton) {
        
        let editarContacto = Contactos(context: self.contexto)
        
        contacto?.nombre = TFNombre.text
        contacto?.telefono = TFTelefono.text
        contacto?.direccion = TFDireccion.text
        
        
        let objetoFoto = NSEntityDescription.insertNewObject(forEntityName: "Contactos", into: self.contexto) as! Contactos
        objetoFoto.foto = self.IVFoto?.image!.jpegData(compressionQuality: 1) as Data?
        
        contacto?.foto = objetoFoto.foto
        
        do {
            try contexto.save()
        } catch let error as NSError {
            print("Error al guardar")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func BtnCancelar(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
