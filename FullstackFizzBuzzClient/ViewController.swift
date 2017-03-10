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
            incrementalFizzBuzz(len: fizzBuzzLen, callback: { (result) in
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
    
    func incrementalFizzBuzz(len: Int, callback: @escaping (_ response: String) -> ()) {
        let url = "https://vapor--fizzbuz.herokuapp.com/buzz?q="
        var retArr = [String]()
        var retCount = 0{
            didSet{
                if retCount == len {
                    callback(retArr.joined(separator: ", "))
                }
            }
        }
        
        for i in 1...len {
            Alamofire.request(url + String(i)).responseJSON { (response) in
                if let value = response.result.value as? NSDictionary{
                    if let fbString = value["val"] as? String{
                        retArr = retArr.extend(element: fbString, ind: i)
                        retCount += 1
                    }
                }
            }
        }
    }
}


extension Sequence where Iterator.Element == String {
    mutating func extend(element: String, ind: Int) -> [String]{
        if (self as! Array<String>).count <= ind {
            var temp: [String] = self.map{$0}
            let shortage = (ind - (temp.count-1))
           
            temp = temp + ([String](repeating: "", count: shortage))
            temp[ind] = element
            
            return temp
        }else{
            var temp = self.map{$0}
            temp[ind] = element
            return temp
        }
    }
}

extension Array {
    
}
