//
//  ViewController.swift
//  CJ-Delivery-App
//
//  Created by 최원준 on 2022/07/04.
//

import UIKit
import SnapKit

struct CitiesManager {
    let cities = [
        City(name: "서울시", goos: ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구","강동구"]),
        City(name: "부산시", goos: ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구", "기장군"]),
        City(name: "대구시", goos: ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군"]),
        City(name: "인천시", goos: ["중구", "동구", "남구", "미추홀구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"]),
        City(name: "광주시", goos: ["동구", "서구", "남구", "북구", "광산구"]),
        City(name: "대전시", goos: ["동구", "중구", "서구", "유성구", "대덕구"]),
        City(name: "울산시", goos: ["중구", "남구", "동구", "북구", "울주군"])
    ]
}

struct City {
    let name: String
    let goos: [String]
}

struct ApplyManager {
    let type: String
    let date: Date
    let time: String
    let count: String
    let city: String
    let goo: String
}

class ViewController: UIViewController {
    
    let shippingTypes: [String] = ["일반", "반품"]
    let shippingTimes: [String] = ["주간", "새벽"]
    let avaiables: [String] = ["세단", "쿠페", "왜건", "SUV", "컨버터블", "해치백", "밴", "픽업트럭","기타"]
    let pageTitle: String = "배송 신청"
    let sectionTitlefontSize = CGFloat(25)
    let citiesManager = CitiesManager()
    
    var type: String = "일반"
    var date: Date = Date()
    var time: String = "주간"
    var count: String = "세단"
    var city: String = "서울시"
    var goo: String = "종로구"
    
    //-MARK: UIView
    lazy var labelPageTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = pageTitle
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    lazy var labelShippingType: UILabel = {
        let label: UILabel = UILabel()
        label.text = "배송 타입"
        label.font = .systemFont(ofSize: sectionTitlefontSize, weight: .semibold)
        return label
    }()
    
    lazy var labelDate: UILabel = {
        let label: UILabel = UILabel()
        label.text = "날짜"
        label.font = .systemFont(ofSize: sectionTitlefontSize, weight: .semibold)
        return label
    }()
    
    lazy var labelTime: UILabel = {
        let label: UILabel = UILabel()
        label.text = "배송 시간"
        label.font = .systemFont(ofSize: sectionTitlefontSize, weight: .semibold)
        return label
    }()
    
    lazy var labelCount: UILabel = {
        let label: UILabel = UILabel()
        label.text = "배송 수량"
        label.font = .systemFont(ofSize: sectionTitlefontSize, weight: .semibold)
        return label
    }()
    
    lazy var warningLabel: UILabel = {
        var label:UILabel = UILabel()
        label.text = "차종을 선택해주세요."
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .red
        return label
    }()
    
    lazy var labelLocal: UILabel = {
        let label: UILabel = UILabel()
        label.text = "배송 지역"
        label.font = .systemFont(ofSize: sectionTitlefontSize, weight: .semibold)
        return label
    }()
    
    lazy var SCShippingType: UISegmentedControl = {
        let sc: UISegmentedControl = UISegmentedControl(items: shippingTypes)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(shippingTypeChanged(type:)), for: UIControl.Event.valueChanged)
        return sc
    }()
    
    lazy var SCShippingTime: UISegmentedControl = {
        let sc: UISegmentedControl = UISegmentedControl(items: shippingTimes)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(shippingTimeChanged(time:)), for: UIControl.Event.valueChanged)
        return sc
    }()
    
    lazy var datePicker: UIDatePicker = {
        let dp: UIDatePicker = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        dp.minimumDate = Date()
        dp.locale = Locale(identifier: "ko-KR")
        dp.timeZone = .autoupdatingCurrent
        dp.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        return dp
    }()
    
    lazy var tfAvailCount: UITextField = {
        let tf: UITextField = UITextField()
        tf.placeholder = "차량 종류를 입력하세요."
        tf.inputView = pickerAvailCount
        tf.inputAccessoryView = toolbar
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var toolbar: UIToolbar = {
        let tb: UIToolbar = UIToolbar()
        tb.barStyle = UIBarStyle.default
        tb.isTranslucent = true
        tb.sizeToFit()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        tb.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        tb.isUserInteractionEnabled = true
    
        return tb
    }()
    
    lazy var applyButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .darkGray
//        button.layer.cornerRadius = 5
        button.setTitle("배송 요청하기", for: .normal)
        button.addTarget(self, action: #selector(self.touchUpApplyButton), for: .touchUpInside)
        return button
    }()
    
    let pickerAvailCount = UIPickerView()
    let pickerCity = UIPickerView()
    
    //-MARK: #Selector
    @objc
    func shippingTypeChanged(type: UISegmentedControl) {
        var text: String = "일반"
        switch type.selectedSegmentIndex {
            case 0:
              text = "일반"
            case 1:
              text = "반품"
            default: return
        }
        self.type = text
    }
    
    @objc
    func shippingTimeChanged(time: UISegmentedControl) {
        var text: String = "주간"
        switch time.selectedSegmentIndex {
            case 0:
              text = "주간"
            case 1:
              text = "새벽"
            default: return
        }
        self.time = text
    }
    
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        self.date = sender.date
    }
    
    @objc func donePicker() {
        let row = self.pickerAvailCount.selectedRow(inComponent: 0)
        self.pickerAvailCount.selectRow(row, inComponent: 0, animated: false)
        self.tfAvailCount.text = self.avaiables[row]
        self.tfAvailCount.resignFirstResponder()
        self.count = tfAvailCount.text!
        warningLabel.textColor = .white
    }
    
    @objc func cancelPicker() {
        self.tfAvailCount.text = nil
        self.tfAvailCount.resignFirstResponder()
        warningLabel.textColor = .red
    }
    
    @objc func touchUpApplyButton() {
        if tfAvailCount.text == "" {
            return
        }
        let applyInfo = ApplyManager(type: self.type, date: self.date, time: self.time, count: self.count, city: self.city, goo: self.goo)
        print(applyInfo)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerAvailCount.delegate = self
        pickerAvailCount.dataSource = self
        pickerCity.delegate = self
        pickerCity.dataSource = self

        // Do any additional setup after loading the view.
        self.view.addSubview(labelPageTitle)
        self.view.addSubview(labelShippingType)
        self.view.addSubview(labelDate)
        self.view.addSubview(SCShippingType)
        self.view.addSubview(datePicker)
        self.view.addSubview(labelTime)
        self.view.addSubview(SCShippingTime)
        self.view.addSubview(labelCount)
        self.view.addSubview(tfAvailCount)
        self.view.addSubview(labelLocal)
        self.view.addSubview(warningLabel)
        self.view.addSubview(pickerCity)
        self.view.addSubview(applyButton)
        
        labelPageTitle.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(100)
            make.leading.equalTo(self.view).offset(15)
        }
        labelShippingType.snp.makeConstraints{ make in
            make.top.equalTo(labelPageTitle.snp.bottom).offset(40)
            make.leading.equalTo(self.view).offset(20)
        }
        SCShippingType.snp.makeConstraints{ make in
            make.leading.equalTo(self.view.frame.width/2)
            make.centerY.equalTo(labelShippingType)
        }
        labelDate.snp.makeConstraints{ make in
            make.top.equalTo(labelShippingType.snp.bottom).offset(30)
            make.leading.equalTo(self.view).offset(20)
        }
        datePicker.snp.makeConstraints{ (make) in
            make.top.equalTo(labelDate.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
        }
        labelTime.snp.makeConstraints{ make in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.leading.equalTo(self.view).offset(20)
        }
        SCShippingTime.snp.makeConstraints{ (make) in
            make.leading.equalTo(self.view.frame.width/2)
            make.centerY.equalTo(labelTime)
        }
        labelCount.snp.makeConstraints{ make in
            make.top.equalTo(labelTime.snp.bottom).offset(38)
            make.leading.equalTo(self.view).offset(20)
        }
        tfAvailCount.snp.makeConstraints{ make in
            make.centerY.equalTo(labelCount)
            make.leading.equalTo(self.view.frame.width/2)
            make.width.equalTo(self.view.frame.width/2-8)
            make.height.equalTo(50)
        }
        warningLabel.snp.makeConstraints{ make in
            make.leading.equalTo(tfAvailCount).offset(1)
            make.top.equalTo(tfAvailCount.snp.bottom).offset(2)
        }

        labelLocal.snp.makeConstraints{ make in
            make.top.equalTo(labelCount.snp.bottom).offset(38)
            make.leading.equalTo(self.view).offset(20)
        }
        pickerCity.snp.makeConstraints{ make in
            make.top.equalTo(labelLocal.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
        }
        applyButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(85)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // delegate, datasource 연결 및 picker를 textfied의 inputview로 설정한다
    // pickerview는 하나만
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerAvailCount {
            return 1
        }
        else {
            return 2
        }
    }
    // pickerview의 선택지는 데이터의 개수만큼
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerAvailCount {
            return avaiables.count
        }
        else {
            if component==0 {
                return citiesManager.cities.count
            }
            else {
                let selectedCity = pickerCity.selectedRow(inComponent: 0)
                return citiesManager.cities[selectedCity].goos.count
            }
        }
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerAvailCount {
            return avaiables[row]
        }
        else {
            if component == 0 {
                return citiesManager.cities[row].name
            }
            else {
                let selectedCity = pickerCity.selectedRow(inComponent: 0)
                return citiesManager.cities[selectedCity].goos[row]
            }
        }
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerAvailCount {
            self.tfAvailCount.text = self.avaiables[row]
            warningLabel.textColor = .white
        }
        else {
            if component == 0 {
                pickerCity.selectRow(0, inComponent: 1, animated: false)
            }

            let cityIdx = pickerCity.selectedRow(inComponent: 0)
            let selectedCity = citiesManager.cities[cityIdx].name
            let gooIdx = pickerCity.selectedRow(inComponent: 1)
            let selectedGoo = citiesManager.cities[cityIdx].goos[gooIdx]
            self.city = selectedCity
            self.goo = selectedGoo
            
            pickerCity.reloadComponent(1)
        }
    }
}
