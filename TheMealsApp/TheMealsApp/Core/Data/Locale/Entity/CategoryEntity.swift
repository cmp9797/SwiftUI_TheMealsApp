//
//  Entity.swift
//  TheMealsApp
//
//  Created by Celine Margaretha on 22/05/24.
//

import Foundation
import RealmSwift
 
class CategoryEntity: Object {
 
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""
 
  override static func primaryKey() -> String? {
    return "id"
  }
 
}
