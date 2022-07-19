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
    

    
    let viewheader: UIView = {
        let view = UIView()
        return view
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .semibold)
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        return label
    } ()
    
    let labelTo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    } ()
    
    let labelState: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    } ()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([
            viewheader,
            labelName,
            labelNumber,
            labelFrom,
            labelTo,
            labelState
        ])
        
        viewheader.addSubviews([labelDate, labelState])
        
        viewheader.snp.makeConstraints{ make in
            make.centerY.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView.snp.leading).offset(45)
            make.width.equalTo(self.contentView.snp.height)
            make.height.equalToSuperview()
        }
        labelDate.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-8)
        }
        labelState.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelDate.snp.bottom).offset(3)
        }
        labelName.snp.makeConstraints{ make in
            make.leading.equalTo(viewheader.snp.trailing)
            make.bottom.equalTo(labelNumber.snp.top).offset(-3)
            make.trailing.equalTo(self.contentView).offset(-10)
        }
        labelNumber.snp.makeConstraints{ make in
            make.leading.equalTo(labelName)
            make.centerY.equalTo(viewheader)
        }
        labelFrom.snp.makeConstraints { make in
            make.leading.equalTo(viewheader.snp.trailing)
            make.top.equalTo(labelNumber.snp.bottom).offset(3)
            make.trailing.equalTo(self.contentView).offset(-10)
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
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    }
}
