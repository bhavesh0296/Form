//
//  FormViewController.swift
//  Form
//
//  Created by Daffodilmac-12 on 20/07/18.
//  Copyright © 2018 akhil gupta. All rights reserved.
//

import UIKit
import CoreData

class FormViewController: UIViewController,UITextFieldDelegate {
    var profileArray=[ProfileModel]()
    var keyboardHeight:CGFloat?
    var activeField:UITextField!
    var lastOffset:CGPoint!
    let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var constraintContentHeight: NSLayoutConstraint!
    //scrollView
    @IBOutlet var containerView: UIView!
    @IBOutlet var nameLabel: UILabel!    
    @IBOutlet var mobileLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var maleLabel: UILabel!
    @IBOutlet var femaleLabel: UILabel!
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var mobileTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var dobTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
   
    @IBOutlet var scrollView: UIScrollView!
    var genderCheck = ""
    let datepicker = UIDatePicker()
    var selectedProfile : ProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
       containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:))))
        
       
        
           nameTextField.delegate = self
           nameTextField.becomeFirstResponder()
        
           dobTextField.delegate=self
           dobTextField.inputView = datepicker
        
           datepicker.datePickerMode = .date
        
           datepicker.addTarget(self, action: #selector(FormViewController.getSelectedDate), for: UIControlEvents.valueChanged)
        print(selectedProfile ?? "done")
        if (selectedProfile) != nil{
            dataEnter()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dataEnter(){
        nameTextField.text = selectedProfile?.name
        mobileTextField.text = selectedProfile?.mobile
        addressTextField.text = selectedProfile?.address
        dobTextField.text = selectedProfile?.dob
        emailTextField.text = selectedProfile?.email
        if selectedProfile?.gender == "male"
        {
            maleButton.setImage(UIImage(named : "checked.png"), for: .normal)
            genderCheck = "male"
        }
        else {
            femaleButton.setImage(UIImage(named : "checked.png"), for: .normal)
            genderCheck = "female"
        }
        
    }
    @objc func getSelectedDate(sender:UIDatePicker){
        
        let dateFormet = DateFormatter()
        
        dateFormet.dateStyle = DateFormatter.Style.short
        
        dateFormet.timeStyle = DateFormatter.Style.none
        
        dobTextField.text = dateFormet.string(from: (sender.date))
    }
    

    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        containerView.endEditing(true)
    }
    
    @IBAction func maleButton(_ sender: Any) {
        
        changeImageToChecked(gender: "male")
    }
    
    @IBAction func femaleButton(_ sender: Any) {
        
        changeImageToChecked(gender: "female")
    }
    func changeImageToChecked(gender : String){
        if gender == "male"{
            maleButton.setImage(UIImage(named : "checked.png"), for: .normal)
            femaleButton.setImage(UIImage(named : "unchexked.png"), for: .normal)
            genderCheck = "male"
        }
        else{
            femaleButton.setImage(UIImage(named : "checked.png"), for: .normal)
            maleButton.setImage(UIImage(named : "unchexked.png"), for: .normal)
            genderCheck = "female"
        }
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if selectedProfile == nil{
        let data=ProfileModel(context: context!)
        data.name=nameTextField.text
        data.email=emailTextField.text
        data.mobile=mobileTextField.text
        data.dob=dobTextField.text
        data.address=addressTextField.text
        data.gender=genderCheck
        data.id = generateRandomDigits(6)
        save()
        }
        else{
            let request:NSFetchRequest<ProfileModel> = ProfileModel.fetchRequest()
            request.predicate = NSPredicate(format:"id = %@",selectedProfile?.id ?? "")
            do{
                let arr = try context?.fetch(request) ?? []
                let profile = arr[0]
                profile.name = nameTextField.text
                profile.email = emailTextField.text
                profile.mobile = mobileTextField.text
                profile.address = addressTextField.text
                profile.dob = dobTextField.text
                profile.gender = genderCheck
                save()
            }catch{
                print("errors are \(error)")
            }
            
        }
  
       
    }
    func save(){
        do{
            try context?.save()
        }catch{
            print("errors are \(error)")
        }
    }
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
   
        func fetch(id:String ){
            
            //  nameLabel.text=profileArray[0].name
    
    
    
        }
    
    /// keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight!
            })
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight! - distanceToBottom
            if collapseSpace < 0 {
                // no collapse
                return
            }
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight!
            self.scrollView.contentOffset = self.lastOffset
        }
        keyboardHeight = nil
    }
    
        }


extension FormViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}
