//
//  ViewController.swift
//  MVVM
//
//  Created by Георгий Евсеев on 3.05.24.
//

import UIKit

protocol IMainViewController: AnyObject {
    func setLabelText(_ text: String)
    func bind()
}

class MainViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewModel: IMainViewModel = MainViewModel()
       
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }
    
    func setupUI() {
        view.backgroundColor = .orange
        
        view.addSubview(label)
        label.backgroundColor = .white
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        view.addSubview(button)
        let action = UIAction { _ in
            self.buttonPressed()
        }
        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = .blue
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func buttonPressed() {
        viewModel.buttonPressed()
    }
}

extension MainViewController: IMainViewController {
    func setLabelText(_ text: String) {
        DispatchQueue.main.async {
            self.label.text = text
        }
    }
    
    func bind() {
        viewModel.text.bind { value in
            self.label.text = value
        }
    }
}

