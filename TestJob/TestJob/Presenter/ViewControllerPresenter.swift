//
//  ViewControllerPresenter.swift
//  TestJob
//
//  Created by Priyanka Sinha on 09/12/23.
//

import Foundation

protocol ViewControllerPresenterDelegate : AnyObject{
    func showData(item:[Item])
}

class ViewControllerPresenter {
    
    weak var delegate:ViewControllerPresenterDelegate?
    let viewControllerModel:ViewControllerModel
    
    init(controllerModel:ViewControllerModel) {
        self.viewControllerModel  = controllerModel
        self.viewControllerModel.delegate = self
    }
    
    func fetchData() {
    
        viewControllerModel.fetchDataFromServer()
    }
    
}

extension ViewControllerPresenter : ViewControllerModelDelegate {
    func getData(items: [Item]) {
        delegate?.showData(item: items)
    }
}
