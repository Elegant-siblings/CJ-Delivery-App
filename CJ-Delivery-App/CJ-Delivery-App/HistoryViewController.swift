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
        DeliveryDetail(date: "7.7", deliveryName: "귀여운 먹순이 춘식이 대용량 시리얼 글라스 요거트볼", deliveryNumber: "12345678", from: "서울특별시", to: "부산광역시", state: "배송 중"),
        DeliveryDetail(date: "7.6", deliveryName: "실리콘 냄비받침 - 08 클라우드(핑크)", deliveryNumber: "3923848", from: "부산광역시", to: "광주광역시", state: "배송 중"),
        DeliveryDetail(date: "7.5", deliveryName: "워치전용 충전 거치대_라이언&춘식이", deliveryNumber: "39384739", from: "대구광역시", to: "울산광역시", state: "배송 완료"),
        DeliveryDetail(date: "7.2", deliveryName: "수면바지 춘식이 필로우", deliveryNumber: "38462463", from: "대전광역시", to: "대구광역시", state: "배송 완료"),
        DeliveryDetail(date: "6.30", deliveryName: "비피다바이옴아쿠아베리어크림80", deliveryNumber: "29374626", from: "부산광역시", to: "부산광역시", state: "배송 완료")
    ]
    
    lazy var test: UILabel = {
        let label: UILabel = UILabel()
        label.text = "HistoryViewController"
        return label
    }()
    
    private let tableDeliveryHistory: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DeliveryDetailTableViewCell.self, forCellReuseIdentifier: DeliveryDetailTableViewCell.identifier)
        table.rowHeight = 100
        return table
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableDeliveryHistory.dataSource = self
        self.tableDeliveryHistory.delegate = self
        
        self.view.addSubview(tableDeliveryHistory)
        
        tableDeliveryHistory.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
//            make.centerX.equalToSuperview()
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryDetailTableViewCell.identifier, for: indexPath) as! DeliveryDetailTableViewCell
//        cell.uiView.backgroundColor = .red
        cell.labelDate.text = tableLabels[indexPath.row]
        cell.labelName.text = names[indexPath.row]
        cell.labelNumber.text = numbers[indexPath.row]
//        cell.backgroundColor = .red
        cell.labelState.text = states[indexPath.row]
        cell.layer.cornerRadius = 0.5
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click: \(tableLabels[indexPath.row])")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.text = details[indexPath.row].deliveryName
        vc.detail = details[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
