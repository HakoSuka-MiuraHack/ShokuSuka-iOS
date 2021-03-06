//
//  PlaceHolderTextView.swift
//  inspix-iOS
//
//  Created by AtsuyaSato on 2017/03/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class PlaceHolderTextView: UITextView {
    
    lazy var placeHolderLabel:UILabel = UILabel()
    var placeHolderColor:UIColor      = UIColor.lightGray
    @IBInspectable var placeHolder:NSString          = ""
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func setText(text:NSString) {
        super.text = text as String
        self.textChanged(notification: nil)
    }
    
    override public func draw(_ rect: CGRect) {
        if(self.placeHolder.length > 0) {
            self.placeHolderLabel.frame           = CGRect(x: 0, y: 8, width: self.bounds.size.width - 16, height: 0)
            self.placeHolderLabel.lineBreakMode   = NSLineBreakMode.byWordWrapping
            self.placeHolderLabel.numberOfLines   = 0
            self.placeHolderLabel.font            = self.font
            self.placeHolderLabel.backgroundColor = UIColor.clear
            self.placeHolderLabel.textColor       = self.placeHolderColor
            self.placeHolderLabel.alpha           = 0
            self.placeHolderLabel.tag             = 999
            
            self.placeHolderLabel.text = self.placeHolder as String
            self.placeHolderLabel.sizeToFit()
            self.addSubview(placeHolderLabel)
        }
        
        self.sendSubview(toBack: placeHolderLabel)
        
        if(self.text.utf16.count == 0 && self.placeHolder.length > 0){
            self.placeHolderLabel.alpha = 1.0
        }
        
        super.draw(rect)
    }
    public func textChanged(notification:NSNotification?) -> (Void) {
        if(self.placeHolder.length == 0){
            return
        }
        
        if(self.text.characters.count == 0) {
            self.placeHolderLabel.alpha = 1.0
        }else{
            self.placeHolderLabel.alpha = 0.0
        }
    }
    func attributeWithImage(image: UIImage, rect:CGRect) {
        
        let attrString = NSMutableAttributedString(attributedString: self.attributedText)
        attrString.insert(NSMutableAttributedString(string: "\n"), at: self.attributedText.length)
        // 画像はNSTextAttachmentで
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = rect
        attrString.append(NSAttributedString(attachment: attachment))
        attrString.insert(NSMutableAttributedString(string: "\n"), at: self.attributedText.length)
        
        self.attributedText = attrString
    }
}
