//
//  Command.swift
//  houzie
//
//  Created by syahRiza on 2/13/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import Foundation


struct Ev3 {
    
    func dance(){
        let cmd = Command(cmdStr: "!ev3 dance")
        
        cmd.exec()
    }
}

struct SmartHome {
    let base = "!smarthome"
    func getTemprature(){
        let cmd = Command(cmdStr: "\(base) get temprature")
        
        cmd.exec()
    }
    func remote(stat : Bool){
        let status = stat ? "on" : "off"
        
        let cmd = Command(cmdStr: "\(base) remote \(status) ")
        cmd.exec()
    }
}

class Command {
    let cmdStr : String
    init(cmdStr : String){
        self.cmdStr = cmdStr
    }
    var error : NSError?
    
    func exec(){
        let client = Manager.sharedManager.mxClient
        client.sendMessageToRoom(Manager.sharedManager.roomID,
            msgType: kMXMessageTypeText,
            content: ["body": cmdStr],
            success: { (result) -> Void in
                print(result)
                
            }) { (error ) -> Void in
                print(error.localizedDescription)
                self.error = error
        }
    }
}