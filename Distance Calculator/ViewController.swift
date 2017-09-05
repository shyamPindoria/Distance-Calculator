//
//  ViewController.swift
//  Auto Navigator
//
//  Created by Shyam Pindoria on 3/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change the status bar text color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initialize() {
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
        gradient.startPoint = CGPoint(x: 0.8, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.height, height: self.topView.frame.size.height)
        //Assign the gradient to the view
        self.topView.layer.insertSublayer(gradient, at: 0)
        
        //Make the navigation bar transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.topView.frame
        rectShape.position = self.topView.center
        rectShape.path = UIBezierPath(roundedRect: self.topView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 100, height: 20)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.topView.layer.mask = rectShape
        
    }


}

