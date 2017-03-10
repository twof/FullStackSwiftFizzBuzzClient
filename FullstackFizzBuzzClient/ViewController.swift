//
//  ViewController.swift
//  FullstackFizzBuzzClient
//
//  Created by fnord on 3/10/17.
//  Copyright © 2017 twof. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fizzBuzzLenField: UITextField!
    @IBOutlet weak var fizzBuzzResult: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressButton(_ sender: Any) {
        if let fizzBuzzLen = Int(fizzBuzzLenField.text!) {
            fizzBuzz(len: fizzBuzzLen, callback: { (result) in
                self.fizzBuzzResult.text = result
            })
        }else{
            self.fizzBuzzResult.text = "Enter a number above"
        }
    }

    func fizzBuzz(len: Int, callback: @escaping (_ response: String) -> ()){
        let url = "https://vapor--fizzbuz.herokuapp.com/fizz?q="
        
        Alamofire.request(url + String(len)).responseJSON { (response) in
            if let value = response.result.value as? NSDictionary{
                if let fbString = value["fizzbuzz"] as? String{
                    callback(fbString)
                }
            }
        }
    }
}

