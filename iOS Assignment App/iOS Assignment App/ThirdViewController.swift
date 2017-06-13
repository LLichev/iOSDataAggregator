//
//  ThirdViewController.swift
//  iOS Assignment App
//
//  Created by Lyubomir Lichev.
//  Copyright © 2017 Lyubomir Lichev. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var arrayCurrencyNames:[String] = []
    var arrayCurrencyValues:[Double] = []
    var activeCurrency:Double = 0
    var baseCurrencyDbl:Double = 0
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    @IBOutlet weak var pickerStartingCurrency: UIPickerView!
    @IBOutlet weak var output: UILabel!

    func numberOfComponents(in pickerCurrency: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerCurrency: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return arrayCurrencyNames.count
    }
    
    func pickerView(_ pickerCurrency: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return arrayCurrencyNames[row]
    }
    
    func pickerView(_ pickerCurrency: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerCurrency.tag == 1)
        {
            activeCurrency = arrayCurrencyValues[row]
        }
        else if (pickerCurrency.tag == 2)
        {
            baseCurrencyDbl = arrayCurrencyValues[row]
        }
    }
    
    @IBAction func action(_ sender: Any)
    {
        if (input.text != "")
        {
            var result = (Double(input.text!)! / baseCurrencyDbl) * activeCurrency
            result = Double(round(100*result)/100)
            output.text = String(result)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://api.fixer.io/latest?base=PHP");
        let task = URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
            if error != nil
            {
                print("NO DATA FOUND")
                return
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                self.arrayCurrencyNames.append((key as? String)!)
                                self.arrayCurrencyValues.append((value as? Double)!)
                            }
                        }
                    }
                    catch let error
                    {
                        print(error)
                    }
                }
            }
            self.pickerCurrency.reloadAllComponents()
            self.pickerStartingCurrency.reloadAllComponents()
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
