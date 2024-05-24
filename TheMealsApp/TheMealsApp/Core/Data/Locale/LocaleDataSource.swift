//
//  LocaleDataSource.swift
//  TheMealsApp
//
//  Created by Celine Margaretha on 22/05/24.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {

  func getCategories() -> Observable<[CategoryEntity]>
  func addCategories(from categories: [CategoryEntity]) -> Observable<Bool>
}
 
final class LocaleDataSource: NSObject {
 
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
 
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getCategories() -> Observable<[CategoryEntity]> {
     return Observable<[CategoryEntity]>.create { observer in
       if let realm = self.realm {
         let categories: Results<CategoryEntity> = {
           realm.objects(CategoryEntity.self)
             .sorted(byKeyPath: "title", ascending: true)
         }()
         let categoryArray = Array(categories.map { $0 })
         observer.onNext(categoryArray)
//         observer.onNext(categories.toArray(ofType: CategoryEntity.self))
         observer.onCompleted()
       } else {
         observer.onError(DatabaseError.invalidInstance)
       }
       return Disposables.create()
     }
   }
   func addCategories(from categories: [CategoryEntity]) -> Observable<Bool> {
     return Observable<Bool>.create { observer in
       if let realm = self.realm {
         do {
           try realm.write {
             for category in categories {
               realm.add(category, update: .all)
             }
             observer.onNext(true)
             observer.onCompleted()
           }
         } catch {
           observer.onError(DatabaseError.requestFailed)
         }
       } else {
         observer.onError(DatabaseError.invalidInstance)
       }
       return Disposables.create()
     }
   }
}
