//
//  ArticleController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 2/12/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {

    @IBOutlet weak var articleContent: UILabel!
    
    var selectedRow: Int?
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let art = article {
            if let str = article?.content{
                  articleContent.text = str
            }
          
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
