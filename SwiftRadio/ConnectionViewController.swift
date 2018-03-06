//
//  ConnectionViewController.swift
//  SwiftRadio
//
//  Created by BARET Fabrice on 18-03-05.
//  Copyright © 2018 matthewfecher.com. All rights reserved.
//

import UIKit
import Foundation

class ConnectionViewController: UIViewController {
    @IBOutlet var login : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var btnConnextion : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


