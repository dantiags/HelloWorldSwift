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
    @IBOutlet var labelClima: UILabel!
    
    var clima:String?
    
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
        
        let source = txtCiudad.text!
        let result = source.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(result)&APPID=0cfc989802e761ee5405f3c50ec342f8&lang=sp"
        
        let url = NSURL(string:urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: { data,response, error -> Void in
            
            if (error != nil){
                print(error!.localizedDescription)
            }else{
            
                let nsdata:NSData = NSData(data: data!)
            
                self.parseRespuestaJson(nsdata)
                
                dispatch_async(dispatch_get_main_queue(), {
                    print(self.clima)
                    self.labelClima.text = self.clima!
                })
            }
            
            
        })
        
        task.resume()
        
    }
    
    
    func parseRespuestaJson(nsdata:NSData){
        
        let jsonComplete : AnyObject!
        
        do {
            try jsonComplete = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers)
            
            print(jsonComplete)
            
            
            let informacionClima = jsonComplete["weather"]
            
            if let jsonArray = informacionClima as? NSArray {
                
                jsonArray.enumerateObjectsUsingBlock({ model, index, stop in
                    self.clima = model["description"] as! String
                    
                })
                
            }


        } catch {
            print(error)
        }
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}