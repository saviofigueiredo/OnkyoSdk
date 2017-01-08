//
//  Sockaddr_inExtension.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/5/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation
import Darwin

extension sockaddr_in {
    
    enum SocketAddressType {
        case local
    }
    
    init(type: SocketAddressType?) {
        
        self = sockaddr_in()
        
        if type != nil && type! == .local {
            bzero(&self, MemoryLayout<sockaddr_in>.size)
            self.sin_family = sa_family_t(AF_INET)
            self.sin_addr.s_addr = INADDR_ANY
        }
    }
    
    init(address: String, port: UInt16) {
        
        self = sockaddr_in()
        bzero(&self, MemoryLayout<sockaddr_in>.size)
        self.sin_family = sa_family_t(PF_INET)
        self.sin_addr.s_addr = inet_addr(address)
        self.sin_port = htons(value: port)
    }
    
    init (address: inout sockaddr) {
        self = sockaddr_in()
        memcpy(&self, &address, Int(MemoryLayout<sockaddr>.size))
    }
    
    mutating func getInternetAddress() -> sockaddr {
        
        var address = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
        memcpy(&address, &self, Int(MemoryLayout<sockaddr_in>.size))
        return address
    }
    
    private func htons(value: CUnsignedShort) -> CUnsignedShort {
        return (value << 8) + (value >> 8);
    }
}
