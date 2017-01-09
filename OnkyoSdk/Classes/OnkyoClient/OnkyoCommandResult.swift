//
//  OnkyoCommandResult.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/8/17.
//
//

import Foundation

public struct OnkyoCommandResult {
    
    public let successfull: Bool

    public var receivedPacket: Data?
    
    public var receivedMessage: String?
    
    public var receivedCommandName: OnkyoCommandName? {
        
        guard self.receivedMessage != nil else {
            return nil
        }
        
        return OnkyoCommandName(rawValue: self.receivedMessage!)
    }
    
    init () {
        self.successfull = false
    }
    
    init (receivedPacket: Data?) {
        
        guard let receivedPacket = receivedPacket else {
            self.successfull = false
            return
        }
        
        self.receivedPacket = receivedPacket
        
        guard let returnedPacket = IscpPacket(packet: receivedPacket) else {
            self.successfull = false
            return
        }
        
        self.receivedMessage = returnedPacket.message
        
        self.successfull = true
    }
}
