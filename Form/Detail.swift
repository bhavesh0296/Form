//
//  Detail.swift
//  Form
//
//  Created by Daffodilmac-12 on 20/07/18.
//  Copyright © 2018 akhil gupta. All rights reserved.
//

import UIKit
import CoreData

class Detail: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    var profileArray=[ProfileModel]()
    let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var selectedProfile : ProfileModel?

    override func viewDidLoad() {
        super.viewDidLoad()
     //   load(with:ProfileModel.fetchRequest())
       // print(profileArray[0])
        print(selectedProfile ?? "done")
        dataEnter()
        // Do any additional setup after loading the view.
    }

    func dataEnter(){
        nameLabel.text=selectedProfile?.name
        mobileLabel.text=selectedProfile?.mobile
        addressLabel.text=selectedProfile?.address
        dobLabel.text = selectedProfile?.dob
        emailLabel.text=selectedProfile?.email
        genderLabel.text=selectedProfile?.gender
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForm"{
            let destinationVC = segue.destination as! FormViewController
            
           destinationVC.selectedProfile = selectedProfile
                
               
            }
    }
    
//
//    func load(with request:NSFetchRequest<ProfileModel>){
//        do{
//            if let arr = try context?.fetch(request) {
//                profileArray = arr
//                let c=profileArray.count
//                let index = profileArray[c-1]
//                nameLabel.text=index.name
//                mobileLabel.text=index.mobile
//                addressLabel.text=index.address
//                dobLabel.text = index.dob
//                emailLabel.text=index.email
//                genderLabel.text=index.gender
//
//
//            }
//        }catch{
//            print("errors are \(error)")
//        }
      //  nameLabel.text=profileArray[0].name
        
        
        
//    }
//
//    func fetch(name:String ){
//        let request:NSFetchRequest<ProfileModel> = ProfileModel.fetchRequest()
//        request.predicate = NSPredicate(format:"name = %@",name)
//        do{
//            if let arr = try context?.fetch(request) {
//               let currentProfile = arr[0]
//                print(currentProfile.name ?? "")
//
//            }
//        }catch{
//            print("errors are \(error)")
//        }
//        //  nameLabel.text=profileArray[0].name
//
//
//
//    }


}
