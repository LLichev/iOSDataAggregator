//
//  SecondViewController.swift
//  iOS Assignment App
//
//  Created by Lyubomir Lichev.
//  Copyright © 2017 Lyubomir Lichev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var numberOnDisplay:Double = 0;
    var previousNumber:Double = 0;
    var performingMath = false;
    var operation = 0;
    
    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var labelHistory: UILabel!
    
    @IBAction func numbers(_ sender: UIButton)
    {
        if performingMath == true
        {
            labelDisplay.text = String(sender.tag-1)
            numberOnDisplay = Double(labelDisplay.text!)!
            performingMath = false
        }
        else
        {
            if sender.tag == 17
            {
                labelDisplay.text = labelDisplay.text! + String(".")
            }
            else
            {
                labelDisplay.text = labelDisplay.text! + String(sender.tag-1)
            }
            numberOnDisplay = Double(labelDisplay.text!)!
        }
    }
    
    @IBAction func buttons(_ sender: UIButton)
    {
        if labelDisplay.text != "" && sender.tag != 11 && sender.tag != 16
        {
            previousNumber = Double(labelDisplay.text!)!
            
            if sender.tag == 12 //divide
            {
                labelHistory.text = String(previousNumber);
                labelDisplay.text = "/";
            }
            else if sender.tag == 13 //multiply
            {
                labelHistory.text = String(previousNumber);
                labelDisplay.text = "x";
            }
            else if sender.tag == 14 //minus
            {
                labelHistory.text = String(previousNumber);
                labelDisplay.text = "-";
            }
            else if sender.tag == 15 //plus
            {
                labelHistory.text = String(previousNumber);
                labelDisplay.text = "+";
            }
            operation = sender.tag
            performingMath = true;
        }
        else if sender.tag == 16
        {
            if operation == 12
            {
                labelHistory.text = String(numberOnDisplay);
                labelDisplay.text = String(previousNumber / numberOnDisplay)
            }
            else if operation == 13
            {
                labelHistory.text = String(numberOnDisplay);
                labelDisplay.text = String(previousNumber * numberOnDisplay)
            }
            else if operation == 14
            {
                labelHistory.text = String(numberOnDisplay);
                labelDisplay.text = String(previousNumber - numberOnDisplay)
            }
            else if operation == 15
            {
                labelHistory.text = String(numberOnDisplay);
                labelDisplay.text = String(previousNumber + numberOnDisplay)
            }
        }
        else if sender.tag == 11
        {
            labelDisplay.text = ""
            previousNumber = 0;
            numberOnDisplay = 0;
            operation = 0;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
