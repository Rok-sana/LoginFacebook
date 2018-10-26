//
//  ViewController.swift
//  LearnLoginFacebook
//
//  Created by swstation on 8/16/18.
//  Copyright © 2018 swstation. All rights reserved.
//

import UIKit

import FacebookCore
import FacebookLogin



class ViewController: UIViewController{
    var name : String!
    var photoURL: String!
    
  
  override  func viewDidLoad() {
        super.viewDidLoad()
    
        
    
    
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.frame = CGRect(x: 0.0, y: 0.0, width: 180.0, height: 40.0)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("Facebook", for: .normal)



    myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)



        view.addSubview(myLoginButton)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailVC
        {
            let vc = segue.destination as? DetailVC
            vc?.text = self.name
            vc?.stringURL = self.photoURL
        
            
        }
    }
    

    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        if AccessToken.current != nil {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start({ (urlResponse, requestResult) in
                
                switch requestResult {
                case .success(let response):
                    
                    if let responseDictionary = response.dictionaryValue {
                        let email = responseDictionary["email"] as? String
                        print(email)
                        
                        let first = responseDictionary["name"] as? String
                        self.name = first ?? "AAAAAA"
                        print("\(first)")
                        if let picture = responseDictionary["picture"] as? NSDictionary {
                            if let data = picture["data"] as? NSDictionary{
                                if let profilePicture = data["url"] as? String {
                                    self.photoURL = profilePicture
                                    
                                    print(profilePicture)
                                }
                            }
                        }
                        self.performSegue(withIdentifier: "test", sender: self)
                    }
                   
                case .failed(let error):
                    print(error)
                    
                }
            })
            
           
        }
        else{
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self, completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(grantedPermissions: let g, declinedPermissions: let d, token: let t):

                break

            }
        })
        }

}
    
    
}
