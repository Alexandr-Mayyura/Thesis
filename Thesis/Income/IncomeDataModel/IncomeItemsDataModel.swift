//
//  IncomeItemsDataModel.swift
//  Thesis
//
//  Created by Aleksandr Mayyura on 28.05.2021.
//

import Foundation
import RealmSwift

class IncomeItems: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var income: Int = 0
    var parentCategory = LinkingObjects(fromType: IncomeCategory.self, property: "items" )
}
