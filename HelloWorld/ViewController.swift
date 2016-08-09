//
//  ViewController.swift
//  HelloWorld
//
//  Created by Carlos Dantiags on 9/8/16.
//  Copyright © 2016 Dantiags. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saySomethingTapped(sender: UIButton) {
        displayLabel.text = "Hello World!"
    }


}

