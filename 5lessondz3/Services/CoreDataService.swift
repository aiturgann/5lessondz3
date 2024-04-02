//
//  CoreDataService.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 27/3/24.
//

import UIKit
import CoreData

class CoreDataService: NSObject {
    static let shared = CoreDataService()
    
    private override init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addNote(id: String, title: String, description: String, date: Date) {
        guard let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            return
        }
        
        let note = Note(entity: noteEntity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelegate.saveContext()
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func deleteNote(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                id == note.id
            }) else {
                return
            }
            context.delete(note)
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteNotes() {
        print("deleteNotes")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let notes = try context.fetch(fetchRequest) as? [Note]
            notes?.forEach({ note in
                context.delete(note)
            })
            
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func updateNote(id: String, title: String, description: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                id == note.id
            }) else {
                return
            }
            note.title = title
            note.desc = description
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    
}

