//
//  TableViewController.swift
//  Form
//
//  Created by Daffodilmac-12 on 20/07/18.
//  Copyright © 2018 akhil gupta. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController{
    var profileArray=[ProfileModel]()
    let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var index:Int=1
   
    @IBAction func editPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToEdit", sender: self)
       
        }
    
    @IBAction func viewPressed(_ sender: UIButton){
       
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
        
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        cell.textLabel?.text=profileArray[indexPath.row].name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30.0)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         index=indexPath.row
//
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit"{
        let destinationVC = segue.destination as! FormViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedProfile=profileArray[indexPath.row]
            }
    }
        else{
            let destinationVC = segue.destination as! Detail
            
            if let indexPath = tableView.indexPathForSelectedRow{
                
                destinationVC.selectedProfile=profileArray[indexPath.row]
            }
        }
    }
    func load(){
        let request:NSFetchRequest<ProfileModel>=ProfileModel.fetchRequest()
        do{
            if let arr = try context?.fetch(request) {
                profileArray = arr
                
               }
        }catch{
            print("errors are \(error)")
        }
        //  nameLabel.text=profileArray[0].name
        
        
        
    }
//  

   
}




//==


    


