//
//  DetailViewController.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text: String = ""
    var detail: DeliveryDetail?
    
    lazy var uiLabel : UILabel = {
        let label: UILabel = UILabel()
        label.text = text
        return label
    }()
    lazy var uiButton : UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("<  Back", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.touchUpButton), for: .touchUpInside)
        return button
    }()
    
    @objc func touchUpButton() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(uiLabel)
        self.view.addSubview(uiButton)
        uiLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        uiButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(50)
            make.leading.equalTo(self.view).offset(15)
        }
        
    }

}
