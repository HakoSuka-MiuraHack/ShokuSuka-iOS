//
//  UpdateViewController.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import PINRemoteImage

class UpdateViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var user: User?
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationController?.navigationBar.tintColor = UIColor.hexStr(hexStr: "#F3A537", alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.thumbnailImageView.pin_setImage(from: URL(string: (user?.thumbnaiUrl)!))
        self.userNameLabel.text = "\((user?.name)!) さん"
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStr(hexStr: "#F3A537", alpha: 1.0)
    }

    func takePicture(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
            let controller = UIImagePickerController()
            
            //おまじないという認識で今は良いと思う
            controller.delegate = self
            
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            //以下はカメラロールの例
            //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print(pickedImage)
            
            //            FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
            //            photo.image = ここにUIImage;
            //            photo.userGenerated = YES;
            //            FBSDKSharePhotoContent * content = [[FBSDKSharePhotoContent alloc] init];
            //            content.photos = @[photo];
            //
            //            [FBSDKShareDialog showFromViewController:self
            //            withContent:content
            //            delegate:nil];
        }
        
        picker.dismiss(animated: true, completion: nil)
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
