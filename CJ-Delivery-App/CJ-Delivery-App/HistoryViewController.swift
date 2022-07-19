//
//  HistoryViewController.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/12.
//

import UIKit
import SnapKit

struct DeliveryDetail {
    let date: String
    let deliveryName: String
    let deliveryNumber: String
    let from: String
    let to: String
    let state: String
}

class HistoryViewController: UIViewController {
    
    let tableLabels = ["7.7","7.6","7.5","7.2","6.30"]
    let names = ["귀여운 먹순이 춘식이 대용량 시리얼 글라스 요거트볼","실리콘 냄비받침 - 08 클라우드(핑크)", "워치전용 충전 거치대_라이언&춘식이","수면바지 춘식이 필로우", "비피다바이옴아쿠아베리어크림80"]
    let numbers = ["12345678","3923848","39384739","38462463","29374626"]
    let states = ["배달 중", "배달 중", "배달 완료", "배달 완료","배달 완료"]
    let details = [
        DeliveryDetail(date: "7.7", deliveryName: "귀여운 먹순이 춘식이 대용량 시리얼 글라스 요거트볼", deliveryNumber: "12345678", from: "서울특별시", to: "부산광역시", state: "출발예정"),
        DeliveryDetail(date: "7.6", deliveryName: "실리콘 냄비받침 - 08 클라우드(핑크)", deliveryNumber: "3923848", from: "부산광역시", to: "광주광역시", state: "배송 중"),
        DeliveryDetail(date: "7.5", deliveryName: "워치전용 충전 거치대_라이언&춘식이", deliveryNumber: "39384739", from: "대구광역시", to: "울산광역시", state: "배송 중"),
        DeliveryDetail(date: "7.2", deliveryName: "수면바지 춘식이 필로우", deliveryNumber: "38462463", from: "대전광역시", to: "대구광역시", state: "배송 완료"),
        DeliveryDetail(date: "6.30", deliveryName: "비피다바이옴아쿠아베리어크림80", deliveryNumber: "29374626", from: "부산광역시", to: "부산광역시", state: "배송 완료")
    ]
    
    lazy var labelHistory : UILabel = {
        let label: UILabel = UILabel()
        label.text = "배송 내역"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tableDeliveryHistory: UITableView = {
        let table: UITableView = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(DeliveryDetailTableViewCell.self, forCellReuseIdentifier: DeliveryDetailTableViewCell.identifier)
        table.rowHeight = 100
        return table
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews([labelHistory,containerView])
        containerView.addSubview(tableDeliveryHistory)
        
        labelHistory.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(100)
            make.leading.equalTo(self.view).offset(15)
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        tableDeliveryHistory.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryDetailTableViewCell.identifier, for: indexPath) as! DeliveryDetailTableViewCell
        cell.labelDate.text = tableLabels[indexPath.row]
        cell.labelName.text = names[indexPath.row]
        cell.labelNumber.text = numbers[indexPath.row]
        cell.labelFrom.text = details[indexPath.row].from + " >> " + details[indexPath.row].to
        cell.labelState.text = states[indexPath.row]
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click: \(tableLabels[indexPath.row])")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.detail = details[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
