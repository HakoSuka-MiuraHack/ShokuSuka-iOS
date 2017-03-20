//
//  HomeViewController.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/19.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import PINRemoteImage

class HomeViewController: UIViewController {
    @IBOutlet weak var postSegueBtn: UIButton!
    @IBOutlet weak var rankingView: UIView!
    @IBOutlet weak var userIconBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.postSegueBtn.layer.cornerRadius = 5.0
        self.postSegueBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
        self.rankingView.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.rankingView.isHidden = true
        }else{
            self.rankingView.isHidden = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
