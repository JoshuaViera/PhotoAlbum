//
//  ItemModel.swift
//  PhotoAlbum
//
//  Created by Joshua Viera on 1/17/19.
//  Copyright © 2019 Joshua Viera. All rights reserved.
//

import Foundation

final class ItemModel {
    
    private static let filename = "ToDoList.plist"
    private static var items = [Item]()
    
    static func getItems() -> [Item] {
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([Item].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        items = items.sorted{$0.date > $1.date}
        return items
    }
    
    static func addItem(item: Item) {
        items.append(item)
        save()
    }
    static func edit (item: Item, index: Int) {
        items.remove(at: index)
        items.insert(item, at: index)
        save()
    }
    
    static func save() {
        let path = DataPersistanceManager.filepathToDocumentDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoder error: \(error)")
        }
    }
    
    static func delete(atIndex index: Int) {
        items.remove(at: index)
        save()
    }
    static func update(newItem:Item, atIndex: Int) {
        items[atIndex] = newItem
        save()
    }
    
    
}
