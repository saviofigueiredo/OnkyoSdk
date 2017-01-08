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
    
    public init? (address: String, packet: Data) {
        
        self.address = address
        
        guard let iscpPacket = IscpPacket(packet: packet) else {
            return nil
        }
        
        let message = iscpPacket.message
        
        let components = message.components(separatedBy: "/")
        
        self.model = components[0]
        self.model = self.model?.replacingOccurrences(of: "ECN", with: "", options: String.CompareOptions.literal, range:nil)
        
        self.port = components[1]
        self.uniqueIdentifier = components[3]
    }
}
