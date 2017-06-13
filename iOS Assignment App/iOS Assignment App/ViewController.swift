//
//  ViewController.swift
//  iOS Assignment App
//
//  Created by Lyubomir Lichev.
//  Copyright © 2017 Lyubomir Lichev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    var degree: Int!
    var condition: String!
    var imgURL: String!
    var city: String!
    var exists: Bool = true
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let urlRequest = URLRequest(url: URL(string: "http://api.apixu.com/v1/current.json?key=cbd51d70d4b14d2ea1d145228171605&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error == nil
            {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let current = json["current"] as? [String: AnyObject]
                {
                    if let temp = current["temp_c"] as? Int
                    {
                        self.degree = temp
                    }
                    if let condition = current["condition"] as? [String : AnyObject]
                    {
                        self.condition = condition["text"] as! String
                        let icon = condition["icon"] as! String
                        self.imgURL = "http:\(icon)"
                    }
                }
                if let location = json["location"] as? [String : AnyObject]
                {
                    self.city = location["name"] as! String
                }
                
                if let _ = json["error"]
                {
                    self.exists = false
                }
                
                DispatchQueue.main.async
                {
                    if self.exists
                    {
                        self.degreeLbl.isHidden = false
                        self.conditionLbl.isHidden = false
                        self.imgView.isHidden = false
                        self.degreeLbl.text = "\(self.degree.description)°"
                        self.cityLbl.text = self.city
                        self.conditionLbl.text = self.condition
                        self.imgView.downloadImage(from: self.imgURL!)
                    }
                    else
                    {
                        self.degreeLbl.isHidden = true
                        self.conditionLbl.isHidden = true
                        self.imgView.isHidden = true
                        self.cityLbl.text = "No city found"
                        self.exists = true
                    }
                }
                
            } catch let jsonError
            {
                print(jsonError.localizedDescription);
            }
        }
        }
        task.resume()
    }
    
    @IBAction func importImage(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
           //
        }
        
    }
 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myImageView.image = image;
        }
        else
        {
            print("FAILED TO LOAD IMAGE")
        }
        self.dismiss(animated: true, completion:nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

extension UIImageView
{
    func downloadImage(from url: String)
    {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async
                {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
}
