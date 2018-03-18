//
//  SettingsViewController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/24/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit
import Firebase
import GradientLoadingBar

class SettingsViewController: UIViewController {

    var bar = GradientLoadingBar()
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let origImage = UIImage(named: "back2");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    
       
    }
    

    @IBAction func signOutPressed(_ sender: UIButton) {
        bar.show()
        handleLogout()
        
    }
    
    func handleLogout(){
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
                bar.hide()
                return
            }
            
            try Auth.auth().signOut()
            
        } catch let logoutError {
            bar.hide()
            print(logoutError)
        }
        
        if let uid = Auth.auth().currentUser?.uid {
            print("not logged out")
        } else {
            print("logged out")
            bar.hide()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    //        let loginController = LoginController()
    //        loginController.messagesController = self
    //        present(loginController, animated: true, completion: nil)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
