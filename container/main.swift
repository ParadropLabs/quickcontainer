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


let NODE = "ws://localhost:8000/ws"
//let NODE = "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"

class RiffleSession: NSObject, MDWampClientDelegate {
    var socket: MDWampTransportWebSocket?
    var session: MDWamp?
    
    override init() {
        super.init()
        
        socket = MDWampTransportWebSocket(server:NSURL(string: NODE), protocolVersions:[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        session = MDWamp(transport: socket, realm: "pd.damouse.quick", delegate: self)
        
    }
    
    func connect() {
        print("Attempting to connect...")
        session?.connect()
        NSRunLoop.currentRunLoop().run()
    }
    
    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
        
        // Register methods
        wamp.registerRPC("pd.damouse.quick/hello", procedure: { (wamp: MDWamp!, invocation: MDWampInvocation!) -> Void in
            print("Someone called hello!")
        }, cancelHandler: { () -> Void in
            print("Register Cancelled!")
        }) { (err: NSError!) -> Void in
            print("An error occured: ", err)
        }
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
    }
    
}

let s = RiffleSession()

s.connect()


print("Done")


