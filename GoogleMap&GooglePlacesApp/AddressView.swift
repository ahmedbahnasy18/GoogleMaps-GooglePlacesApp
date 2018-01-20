//
//  AddressView.swift
//  GoogleMap&GooglePlacesApp
//
//  Created by Ahmed  on 1/20/18.
//  Copyright © 2018 Ahmed . All rights reserved.
//

import UIKit

class AddressView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
//        self.clipsToBounds = true
//        self.layer.masksToBounds = true
        setupViews()
    }
    let addLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "address"
        lbl.backgroundColor = UIColor.white
        lbl.textAlignment = .right
        return lbl
    }()
    func setAddress(address: String) {
        addLbl.text = address
    }
    
    func setupViews() {
        
        addSubview(addLbl)
        NSLayoutConstraint.activate([
            addLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            addLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            addLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            addLbl.heightAnchor.constraint(equalToConstant: 35)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
