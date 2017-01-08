//
//  OnkyoClient.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//
//

import Foundation

public class OnkyoClient {
    
    let socket: Socket?
    
    public init(device: OnkyoDevice) {
        
        socket = Socket(address: device.address!, port: UInt16(device.port!)!)
    }
    
    public func sendCommand(to: OnkyoDevice, commandName: OnkyoCommandName) -> String {
        
        guard socket != nil else {
            return ""
        }
        
        let commandCode = OnkyoCommandFactory().getCommandCode(commandName: commandName)
        
        let iscpPacket = IscpPacket(message: "!1\(commandCode)\r")
        
        let packet = iscpPacket.getPacket();
        
        let commandResult = socket!.sendPacket(packet: packet)
        
        return commandResult
    }
}
