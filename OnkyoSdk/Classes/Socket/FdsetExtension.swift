//
//  FdsetExtension.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/5/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation
import Darwin

extension fd_set {
    
    mutating func clear() {
        self.fds_bits = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    }
    
    func isSet(_ fd: Int32) -> Bool {
        let intOffset = Int(fd / 32)
        let bitOffset = fd % 32
        let mask = 1 << bitOffset
        switch intOffset {
        case 0: return self.fds_bits.0 & mask != 0
        case 1: return self.fds_bits.1 & mask != 0
        case 2: return self.fds_bits.2 & mask != 0
        case 3: return self.fds_bits.3 & mask != 0
        case 4: return self.fds_bits.4 & mask != 0
        case 5: return self.fds_bits.5 & mask != 0
        case 6: return self.fds_bits.6 & mask != 0
        case 7: return self.fds_bits.7 & mask != 0
        case 8: return self.fds_bits.8 & mask != 0
        case 9: return self.fds_bits.9 & mask != 0
        case 10: return self.fds_bits.10 & mask != 0
        case 11: return self.fds_bits.11 & mask != 0
        case 12: return self.fds_bits.12 & mask != 0
        case 13: return self.fds_bits.13 & mask != 0
        case 14: return self.fds_bits.14 & mask != 0
        case 15: return self.fds_bits.15 & mask != 0
        case 16: return self.fds_bits.16 & mask != 0
        case 17: return self.fds_bits.17 & mask != 0
        case 18: return self.fds_bits.18 & mask != 0
        case 19: return self.fds_bits.19 & mask != 0
        case 20: return self.fds_bits.20 & mask != 0
        case 21: return self.fds_bits.21 & mask != 0
        case 22: return self.fds_bits.22 & mask != 0
        case 23: return self.fds_bits.23 & mask != 0
        case 24: return self.fds_bits.24 & mask != 0
        case 25: return self.fds_bits.25 & mask != 0
        case 26: return self.fds_bits.26 & mask != 0
        case 27: return self.fds_bits.27 & mask != 0
        case 28: return self.fds_bits.28 & mask != 0
        case 29: return self.fds_bits.29 & mask != 0
        case 30: return self.fds_bits.30 & mask != 0
        case 31: return self.fds_bits.31 & mask != 0
        default: return false
        }
    }
    
    mutating func set(_ fd: Int32) {
        let intOffset = Int(fd / 32)
        let bitOffset = fd % 32
        let mask = 1 << bitOffset
        switch intOffset {
        case 0: self.fds_bits.0 = self.fds_bits.0 | mask
        case 1: self.fds_bits.1 = self.fds_bits.1 | mask
        case 2: self.fds_bits.2 = self.fds_bits.2 | mask
        case 3: self.fds_bits.3 = self.fds_bits.3 | mask
        case 4: self.fds_bits.4 = self.fds_bits.4 | mask
        case 5: self.fds_bits.5 = self.fds_bits.5 | mask
        case 6: self.fds_bits.6 = self.fds_bits.6 | mask
        case 7: self.fds_bits.7 = self.fds_bits.7 | mask
        case 8: self.fds_bits.8 = self.fds_bits.8 | mask
        case 9: self.fds_bits.9 = self.fds_bits.9 | mask
        case 10: self.fds_bits.10 = self.fds_bits.10 | mask
        case 11: self.fds_bits.11 = self.fds_bits.11 | mask
        case 12: self.fds_bits.12 = self.fds_bits.12 | mask
        case 13: self.fds_bits.13 = self.fds_bits.13 | mask
        case 14: self.fds_bits.14 = self.fds_bits.14 | mask
        case 15: self.fds_bits.15 = self.fds_bits.15 | mask
        case 16: self.fds_bits.16 = self.fds_bits.16 | mask
        case 17: self.fds_bits.17 = self.fds_bits.17 | mask
        case 18: self.fds_bits.18 = self.fds_bits.18 | mask
        case 19: self.fds_bits.19 = self.fds_bits.19 | mask
        case 20: self.fds_bits.20 = self.fds_bits.20 | mask
        case 21: self.fds_bits.21 = self.fds_bits.21 | mask
        case 22: self.fds_bits.22 = self.fds_bits.22 | mask
        case 23: self.fds_bits.23 = self.fds_bits.23 | mask
        case 24: self.fds_bits.24 = self.fds_bits.24 | mask
        case 25: self.fds_bits.25 = self.fds_bits.25 | mask
        case 26: self.fds_bits.26 = self.fds_bits.26 | mask
        case 27: self.fds_bits.27 = self.fds_bits.27 | mask
        case 28: self.fds_bits.28 = self.fds_bits.28 | mask
        case 29: self.fds_bits.29 = self.fds_bits.29 | mask
        case 30: self.fds_bits.30 = self.fds_bits.30 | mask
        case 31: self.fds_bits.31 = self.fds_bits.31 | mask
        default: break
        }
    }
}
