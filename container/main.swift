//
//  main.swift
//  container
//
//  Created by Mickey Barboi on 9/24/15.
//  Copyright © 2015 paradrop. All rights reserved.
//

import Foundation
import Cocoa

print("Starting Container")


//let URL = "ws://localhost:8000/ws"

class RiffleSession: NSObject, MDWampClientDelegate {
    var socket: MDWampTransportWebSocket?
    var session: MDWamp?
    
    override init() {
        super.init()
        socket = MDWampTransportWebSocket(server:NSURL(string: "ws://localhost:8000/ws"), protocolVersions:[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        session = MDWamp(transport: socket, realm: "pd.damouse", delegate: self)
        
    }
    
    func connect() {
        print("Attempting to connect...")
        session?.connect()
    }
    
    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
    }
    
}

let s = RiffleSession()


// Attempt 1 to get the program to block
//let oldify = NSBlockOperation() {
//    NSThread.sleepForTimeInterval(10)
//    NSLog("Sleep finished")
//}
//
//let queue = NSOperationQueue()
//queue.addOperations([oldify], waitUntilFinished: true)

// Attempt 2

//dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
//    let s = RiffleSession()
//}
//
//NSThread.sleepForTimeInterval(2)



// Attempt 3
//let qualityOfServiceClass = QOS_CLASS_BACKGROUND
//let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
//dispatch_async(backgroundQueue, {
//    s.connect()
//    
//    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//        print("This is run on the main queue, after the previous code in outer block")
//    })
//})
//
//NSThread.sleepForTimeInterval(2)

// Attempt 4
s.connect()
NSRunLoop.currentRunLoop().run()

print("Done")


