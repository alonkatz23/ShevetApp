//
//  ViewController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/23/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController {
    
    var loginView = LoginViewController()
    
    
    
    @IBOutlet weak var inputsView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set color for back button
        let origImage = UIImage(named: "back2");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = UIColor.white
        
        navigationController?.navigationBar.barTintColor = UIColor(r: 184, g: 50, b: 58)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        emailTextField.autocorrectionType = .no
        
        nameTextField.autocorrectionType = .no
        inputsView.backgroundColor = UIColor.white
        inputsView.translatesAutoresizingMaskIntoConstraints = false
        inputsView.layer.cornerRadius = 10
        inputsView.layer.masksToBounds = true
        
        registerButton.backgroundColor = UIColor(r: 184, g: 50, b: 58)
        registerButton.setTitle(("Register"), for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        registerButton.setTitleColor(UIColor.white, for: .normal)
        
        //
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //executes when the register button is pressed
    
    @IBAction func registerPressed(_ sender: UIButton) {
       
        SVProgressHUD.setBackgroundColor(UIColor(r: 160, g: 50, b: 58))
        if (nameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""){
            if(passwordTextField.text == confirmPasswordTextField.text){
                SVProgressHUD.show()
                handleRegister()
            } else {
                let alert = UIAlertController(title: "Passwords do not match.", message: "Please make sure that your passwords are matching.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //Registers user into the database
    
    func handleRegister() {
     
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            SVProgressHUD.dismiss()
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            
            if error != nil {
                print(error!)
                return
            } else {
                
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let values = ["name": name, "email": email]
            
            print("Registration Success")
            
            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
            
        })
    }
    
    //Here it adds the user into the database
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "registeredSegue", sender: self)
            
           
        })
        SVProgressHUD.dismiss()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

