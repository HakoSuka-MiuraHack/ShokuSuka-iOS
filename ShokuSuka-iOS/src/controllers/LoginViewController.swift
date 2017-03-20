//
//  ViewController.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/19.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import PKHUD

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ログインボタンが押された時の処理。Facebookの認証とその結果を取得する
    func loginButton(_ loginButton: FBSDKLoginButton!,didCompleteWith
        result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            //エラー処理
        } else if result.isCancelled {
            //キャンセルされた時
        } else {
            //必要な情報が取れていることを確認(今回はemail必須)
            if result.grantedPermissions.contains("email")
            {
                returnUserData()
            }
        }
    }
    func returnUserData() {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                                                                 parameters: ["fields": "id,email,gender,link,locale,name,timezone,updated_time,verified,last_name,first_name,middle_name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                
                let userName = (result as! Dictionary<String,Any>?)!["name"]!
                print("User Name is: \(userName)")
            }
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            print("User Already Logged In")
            //後で既にログインしていた場合の処理（メイン画面へ遷移）を書く
            HUD.show(.progress)
            returnUserData()
            //ログイン済みでも2秒待つ
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                HUD.flash(.success, delay: 1.0)
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextView = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(nextView, animated: true)
            })
        } else {
            print("User not Logged In")
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }

    //ログアウトボタンが押された時の処理
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

}

