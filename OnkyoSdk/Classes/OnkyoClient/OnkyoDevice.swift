//
//  OnkyoDevice.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/5/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation

public class OnkyoDevice {
    
    public var address: String?
    public var model: String?
    public var uniqueIdentifier: String?
    public var port: String?
    
    public init(address: String, packet: Data) {
        
        self.address = address
        
        let magicChunk = packet.subdata(in: 0..<4)
        let magic = String(data: magicChunk, encoding: String.Encoding.ascii)
        print ("Magic keyword is \(magic!)")
        
        let headerLengthChunk = packet.subdata(in: 4..<8)
        var headerLength: UInt32 = headerLengthChunk.withUnsafeBytes { $0.pointee }
        headerLength = CFSwapInt32BigToHost(headerLength)
        print ("Header length is \(headerLength)")
        
        let dataLengthChunk = packet.subdata(in: 8..<12)
        var dataLength: UInt32 = dataLengthChunk.withUnsafeBytes { $0.pointee }
        dataLength = CFSwapInt32BigToHost(dataLength)
        print ("Data length is \(dataLength)")
        
        let versionChunk = packet.subdata(in: 12..<13)
        let version: UInt32 = versionChunk.withUnsafeBytes { $0.pointee }
        print ("Version is \(version)")
        
        let messageChunk = packet.subdata(in: Int(headerLength)..<Int(headerLength + dataLength))
        let message = String(data: messageChunk, encoding: String.Encoding.utf8)!
        
        let components = message.components(separatedBy: "/")
        
        self.model = components[0]
        self.model = self.model?.replacingOccurrences(of: "!1ECN", with: "", options: String.CompareOptions.literal, range:nil)
        
        self.port = components[1]
        
        self.uniqueIdentifier = components[3]
        self.uniqueIdentifier = self.uniqueIdentifier?.replacingOccurrences(of: "\r", with: "", options: String.CompareOptions.literal, range:nil)
        self.uniqueIdentifier = self.uniqueIdentifier?.replacingOccurrences(of: "\n", with: "", options: String.CompareOptions.literal, range:nil)
        self.uniqueIdentifier = self.uniqueIdentifier?.replacingOccurrences(of: "\u{19}", with: "", options: String.CompareOptions.literal, range:nil)
    }
}
