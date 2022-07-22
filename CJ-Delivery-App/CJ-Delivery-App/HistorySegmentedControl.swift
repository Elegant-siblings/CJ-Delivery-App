//
//  HistorySegmentedControl.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/22.
//

import UIKit

class HistorySegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
      super.init(frame: frame)
      self.removeBackgroundAndDivider()
    }
    
    override init(items: [Any]?) {
      super.init(items: items)
      self.removeBackgroundAndDivider()
    }
    
    required init?(coder: NSCoder) {
      fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
    }
    
    private func removeBackgroundAndDivider() {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
