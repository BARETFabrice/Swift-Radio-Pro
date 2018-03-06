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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    @IBAction func actionSurBtnConnection(sender : UIButton)
    {
        var loginEnter : Bool
        var passwordEnter : Bool
        
        if let resultatLogin = login.text, resultatLogin != "" {
            loginEnter = true;
        }
        else {
            loginEnter = false;
        }
        
        if let resultatPassword = password.text, resultatPassword != "" {
            passwordEnter = true;
        }
        else {
            passwordEnter = false;
        }
        
        if (!loginEnter || !passwordEnter) {
            alert(title: "Erreur", message: "login ou password vide")
        }
        else {
            if isCantConnexion() {
                afficherPanneauListeStation()
            }
        }
    }
    
    func isCantConnexion()  -> Bool {
        var condition : Bool
        
        condition = false
        
        if(login.text == "fabrice" && password.text == "fabrice") {
            condition = true
        }
        
        if(!condition) {
            alert(title: "Erreur", message: "Login ou password incorect")
        }
        
        return condition;
    }
    
    func afficherPanneauListeStation()
    {
        
        alert(title: "OK", message: "Connextion")
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


