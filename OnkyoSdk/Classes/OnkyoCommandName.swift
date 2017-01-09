//
//  OnkyoCommandName.swift
//  Pods
//
//  Created by Savio Mendes de Figueiredo on 1/8/17.
//
//

public enum OnkyoCommandName : String {

    case powerOn = "PWR01"
    case powerOff = "PWR00"
    case powerQuery = "PWRQSTN"
    
    case audioMutingOn = "AMT01"
    case audioMutingOff = "AMT00"
    case audioMutingQuery = "AMTQSTN"
    
    case masterVolumeUp = "MVLUP"
    case masterVolumeDown = "MVLDOWN"
    case masterVolumeQuery = "MVLQSTN"
    
    case inputSelectorCdDvd = "SLI23"
    case inputSelectorFm = "SLI24"
    case inputSelectorAm = "SLI25"
    case inputSelectorTuner = "SLI26"
    case inputSelectorMusicServer = "SLI27"
    case inputSelectorInternetRadio = "SLI28"
    case inputSelectorUsbFront = "SLI29"
    case inputSelectorUsbRear = "SLI2A"
    case inputSelectorNetwork = "SLI2B"
    case inputSelectorQuery = "SLIQSTN"
}
