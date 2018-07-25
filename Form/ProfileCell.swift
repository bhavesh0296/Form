
//
//  ProfileCell.swift
//  Form
//
//  Created by Daffodilmac-12 on 23/07/18.
//  Copyright © 2018 akhil gupta. All rights reserved.
//

import UIKit

/// Define a cell delegate

protocol ProfileCellDelegate: AnyObject{
  
    func edit(at indexPath:IndexPath)
    func view(at indexPath:IndexPath)
}



class ProfileCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    var indexPath:IndexPath?
    weak var delegate:ProfileCellDelegate?
 

    
    @IBAction func editTapped(_ sender: Any) {
    delegate?.edit(at: indexPath!)
    }
    @IBAction func viewTapped(_ sender: Any) {
        delegate?.view(at: indexPath!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
