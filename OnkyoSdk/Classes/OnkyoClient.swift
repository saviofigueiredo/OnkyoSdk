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
    
    @discardableResult public func sendCommand(to: OnkyoDevice, commandName: OnkyoCommandName) -> OnkyoCommandResult {
        
        guard socket != nil else {
            return OnkyoCommandResult()
        }
        
        let commandCode = OnkyoCommandFactory().getCommandCode(commandName: commandName)
        
        let iscpPacket = IscpPacket(message: "!1\(commandCode)\r")
        
        let packet = iscpPacket.getPacket()
        
        let receivedPacket = socket!.sendPacket(packet: packet)
        
        let result = OnkyoCommandResult(receivedPacket: receivedPacket)
        print ("\(result.receivedCommandName)")
        print ("\(result.receivedMessage)")
        return result
    }
}
