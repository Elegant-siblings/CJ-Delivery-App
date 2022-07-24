//
//  ListTableViewController.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/23.
//

import UIKit

class ListTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(rowHeight: CGFloat, isScrollEnabled: Bool) {
        self.init(frame: .zero, style: .plain)
        self.rowHeight = rowHeight
        self.isScrollEnabled = isScrollEnabled
    }
    
    private func configure() {
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor(rgb: 0x888585).cgColor
        self.separatorStyle = .singleLine
        self.separatorColor = UIColor(rgb: 0xCCCCCC)
        self.separatorInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
}

class ListViewController: UIViewController {
    let tableRowHeight = CGFloat(40)
    let titles = ["배송기사", "송장번호", "상품정보", "보내는 분", "받는 분", "보내는 주소", "받는 주소", "요청사항"]
    let contents = ["AXSD-SDXD-****-ZS**", "1233567", "홍삼즙", "다** (053-573-****)", "최** (010-2287-****)", "서울특별시 서초구 양재동 225-5", "서울특별시 서초구 양재동 225-5", "개가 뭅니다"]
    var lists = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh"]
    lazy var tableView: ListTableView = {
        let table = ListTableView(
            rowHeight: tableRowHeight,
            isScrollEnabled: false
        )
        table.dataSource = self
        table.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return table
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubviews([tableView])
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(CGFloat(lists.count)*tableRowHeight)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        switch indexPath.row {
        case 0:
            cell.backgroundColor = UIColor(rgb: 0xD9D9D9)
            break
        default:
            cell.backgroundColor = .white
        }
        return cell
    }
}
