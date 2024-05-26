//
//  Presenter.swift
//  MVVM
//
//  Created by Георгий Евсеев on 3.05.24.
//

import UIKit

protocol IMainViewModel: AnyObject {
    func parse(data: Data)
    func buttonPressed()
    var text: Bindable<String> { get }
}

final class MainViewModel {
    private let router: IMainRouter = MainRouter()
    var networkManager: INetworkManager = NetworkManager()
    weak var view: IMainViewController?
    
    var text = Bindable<String> (value: "")
}

extension MainViewModel: IMainViewModel {
    func parse(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [Any] {
            DispatchQueue.main.async {
                self.text.value = "json: \(json)"
            }
        }
    }

    func buttonPressed() {
        networkManager.sendRequest(adress: UrlString().baseUrlString, completion: { data, _ in
            if let data = data {
                self.parse(data: data)
            }
        })
    }
}

