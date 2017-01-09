//
//  OnkyoCommandFactory.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/7/17.
//
//

import Foundation

public class OnkyoCommandFactory {
    
    public func getCommandCode(commandName: OnkyoCommandName) -> String {
        
        return commandName.rawValue
    }
}
