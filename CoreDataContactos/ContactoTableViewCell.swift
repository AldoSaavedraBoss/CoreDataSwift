//
//  ContactoTableViewCell.swift
//  CoreDataContactos
//
//  Created by Mac10 on 01/11/21.
//

import UIKit

class ContactoTableViewCell: UITableViewCell {

    @IBOutlet weak var IVFoto: UIImageView!
    @IBOutlet weak var LBNombre: UILabel!
    @IBOutlet weak var LBTelefono: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
