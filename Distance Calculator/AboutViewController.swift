//
//  AboutViewController.swift
//  Distance Calculator
//
//  Created by Shyam Pindoria on 17/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var circle: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Creates the gradient for the view
        let gradient: CAGradientLayer = CAGradientLayer()
        //1st color
        let colorTop = UIColor(red: 230.0 / 255.0, green: 62.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0).cgColor
        //2nd color
        let colorBottom = UIColor(red: 75.0 / 255.0, green: 58.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0).cgColor
        //Set the colors to the gradient layer
        gradient.colors = [colorTop, colorBottom]
        //x and y coordinates for the gradient
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.circle.bounds
        gradient.cornerRadius = self.circle.frame.size.width / 2
        //Assign the gradient to the view
        self.circle.layer.insertSublayer(gradient, at: 0)
        
        //Create a circular layer
        self.circle.layer.cornerRadius = circle.frame.size.width / 2
        
        //Give the circle a shadow
        self.circle.layer.shadowOpacity = 0.5
        self.circle.layer.shadowRadius = 10
        self.circle.layer.shadowOffset.height = 6
        self.circle.layer.shadowOffset.width = 4
        
    }
}

