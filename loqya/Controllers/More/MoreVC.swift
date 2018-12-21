//
//  MoreVC.swift
//  loqya
//
//  Created by Ahmed on 8/26/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class VCmore: UIViewController {

    @IBOutlet weak var viewOpinion: CricleView!
    @IBOutlet weak var viewContactUs: CricleView!
    @IBOutlet weak var viewOurContact: CricleView!
    @IBOutlet weak var viewQuestions: CricleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewsClick()
        
    
    }
    
    func viewsClick(){
        
        let tapOpinion = UITapGestureRecognizer(target: self, action: #selector(self.tapOpinionClick(tap:)))
        viewOpinion.addGestureRecognizer(tapOpinion)
        
        let tapQuestions = UITapGestureRecognizer(target: self, action: #selector(self.tapQuestionClick(tap:)))
        self.viewQuestions.addGestureRecognizer(tapQuestions)
        
        let tapContactUs = UITapGestureRecognizer(target: self, action: #selector(self.tapContactUsClick(tap:)))
        self.viewContactUs.addGestureRecognizer(tapContactUs)
        
        let tapOurContact = UITapGestureRecognizer(target: self, action: #selector(self.tapOurConatctClick(tap:)))
        self.viewOurContact.addGestureRecognizer(tapOurContact)
    }
    
    @objc func tapOpinionClick(tap : UITapGestureRecognizer){
        performSegue(withIdentifier: "seg_Opinion", sender: nil)
    }
    
    @objc func tapQuestionClick(tap : UITapGestureRecognizer){
        performSegue(withIdentifier: "seg_questions", sender: nil)
    }
    
    @objc func tapContactUsClick(tap : UITapGestureRecognizer){
        performSegue(withIdentifier: "seg_ContactUs", sender: nil)
    }
    
    @objc func tapOurConatctClick(tap : UITapGestureRecognizer){
        performSegue(withIdentifier: "seg_ourContact", sender: nil)
    }
    
    

   

}
