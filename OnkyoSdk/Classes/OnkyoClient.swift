//
//  OnkyoClient.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//
//

import Foundation

public class OnkyoClient {
    
    public init() {
        
    }
    
    public func sendCommand(to: OnkyoDevice, commandName: String) -> String {
        
        let commandCode = OnkyoCommandFactory().getCommandCode(commandName: commandName)
        
        let iscpPacket = IscpPacket(message: "!1\(commandCode)\r")
        
        let packet = iscpPacket.getPacket();
        
        let socket = Socket(address: to.address!, port: UInt16(to.port!)!)
        
        let commandResult = socket?.sendPacket(packet: packet)
        
        return commandResult!
    }
}
