//
//  ViewController.swift
//  Qual o clima
//
//  Created by Henrique Souza on 24/07/16.
//  Copyright © 2016 Henrique Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    @IBAction func findWeather(_ sender: AnyObject) {
        
        let requestedUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        
        if let url = requestedUrl {
        
            let task = URLSession.shared().dataTask(with: url) { (data, response, error) in
                
            let httpResponse = response as! HTTPURLResponse
            
                if httpResponse.statusCode == 200 {
                    
                    if let urlContent = data {
                        
                        let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                        
                        let webSiteArray = webContent!.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                        
                        if webSiteArray.count > 1 {
                            
                            let weatherArray = webSiteArray[1].components(separatedBy: "</span>")
                            
                            if weatherArray.count > 1 {
                                
                                let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                                
                                self.resultLabel.text = weatherSummary
                            }
                        }
                    }
                }
                    
                else {
                    self.resultLabel.text = "Cidade nao encontrada, tente novamente"
                }
        }
            task.resume()
        }
        
    else {
            resultLabel.text = "URL inválida"
        }
        
    }
    
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

