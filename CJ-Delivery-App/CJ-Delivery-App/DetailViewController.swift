//
//  DetailViewController.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detail: DeliveryDetail?
    let heightDetailListRow = 40
    
    lazy var lableDetails: UILabel = {
        let label: UILabel = UILabel()
        label.text = "기본 정보"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var lableState: UILabel = {
        let label: UILabel = UILabel()
        label.text = "상태 정보"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var viewDetailList: UIView = {
        let uiview: UIView = UIView()
        uiview.layer.cornerRadius = 10
        uiview.layer.borderWidth = 1
        uiview.layer.borderColor = UIColor.lightGray.cgColor
        return uiview
    } ()
    
    lazy var stackDetail: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    } ()
    
    lazy var buttonBack : UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("<  Back", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.touchUpBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonCamera : UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("배송 완료하기", for: .normal)
        button.addTarget(self, action: #selector(self.touchUpCameraButton), for: .touchUpInside)
        return button
    }()
    
    lazy var camera : UIImagePickerController = {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo
//        imagePicker.delegate = self
        return imagePicker
    } ()
    
    lazy var viewName = makeListRowView(rowTitle: "상품정보", rowContent: detail?.deliveryName)
    lazy var viewNumber = makeListRowView(rowTitle: "송장번호", rowContent: detail?.deliveryNumber)
    lazy var viewFrom = makeListRowView(rowTitle: "보내는 주소", rowContent: detail?.from)
    lazy var viewTo = makeListRowView(rowTitle: "받는 주소", rowContent: detail?.to)
//    lazy var viewFrom = makeListRowView(rowTitle: "보내는 분", rowContent: detail?.from)
    
    lazy var detailContents = [viewName,viewNumber,viewFrom,viewTo]
     
    @objc func touchUpBackButton() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func touchUpCameraButton() {
        print("배송완료")
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
//        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    private func makeListRowView(rowTitle: String?, rowContent: String?) -> UIView {
        let contentOffset = 100
        let view: UIView = UIView()
        let title = UILabel()
        let content = UILabel()
        
        title.text = rowTitle
        content.text = rowContent
        title.textColor = .gray
        
        view.addSubviews([title,content])
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        content.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(contentOffset)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews([
            lableDetails,
            buttonBack,
            viewDetailList,
            lableState,
            buttonCamera
        ])
        
        viewDetailList.addSubview(stackDetail)
        stackDetail.addArrangedSubviews(detailContents)
        
        stackDetail.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        
        detailContents.map { view in
            view.snp.makeConstraints { make in
                make.width.equalTo(viewDetailList)
                make.height.equalTo(heightDetailListRow)
            }
        }
        
        lableDetails.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(100)
            make.leading.equalTo(self.view).offset(15)
        }
        viewDetailList.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lableDetails.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(heightDetailListRow*detailContents.count+15)
        }
        buttonBack.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(50)
            make.leading.equalTo(self.view).offset(15)
        }
        lableState.snp.makeConstraints { make in
            make.top.equalTo(viewDetailList.snp.bottom).offset(30)
            make.leading.equalTo(self.view).offset(15)
        }
        buttonCamera.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(85)
        }
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

