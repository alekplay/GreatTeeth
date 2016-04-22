//
//  InitialViewController.swift
//  GreatTeeth
//
//  Created by Aleksander Skjoelsvik on 4/21/16.
//  Copyright © 2016 Aleksander Skjoelsvik. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let color1 = UIColor(red:45/255.0, green:179/255.0, blue:183/255.0, alpha:1.0).CGColor as CGColorRef
        let color2 = UIColor(red:32/255.0, green:107/255.0, blue:133/255.0, alpha:1.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
        
        // Remove navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }

}
