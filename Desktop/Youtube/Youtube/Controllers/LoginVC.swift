//
//  LoginVC.swift
//  Youtube
//
//  Created by Abdul Diallo on 6/10/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gsi = GIDSignIn.sharedInstance() else { return }

        gsi.clientID = FirebaseApp.app()?.options.clientID
        gsi.delegate = self
        gsi.presentingViewController = self
        gsi.signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                              accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("signed in")
                self.changeRoot()
            }
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

}

//MARK: - <#section heading#>

extension LoginVC {
    
    func changeRoot() {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "VC") as! ViewController
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        window.rootViewController = vc
        //window.makeKeyAndVisible()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
