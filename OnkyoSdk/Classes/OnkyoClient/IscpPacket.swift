//
//  IscpPacket.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation

class IscpPacket {
    
    let message: String
    
    init (message: String) {
        self.message = message
    }
    
    func getPacket() -> Data {
        
        var packet = NSMutableData(capacity: 50)!
        
        self.addIscpPrefixTo(packet: &packet)
        self.addHeaderLengthTo(packet: &packet)
        
        let messageData = message.data(using: String.Encoding.ascii)!
        let messageLength = messageData.count
        
        self.addMessageLengthTo(packet: &packet, length: messageLength)
        
        self.addVersionTo(packet: &packet)
        
        packet.append(messageData)
        
        return packet.copy() as! Data
    }
    
    private func addIscpPrefixTo(packet: inout NSMutableData) {
        
        let prefix: NSString = "ISCP"
        packet.append(prefix.data(using: String.Encoding.ascii.rawValue)!)
    }
    
    private func addVersionTo(packet: inout NSMutableData) {
        
        var bigEndianVersion = CFSwapInt32HostToBig(0x01000000)
        packet.append(&bigEndianVersion, length:MemoryLayout<UInt32>.size)
    }
    
    private func addHeaderLengthTo(packet: inout NSMutableData) {
        
        let headerLength = 16
        var bigEndianHeaderLength = CFSwapInt32HostToBig(UInt32(headerLength))
        packet.append(&bigEndianHeaderLength, length:MemoryLayout<UInt32>.size)
    }
    
    private func addMessageLengthTo(packet: inout NSMutableData, length: Int) {
        
        var bigEndianMessageLength = CFSwapInt32HostToBig(UInt32(length))
        packet.append(&bigEndianMessageLength, length:MemoryLayout<UInt32>.size)
    }
}
