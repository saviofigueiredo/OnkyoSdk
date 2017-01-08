//
//  Socket.swift
//  Onkyo
//
//  Created by Savio Mendes de Figueiredo on 1/5/17.
//  Copyright © 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import Foundation
import Darwin

struct Packet {
    var address: String
    var packet: Data
}

class Socket {
    
    fileprivate let socketDescriptor: Int32
    
    init? () {
        
        var socketAddress: sockaddr_in = sockaddr_in(type: sockaddr_in.SocketAddressType.local)
        var broadcast: Int = 1;
        
        socketDescriptor = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)
        guard socketDescriptor != -1 else {
            return nil
        }
        
        var internetAddress = socketAddress.getInternetAddress()
        
        guard bind(socketDescriptor, &internetAddress, socklen_t(MemoryLayout<sockaddr_in>.size)) != -1 else {
            return nil
        }
        
        guard setsockopt(socketDescriptor, SOL_SOCKET, SO_BROADCAST, &broadcast, socklen_t(MemoryLayout<Int32>.size)) != -1 else {
            return nil
        }
    }
    
    init? (address: String, port: UInt16) {
        
        var socketAddress: sockaddr_in = sockaddr_in(address: address, port: port)
        
        socketDescriptor = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)
        
        guard inet_pton(AF_INET, address.cString(using: .ascii), &socketAddress.sin_addr) != -1 else {
        
            print ("Error code is \(errno)")
            print ("Error message is \(String(utf8String: strerror(errno)))")
            close(socketDescriptor)
            return nil
        }
        
        var internetAddress = socketAddress.getInternetAddress()
        
        guard connect(socketDescriptor, &internetAddress, socklen_t(MemoryLayout<sockaddr_in>.size)) != -1 else {
            close(socketDescriptor)
            return nil
        }
    }
    
    deinit {
        close (socketDescriptor)
    }
    
    func sendPacket(packet: Data) -> Data? {
        
        var array = [UInt8](repeating: 0, count: packet.count)
        packet.copyBytes(to: &array, count: packet.count)
        
        print ("Packet to be sent: \(String(data: packet, encoding: String.Encoding.utf8)!)")
        let bytesSentCount = send(socketDescriptor, array, array.count, 0)
        guard bytesSentCount == array.count else {
            print ("Number of sent bytes \(bytesSentCount) does not match the number of bytes to be sent \(array.count).")
            print ("Error code is \(errno)")
            print ("Error message is \(String(utf8String: strerror(errno)))")
            close (socketDescriptor)
            return nil
        }
        
        print ("\(bytesSentCount) have been sent!")
        
        var buffer = [UInt8](repeating: 0, count: 100)
        let bytesReceivedCount = recv(socketDescriptor, &buffer, 99, 0)
        if bytesReceivedCount < 1 {
            print ("Error code is \(errno)")
            print ("Error message is \(String(utf8String: strerror(errno)))")
            close(socketDescriptor)
            return nil
        }
        
        return Data(bytes: buffer)
    }
    
    func sendPacket(broadcastAddress: String, port: UInt16, packet: Data) {
        
        print ("Package will be broadcasted to \(broadcastAddress)")
        
        var destinationAddress: sockaddr_in = sockaddr_in(address: broadcastAddress, port: port)
        
        var internetAddress = destinationAddress.getInternetAddress()
        
        var array = [UInt8](repeating: 0, count: packet.count)
        packet.copyBytes(to: &array, count: packet.count)
        
        print ("Packet to be sent: \(String(data: packet, encoding: String.Encoding.utf8)!)")
        let numbytes = sendto(socketDescriptor, array, array.count, 0, &internetAddress, socklen_t(MemoryLayout<sockaddr_in>.size))
        
        print ("\(numbytes) have been sent to \(broadcastAddress)")
    }
    
    func getResponses() -> [Packet] {
        
        var destinationAddress: sockaddr_in = sockaddr_in()
        var buffer = [UInt8](repeating: 0, count: 100)
        var fileDescriptorSet: fd_set = fd_set()
        var packets: [Packet] = []
        
        while true {
            
            var ready: Int32
            
            repeat {
                fileDescriptorSet.clear()
                fileDescriptorSet.set(socketDescriptor)
                var timeout: timeval = timeval(tv_sec: 2, tv_usec: 0)
                ready = Darwin.select(socketDescriptor + 1, &fileDescriptorSet, nil, nil, &timeout)
            } while ready == -1 && errno == EINTR
            
            if ready == 0 {
                break
            }
            
            if fileDescriptorSet.isSet(socketDescriptor) {
                
                var addr_len: socklen_t = socklen_t(MemoryLayout<sockaddr_in>.size)
                
                var internetAddress = destinationAddress.getInternetAddress()
                
                let bytesReceivedCount = recvfrom(socketDescriptor, &buffer, 100, 0, &internetAddress, &addr_len)
                if bytesReceivedCount == -1 {
                    break
                }
                
                let deviceAddress = String(cString: inet_ntoa(sockaddr_in(address: &internetAddress).sin_addr), encoding: .ascii)!
                
                packets.append(Packet(address: deviceAddress, packet: Data(bytes: buffer)))
            }
        }
        
        return packets
    }
}
