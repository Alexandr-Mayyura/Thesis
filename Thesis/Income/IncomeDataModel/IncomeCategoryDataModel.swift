//
//  IncomeCategoryDataModel.swift
//  Thesis
//
//  Created by Aleksandr Mayyura on 28.05.2021.
//

import Foundation
import RealmSwift

class IncomeCategory: Object {
    @objc dynamic var name: String = ""
    let items = List<IncomeItems>()
    
}
