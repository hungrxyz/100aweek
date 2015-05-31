//
//  OfflineBackupCenter.swift
//  TimerHelp100
//
//  Created by Zel Marko on 22/05/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit
import CoreData

class OfflineBackupManager {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var backup: Backup?

}

extension OfflineBackupManager {
    
    func requestBackup() -> Bool {
        let request = NSFetchRequest(entityName: "Backup")
        let results = managedObjectContext.executeFetchRequest(request, error: nil) as! [Backup]
        
        if let _backup = results.first {
            println(_backup.active)
            backup = _backup
            println("Backup is available.")
            return true
        }
        else {
            println("No backup available.")
            return false
        }
    }
    
    func getBackup() -> Backup {
        return backup!
    }
    
    func createBackup(startDate: NSDate, lastStartInterval: NSTimeInterval) {
        
        backup = Backup.createBackup(managedObjectContext, _startDate: startDate, _id: Formatter.dateToID(startDate), _lastStartInterval: lastStartInterval, _active: 1, _activeTime: 0, _pauseTime: 0)
        
        var error: NSError?
        if (managedObjectContext.save(&error)) {
            println("Initial backup created.")
        }
        else {
            println(error?.localizedDescription)
        }
    }
    
    func updateBackup(lastStartInterval: NSTimeInterval, active: Bool, activeTime: NSTimeInterval, pauseTime: NSTimeInterval) {
        if backup != nil {
            backup!.lastStartInterval = lastStartInterval
            backup!.active = active
            backup!.activeTime = activeTime
            backup!.pauseTime = pauseTime
        }
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            println("Backup updated.")
        }
        else {
            println(error?.localizedDescription)
        }
    }
    
    func delete() {
        managedObjectContext.deleteObject(backup!)
        
        var error: NSError?
        if managedObjectContext.save(&error) {
            println("Backup deleted")
            backup = nil
        }
        else {
            println(error?.localizedDescription)
        }
    }
}
