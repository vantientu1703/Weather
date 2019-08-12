//
//  RAddress.swift
//  Weather
//
//  Created by Humaxvina on 8/8/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit
import RealmSwift

class RAddress: Object {
    
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var placeId: String?
    var types = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toAddress() -> Address {
        let address = Address()
        
        address.id = self.id.value
        address.name = self.name
        address.placeId = self.placeId
        for t in self.types {
            address.types.append(t)
        }
        return address
    }
    
    private func increaseId() -> Int {
        let objects = RAddress.getAllAddress()
        if let last = objects.last, let id = last.id {
            return id + 1
        }
        return 0
    }
    
    func add() {
        do {
            let realm = try Realm()
            try realm.write {
                self.id = RealmOptional(self.increaseId())
                realm.add(self)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
    func update() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self, update: Realm.UpdatePolicy.modified)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
    func delete() {
        do {

            let realm = try Realm()
            guard let id = self.id.value else { return }
            let objects = realm.objects(RAddress.self).filter("id == \(id)")
            if objects.count > 0 {
                try realm.write {
                    realm.delete(objects.first!)
                    try realm.commitWrite()
                }
            }
        } catch {
            print(error)
        }
    }
    
    static func getAllAddress() -> [Address] {
        do {
            let realm = try Realm()
            let objects = realm.objects(RAddress.self).sorted(byKeyPath: "id")
            var addrs: [Address] = []
            for r in objects {
                addrs.append(r.toAddress())
            }
            return addrs
        } catch {
            print(error)
            return []
        }
    }
    
    static func getAddress(placeId: String?) -> Address? {
        guard let placeId = placeId else { return nil }
        do {
            let realm = try Realm()
            let objects = realm.objects(RAddress.self).filter("placeId == '\(placeId)'")
            return objects.last?.toAddress()
        } catch {
            print(error)
            return nil
        }
    }
}

extension Address {
    func toRAddress() -> RAddress {
        let rAddress = RAddress()
        
        rAddress.id = RealmOptional(self.id)
        rAddress.name = self.name
        rAddress.placeId = self.placeId
        for t in self.types {
            rAddress.types.append(t)
        }
        
        return rAddress
    }
}
