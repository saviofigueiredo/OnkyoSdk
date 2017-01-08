//
//  OnkyoCommandFactory.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//
//

import Foundation

public class OnkyoCommandFactory {
    
    fileprivate let commands: [OnkyoCommand] = [
        OnkyoCommand(name: "powerOn", code: "PWR01"),
        OnkyoCommand(name: "powerOff", code: "PWR00"),
        OnkyoCommand(name: "powerQuery", code: "PWRQSTN"),
        
        OnkyoCommand(name: "audioMutingOn", code: "AMT01"),
        OnkyoCommand(name: "audioMutingOff", code: "AMT00"),
        OnkyoCommand(name: "audioMutingQuery", code: "AMTQSTN"),
        
        OnkyoCommand(name: "masterVolumeUp", code: "MVL01"),
        OnkyoCommand(name: "masterVolumeDown", code: "MVL00"),
        OnkyoCommand(name: "masterVolumeQuery", code: "MVLQSTN"),
        
        OnkyoCommand(name: "inputSelectorCdDvd", code: "SLI23"),
        OnkyoCommand(name: "inputSelectorFm", code: "SLI24"),
        OnkyoCommand(name: "inputSelectorAm", code: "SLI25"),
        OnkyoCommand(name: "inputSelectorTuner", code: "SLI26"),
        OnkyoCommand(name: "inputSelectorMusicServer", code: "SLI27"),
        OnkyoCommand(name: "inputSelectorInternetRadio", code: "SLI28"),
        OnkyoCommand(name: "inputSelectorUsbFront", code: "SLI29"),
        OnkyoCommand(name: "inputSelectorUsbRear", code: "SLI2A"),
        OnkyoCommand(name: "inputSelectorNetwork", code: "SLI2B"),
        OnkyoCommand(name: "inputSelectorQuery", code: "SLIQSTN")
    ]
    
    public func getCommandCode(commandName: String) -> String {
        
        for command in commands {
            if command.name == commandName {
                return command.code
            }
        }
        
        return ""
    }
}
