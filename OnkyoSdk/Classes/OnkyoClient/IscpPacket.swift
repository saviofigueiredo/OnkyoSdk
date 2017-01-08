//
//  IscpPacket.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation

class IscpPacket {
    
    public var message: String
    
    init (message: String) {
        self.message = message
    }
    
    init? (packet: Data) {
        
        guard packet.count > 17 else {
            return nil
        }
        
        let magicChunk = packet.subdata(in: 0..<4)
        let magic = String(data: magicChunk, encoding: String.Encoding.ascii)
 
        guard magic == "ISCP" else {
            return nil
        }
        
        let headerLengthChunk = packet.subdata(in: 4..<8)
        var headerLength: UInt32 = headerLengthChunk.withUnsafeBytes { $0.pointee }
        headerLength = CFSwapInt32BigToHost(headerLength)
        
        let dataLengthChunk = packet.subdata(in: 8..<12)
        var dataLength: UInt32 = dataLengthChunk.withUnsafeBytes { $0.pointee }
        dataLength = CFSwapInt32BigToHost(dataLength)
        
        let versionChunk = packet.subdata(in: 12..<13)
        let version: UInt32 = versionChunk.withUnsafeBytes { $0.pointee }
        
        let startMessageChunk = packet.subdata(in: 16..<17)
        let startMessage = String(data: startMessageChunk, encoding: String.Encoding.ascii)
        
        guard startMessage == "!" else {
            return nil
        }
        
        let receiverChunk = packet.subdata(in: 17..<18)
        let receiver = String(data: receiverChunk, encoding: String.Encoding.ascii)
        
        guard receiver == "1" else {
            return nil
        }
        
        let messageChunk = packet.subdata(in: Int(headerLength + 2)..<Int(headerLength + dataLength))
        message = String(data: messageChunk, encoding: String.Encoding.utf8)!
        
        message = message.replacingOccurrences(of: "\r", with: "", options: String.CompareOptions.literal, range:nil)
        message = message.replacingOccurrences(of: "\n", with: "", options: String.CompareOptions.literal, range:nil)
        message = message.replacingOccurrences(of: "\u{19}", with: "", options: String.CompareOptions.literal, range:nil)
        message = message.replacingOccurrences(of: "\u{1A}", with: "", options: String.CompareOptions.literal, range:nil)
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
