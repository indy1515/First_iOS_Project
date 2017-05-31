//
//  FeedDetailViewController.swift
//  MyFirstProject
//
//  Created by IndyZa on 5/30/2560 BE.
//  Copyright © 2560 IndyZaLab. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var accessoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerImgView: UIImageView!
    
    var news:News?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.news = News(title: "iOS", description: "Error lets stop doing this", iconImage: #imageLiteral(resourceName: "cheese_flat"), author: "พยุต", view: 2, createDate: "29/06/60")
        // Do any additional setup after loading the view.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
        print("Click Save Button")
        if let news = self.news{
            persist.save(news: news)
        }
    }

    
    func setupUI(){
        if let news = self.news{
            self.headerImgView.image = news.iconImage
            self.titleLabel.text = news.title
            self.detailTextView.text = news.description
            self.accessoryLabel.text = "\(news.author) • \(news.view) views • \(news.createDate)"
        }
        
        
        
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
