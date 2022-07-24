//
//  ListTableViewCell.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    
    let titles = ["#", "배송상품", "배송지"]
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "#"
        return label
    } ()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "배송상품"
        return label
    } ()

    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "배송지"
        return label
    } ()

    
    lazy var stackDetail: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([stackDetail])
//        contentView.backgroundColor = .red
        stackDetail.addArrangedSubviews([numLabel,itemLabel,addressLabel])
        
        stackDetail.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.width.height.equalToSuperview()
        }
        
        [numLabel,itemLabel,addressLabel].map{ view in
            view.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
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
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
    }

}
