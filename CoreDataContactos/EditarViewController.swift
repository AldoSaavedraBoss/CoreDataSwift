//
//  EditarViewController.swift
//  CoreDataContactos
//
//  Created by Mac10 on 01/11/21.
//

import UIKit

class EditarViewController: UIViewController {
    
    var  recibiNombre: String?
    var  recibiTelefono: String?
    var  recibiDireccion: String?
    

    @IBOutlet weak var TFNombre: UITextField!
    @IBOutlet weak var TFTelefono: UITextField!
    @IBOutlet weak var TFDireccion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func BtnCancelar(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
