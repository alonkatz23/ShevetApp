//
//  LoginViewController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/23/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import GradientLoadingBar

class LoginViewController: UIViewController {

    var bar = GradientLoadingBar()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var control: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // checkIfUserIsLoggedIn()
  
        
        control.backgroundColor = UIColor.white
    control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.cornerRadius = 10
        control.layer.masksToBounds = true
        
        loginButton.backgroundColor = UIColor(r: 184, g: 50, b: 58)
        loginButton.setTitle(("Login"), for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        
        registerButton.backgroundColor = UIColor(r: 184, g: 50, b: 58)
        registerButton.setTitle(("Register"), for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
//        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        SVProgressHUD.setBackgroundColor(UIColor(r: 160, g: 50, b: 58))
        bar.show()
        if (emailTextField.text != "shevet"){
            handleLogin()
        } else {
            if (passwordTextField.text == "shevet"){
                self.performSegue(withIdentifier: "adminLogin", sender: self)
            }
            print(1)
            bar.hide()
        }
      
        
        if(emailTextField.text == "" || passwordTextField.text == ""){
            print(2)
            bar.hide()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("hello")
       
        
    navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }

    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
             print("loggedIn")
        } else {
            print("not logged in")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfUserIsLoggedIn()
    }
    
    func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text            else {
            print("Form is not Valid")
            print(3)
            bar.hide()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                self.bar.hide()
                return
            }
            print(4)
            
            
            self.bar.hide()
            print("Login Success")
            
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        })
        
        
        
        
        //Admin Login check
        
        
        
    }
    
}
    
    
    

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
