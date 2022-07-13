//
//  DeliveryDetailTableViewCell.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/12.
//

import UIKit
import SnapKit

class DeliveryDetailTableViewCell: UITableViewCell {
    
    static let identifier = "DeliveryDetailTableViewCell"
    
    let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 0.1
        return view
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    } ()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()
    
    let labelNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()
    
    let labelFrom: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()
    
    let labelTo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()
    
    let labelState: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelDate)
        contentView.addSubview(labelName)
        contentView.addSubview(labelNumber)
        contentView.addSubview(labelFrom)
        contentView.addSubview(labelTo)
        contentView.addSubview(labelState)
        labelDate.snp.makeConstraints{ make in
            make.centerY.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView.snp.leading).offset(45)
        }
        labelName.snp.makeConstraints{ make in
            make.leading.equalTo(labelDate.snp.trailing).offset(30)
            make.bottom.equalTo(labelNumber.snp.top).offset(-3)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        labelNumber.snp.makeConstraints{ make in
            make.leading.equalTo(labelName)
            make.centerY.equalTo(labelDate)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
