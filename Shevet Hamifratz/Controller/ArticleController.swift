//
//  ArticleController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 2/12/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {

    
    @IBOutlet weak var articleContent: UITextView!
   
    @IBOutlet weak var contentView: UIView!
    
    var selectedRow: Int?
    
    var article: Article?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let art = article {
            if let str = article?.content{
                articleContent.text = str
                let originalHeight = articleContent.frame.height
                adjustUITextViewHeight()
                let adjustedHeight = articleContent.frame.height
                var heightDiff = adjustedHeight - originalHeight
                if (heightDiff > 0){
                    print("I hate Swift \( heightDiff)")
                    print("OG Height \(contentView.frame.height)")
                    print("OG ScHeight \(scrollView.frame.height)")
                    contentView.frame.size.height += heightDiff
                    scrollView.frame.size.height += heightDiff
                     print("OG Height \(contentView.frame.height)")
                     print("OG ScHeight \(scrollView.frame.height)")
                }
                
            }
          
        }
       
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adjustUITextViewHeight()
    {
        articleContent.translatesAutoresizingMaskIntoConstraints = true
        articleContent.sizeToFit()
        articleContent.isScrollEnabled = false
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
