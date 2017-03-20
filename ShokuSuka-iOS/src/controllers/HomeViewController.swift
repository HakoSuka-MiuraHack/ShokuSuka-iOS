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
import APIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var postSegueBtn: UIButton!
    @IBOutlet weak var rankingView: UIView!
    @IBOutlet weak var userIconBtn: UIButton!

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [FBPosts] = []
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.postSegueBtn.layer.cornerRadius = 5.0
        self.postSegueBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
        self.rankingView.isHidden = true
        
        self.userIconBtn.pin_setImage(from: URL(string: (user?.thumbnaiUrl)!))
        
        let request = GetUserTimeLineRequest()
        Session.send(request) { result in
            switch result {
            case .success(let response):
                self.posts = response.fbPosts
                print(self.posts)
                self.tableView.reloadData()
                
            case .failure(let error):
                print("error: \(error)")
            }
        }

        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "postCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    @IBAction func transitToUpdateView(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = mainStoryboard.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        nextView.user = user
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell

        cell.userNameLabel.text = posts[indexPath.row].name
        cell.captionTextView.text = posts[indexPath.row].message
        cell.urls = posts[indexPath.row].urls
        cell.collectionView.reloadData()
        return cell
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
