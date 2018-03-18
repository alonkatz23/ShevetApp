//
//  CalendarController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/24/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let origImage = UIImage(named: "profile");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        settingsButton.setImage(tintedImage, for: .normal)
        settingsButton.tintColor = UIColor.white
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
