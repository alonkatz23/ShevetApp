//
//  NewsletterViewController.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/23/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit
import Firebase

class NewsletterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var articles: [Article] = [Article]()
    
    var image: UIImage?
    
    var selectedRow: Int?
    
    @IBOutlet weak var articleTableView: UITableView!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchArticle()
        
        //Sets up Table View Delegate
     
      articleTableView.delegate = self
        articleTableView.dataSource = self
     
        articleTableView.register(UINib(nibName: "CustomArticleCell", bundle: nil), forCellReuseIdentifier: "customArticleCell")
        
        //Sets up the settings button appearance
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
    
    
   
    
    
    //Cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customArticleCell", for: indexPath) as! CustomArticleCell
        
        let article = articles[indexPath.row]
        cell.articleTitle.text = article.title
        
        if let articleImageUrl = article.articleImageUrl{
            let url = URL(string: articleImageUrl)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    cell.articleImage.image = UIImage(data: data!)
                }
                
                
                
                
                }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        print("Before Segue \(selectedRow)")
        self.performSegue(withIdentifier: "cellSelectedSegue", sender: self)
        articleTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    func fetchArticle(){
        Database.database().reference().child("articles").observe(.childAdded, with: { (snapshot) in
            print("fetched")
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let article = Article(dictionary: dictionary)
                //article.setValuesForKeys(dictionary)
                self.articles.append(article)
                
                //                DispatchQueue.main.async {
                //                    self.articleTableView.reloadData()
                //                }
                print(self.articles.count)
                self.organizeChronologicalTableView()
                
            }
            
            // print(snapshot)
            
            
        }, withCancel: nil)
    }
    
    func organizeChronologicalTableView(){
        var unchanged = false
        print(articles.count)
        while(!unchanged && articles.count > 1){
            unchanged = true
            print("in here")
            for index in 1..<articles.count {
                if (articles[index-1].date! < articles[index].date!){
                    var temp = articles[index-1]
                    articles[index-1] = articles[index]
                    articles[index] = temp
                    unchanged = false
                }
            }
        }
        DispatchQueue.main.async {
            self.articleTableView.reloadData()
        }
    }
    
    func handleLogout() {
        
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
                return
            }
       
            try Auth.auth().signOut()
            
            
        } catch let logoutError {
            print(logoutError)
        }
        
        if let uid = Auth.auth().currentUser?.uid {
            print("not logged out")
        } else {
            print("logged out")
            dismiss(animated: true, completion: nil)
        }
//        let loginController = LoginController()
//        loginController.messagesController = self
//        present(loginController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cellSelectedSegue"){
            let destinationVC: ArticleController = segue.destination as! ArticleController
            destinationVC.article = articles[selectedRow!]
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
