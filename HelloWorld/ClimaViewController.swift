//
//  ClimaViewController.swift
//  HelloWorld
//
//  Created by Carlos Dantiags on 10/8/16.
//  Copyright © 2016 Dantiags. All rights reserved.
//

import Foundation
import UIKit

class ClimaViewController: UIViewController {
    
    @IBOutlet var txtCiudad: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg.jpg")!)
    }
    

    @IBAction func buscarClima(sender: UIButton) {
        //Con esta linea imprimo en consola.
        print("Mi lugar: \(txtCiudad.text!)")
        
        //llamamos al web service.
        callWebService()
        
    }
    
    
    func callWebService(){
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(txtCiudad.text!)&APPID=0cfc989802e761ee5405f3c50ec342f8"
        
        let url = NSURL(string:urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: { data,response, error -> Void in
            
            if (error != nil){
                print(error!.localizedDescription)
            }else{
            
                var nsdata:NSData = NSData(data: data!)
            
                self.parseRespuestaJson(nsdata)
            }
            
            
        })
        
        task.resume()
        
    }
    
    
    func parseRespuestaJson(nsdata:NSData){
        
        let jsonComplete : AnyObject!
        
        do {
            try jsonComplete = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers)
            
            print(jsonComplete)

        } catch {
            print(error)
        }
        
        

        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}