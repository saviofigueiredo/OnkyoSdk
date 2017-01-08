//
//  OnkyoDeviceFactory.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/6/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation

public class OnkyoDeviceFactory {
    
    public init() {
    }
    
    public func discoverDevices(broadcastAddress: String) -> [OnkyoDevice] {
        
        guard let socket = Socket() else {
            return []
        }
        
        let packet = self.getDiscoverPacket()
        
        socket.sendPacket(broadcastAddress: broadcastAddress, port: 60128, packet: packet)
        
        let packets = socket.getResponses()
        
        var devices: [OnkyoDevice] = []
        
        for packet in packets {
            let device = OnkyoDevice(address: packet.address, packet: packet.packet)
            devices.append(device)
        }
        
        return devices
    }
    
    private func getDiscoverPacket() -> Data {

        let iscpPacket = IscpPacket(message: "!xECNQSTN\r")
        return iscpPacket.getPacket()
    }
}
