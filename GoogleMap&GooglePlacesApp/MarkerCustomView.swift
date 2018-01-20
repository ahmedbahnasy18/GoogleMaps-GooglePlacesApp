//
//  MarkerCustomView.swift
//  GoogleMap&GooglePlacesApp
//
//  Created by Ahmed  on 1/20/18.
//  Copyright © 2018 Ahmed . All rights reserved.
//

import UIKit

class MarkerCustomView: UIView {
    var img: UIImage!
    var borderColor: UIColor!
    
    init(frame: CGRect, image: UIImage, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.img = image
        self.borderColor = borderColor
        self.tag = tag
        setupViews()
    }
    func setupViews() {
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.layer.borderColor = borderColor.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = true
        let lbl = UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
        lbl.text = "v"
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textColor = borderColor
        lbl.textAlignment = .center
        
        self.addSubview(imageView)
        self.addSubview(lbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
