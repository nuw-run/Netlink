//
//  NL80211Tests.swift
//  NetlinkTests
//
//  Created by Alsey Coleman Miller on 8/10/18.
//

import Foundation
import XCTest
import CNetlink
@testable import Netlink
@testable import NetlinkGeneric
@testable import Netlink80211

final class Netlink80211Tests: XCTestCase {
    
    func testGetScanResultsCommand() {
        
        do {
            
            /**
             Waiting for scan to complete...
             Got 33.
             Got NL80211_CMD_NEW_SCAN_RESULTS.
             Scan is done.
             NL80211_CMD_GET_SCAN sent 28 bytes to the kernel.
             
             [0x1C, 0x00, 0x00, 0x00, 0x1C, 0x00, 0x05, 0x03, 0xE2, 0x72, 0x5E, 0x5B, 0x10, 0x19, 0xC0, 0xDC, 0x20, 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0x00, 0x06, 0x00, 0x00, 0x00]
             */
            
            let data = Data([0x1C, 0x00, 0x00, 0x00, 0x1C, 0x00, 0x05, 0x03, 0xE2, 0x72, 0x5E, 0x5B, 0x10, 0x19, 0xC0, 0xDC, 0x20, 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0x00, 0x06, 0x00, 0x00, 0x00])
            
            var decoder = NetlinkAttributeDecoder()
            decoder.log = { print("Decoder:", $0) }
            
            guard let message = NetlinkGenericMessage(data: data),
                let attributes = try? decoder.decode(message)
                else { XCTFail("Could not parse message from data"); return }
            
            XCTAssertEqual(message.data, data)
            XCTAssertEqual(message.length, 28)
            XCTAssertEqual(Int(message.length), data.count)
            XCTAssertEqual(message.type.rawValue, 28) // NetlinkGenericFamilyIdentifier(rawValue: 28)
            XCTAssertEqual(message.command.rawValue, NetlinkGenericCommand.NL80211.getScan.rawValue)
            XCTAssertEqual(message.version.rawValue, 0)
            XCTAssertEqual(message.flags, 773)
            XCTAssertEqual(attributes.count, 1)
            
            do {
                
                let command = try decoder.decode(NL80211GetScanResultsCommand.self, from: message)
                XCTAssertEqual(command.interface, 6)
            }
                
            catch { XCTFail("Could not decode: \(error)"); return }
            
            do {
                
                let value = NL80211GetScanResultsCommand(interface: 6)
                
                var encoder = NetlinkAttributeEncoder()
                encoder.log = { print("Encoder:", $0) }
                
                let data = try encoder.encode(value)
                
                XCTAssertEqual(message.payload, data)
            }
                
            catch { XCTFail("Could not encode: \(error)"); return }
        }
        
        do {
            /**
             Interface: wlx74da3826382c
             Wireless Extension Version: 0
             Wireless Extension Name: IEEE 802.11
             interface 3
             nl80211 NetlinkGenericFamilyIdentifier(rawValue: 28)
             Sent 28 bytes to kernel
             [28, 0, 0, 0, 28, 0, 5, 5, 96, 138, 91, 91, 237, 32, 0, 92, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0]
             Operation not supported
             */
            
            let data = Data([28, 0, 0, 0, 28, 0, 1, 5, 0, 0, 0, 0, 47, 104, 0, 0, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0])
            
            guard let message = NetlinkGenericMessage(data: data)
                else { XCTFail("Could not parse message from data"); return }
            
            XCTAssertEqual(message.data, data)
            XCTAssertEqual(message.length, 28)
            XCTAssertEqual(Int(message.length), data.count)
            XCTAssertEqual(message.type.rawValue, 28) // NetlinkGenericFamilyIdentifier(rawValue: 28)
            XCTAssertEqual(message.command.rawValue, NetlinkGenericCommand.NL80211.getScan.rawValue)
            XCTAssertEqual(message.version.rawValue, 0)
            XCTAssertEqual(message.flags, [.dump, .request])
            XCTAssertEqual(message.sequence, 0)
            
            do {
                
                var decoder = NetlinkAttributeDecoder()
                decoder.log = { print("Decoder:", $0) }
                let command = try decoder.decode(NL80211GetScanResultsCommand.self, from: message)
                
                XCTAssertEqual(command.interface, 3)
            }
                
            catch { XCTFail("Could not decode: \(error)"); return }
            
            do {
                
                let value = NL80211GetScanResultsCommand(interface: 3)
                
                var encoder = NetlinkAttributeEncoder()
                encoder.log = { print("Encoder:", $0) }
                
                let data = try encoder.encode(value)
                
                XCTAssertEqual(message.payload, data)
            }
                
            catch { XCTFail("Could not encode: \(error)"); return }
            
            var attributes = [NetlinkAttribute]()
            XCTAssertNoThrow(attributes = try NetlinkAttributeDecoder().decode(message))
            
            guard attributes.count == 1
                else { XCTFail(); return }
            
            XCTAssertEqual(UInt32(attributeData: attributes[0].payload), 3)
            XCTAssertEqual(attributes[0].payload, Data([0x03, 0x00, 0x00, 0x00]))
            XCTAssertEqual(attributes[0].type.rawValue, NetlinkAttributeType.NL80211.interfaceIndex.rawValue)
            
            // libnl message
            XCTAssertEqual(NetlinkGenericMessage(data: Data([28, 0, 0, 0, 28, 0, 5, 5, 96, 138, 91, 91, 237, 32, 0, 92, 32, 0, 0, 0, 8, 0, 3, 0, 3, 0, 0, 0]))?.flags, [.dump, .acknowledgment, .request])
        }
    }
    
    func testTriggerScanStatus() {
        
        do {
            
            /**
             WIPHY [1, 0, 0, 0]
             IFINDEX [4, 0, 0, 0]
             WDEV [1, 0, 0, 0, 1, 0, 0, 0]
             SCAN_SSIDS []
             SCAN_FREQUENCIES [8, 0, 0, 0, 108, 9, 0, 0, 8, 0, 1, 0, 113, 9, 0, 0, 8, 0, 2, 0, 118, 9, 0, 0, 8, 0, 3, 0, 123, 9, 0, 0, 8, 0, 4, 0, 128, 9, 0, 0, 8, 0, 5, 0, 133, 9, 0, 0, 8, 0, 6, 0, 138, 9, 0, 0, 8, 0, 7, 0, 143, 9, 0, 0, 8, 0, 8, 0, 148, 9, 0, 0, 8, 0, 9, 0, 153, 9, 0, 0, 8, 0, 10, 0, 158, 9, 0, 0, 8, 0, 11, 0, 163, 9, 0, 0, 8, 0, 12, 0, 168, 9, 0, 0]
             */
            
            /**
             ▿ Netlink.NL80211TriggerScanStatus
             - wiphy: 1
             - interface: 4
             - wirelessDevice: 4294967297
             - scanSSIDs: 0 elements
             ▿ scanFrequencies: 13 elements
             - 2412
             - 2417
             - 2422
             - 2427
             - 2432
             - 2437
             - 2442
             - 2447
             - 2452
             - 2457
             - 2462
             - 2467
             - 2472
             */
            
            let data = Data([160, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 1, 0, 0, 8, 0, 1, 0, 1, 0, 0, 0, 8, 0, 3, 0, 4, 0, 0, 0, 12, 0, 153, 0, 1, 0, 0, 0, 1, 0, 0, 0, 4, 0, 45, 0, 108, 0, 44, 0, 8, 0, 0, 0, 108, 9, 0, 0, 8, 0, 1, 0, 113, 9, 0, 0, 8, 0, 2, 0, 118, 9, 0, 0, 8, 0, 3, 0, 123, 9, 0, 0, 8, 0, 4, 0, 128, 9, 0, 0, 8, 0, 5, 0, 133, 9, 0, 0, 8, 0, 6, 0, 138, 9, 0, 0, 8, 0, 7, 0, 143, 9, 0, 0, 8, 0, 8, 0, 148, 9, 0, 0, 8, 0, 9, 0, 153, 9, 0, 0, 8, 0, 10, 0, 158, 9, 0, 0, 8, 0, 11, 0, 163, 9, 0, 0, 8, 0, 12, 0, 168, 9, 0, 0])
            
            var decoder = NetlinkAttributeDecoder()
            decoder.log = { print("Decoder:", $0) }
            
            // parse response
            guard let messages = try? NetlinkGenericMessage.from(data: data),
                let message = messages.first,
                let attributes = try? decoder.decode(message),
                let wiphyAttribute = attributes.first(where: { $0.type == NetlinkAttributeType.NL80211.wiphy }),
                let wiphy = UInt32(attributeData: wiphyAttribute.payload),
                let interfaceAttribute = attributes.first(where: { $0.type == NetlinkAttributeType.NL80211.interfaceIndex }),
                let interface = UInt32(attributeData: interfaceAttribute.payload)
                else { XCTFail("Could not parse message from data"); return }
            
            XCTAssertEqual(message.data, data)
            XCTAssertEqual(message.length, 160)
            XCTAssertEqual(Int(message.length), data.count)
            XCTAssertEqual(message.type.rawValue, 28) // driver ID
            XCTAssertEqual(message.command.rawValue, NetlinkGenericCommand.NL80211.triggerScan.rawValue)
            XCTAssertEqual(message.version.rawValue, 1)
            XCTAssertEqual(message.flags, 0)
            XCTAssertEqual(message.sequence, 0)
            
            XCTAssertEqual(wiphy, 1)
            XCTAssertEqual(interface, 4)
            
            do {
                let value = try decoder.decode(NL80211TriggerScanStatus.self, from: message)
                
                XCTAssertEqual(value.wiphy, 1)
                XCTAssertEqual(value.interface, 4)
                XCTAssertEqual(value.wirelessDevice, 4294967297)
                XCTAssertEqual(value.scanSSIDs, [])
                XCTAssertEqual(value.scanFrequencies, [
                    2412,
                    2417,
                    2422,
                    2427,
                    2432,
                    2437,
                    2442,
                    2447,
                    2452,
                    2457,
                    2462,
                    2467,
                    2472
                    ])
                
                do {
                    
                    var encoder = NetlinkAttributeEncoder()
                    encoder.log = { print("Encoder:", $0) }
                    
                    let encodedData = try encoder.encode(value)
                    
                    XCTAssertEqual(message.payload.count, encodedData.count)
                    XCTAssertEqual(message.payload, encodedData)
                    
                    do {
                        let decoded = try decoder.decode(NL80211TriggerScanStatus.self, from: encodedData)
                        
                        XCTAssertEqual(decoded.wiphy, 1)
                        XCTAssertEqual(decoded.interface, 4)
                        XCTAssertEqual(decoded.wirelessDevice, 4294967297)
                        XCTAssertEqual(decoded.scanSSIDs, [])
                        XCTAssertEqual(decoded.scanFrequencies, [
                            2412,
                            2417,
                            2422,
                            2427,
                            2432,
                            2437,
                            2442,
                            2447,
                            2452,
                            2457,
                            2462,
                            2467,
                            2472
                            ])
                    }
                        
                    catch { XCTFail("Could not decode: \(error)"); return }
                }
                    
                catch { XCTFail("Could not encode: \(error)"); return }
            }
                
            catch { XCTFail("Could not decode: \(error)"); return }
        }
        
        do {
            
            /**
             Interface: wlx74da3826382c
             Wireless Extension Version: 0
             Wireless Extension Name: IEEE 802.11
             Interface: 8
             Trigger scan:
             */
            
            /**
             ▿ Netlink.NL80211TriggerScanStatus
             - wiphy: 4
             - interface: 8
             - wirelessDevice: 17179869185
             - scanSSIDs: 0 elements
             ▿ scanFrequencies: 13 elements
             - 2412
             - 2417
             - 2422
             - 2427
             - 2432
             - 2437
             - 2442
             - 2447
             - 2452
             - 2457
             - 2462
             - 2467
             - 2472
             */
            
            let data = Data([160, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 1, 0, 0, 8, 0, 1, 0, 4, 0, 0, 0, 8, 0, 3, 0, 8, 0, 0, 0, 12, 0, 153, 0, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 45, 0, 108, 0, 44, 0, 8, 0, 0, 0, 108, 9, 0, 0, 8, 0, 1, 0, 113, 9, 0, 0, 8, 0, 2, 0, 118, 9, 0, 0, 8, 0, 3, 0, 123, 9, 0, 0, 8, 0, 4, 0, 128, 9, 0, 0, 8, 0, 5, 0, 133, 9, 0, 0, 8, 0, 6, 0, 138, 9, 0, 0, 8, 0, 7, 0, 143, 9, 0, 0, 8, 0, 8, 0, 148, 9, 0, 0, 8, 0, 9, 0, 153, 9, 0, 0, 8, 0, 10, 0, 158, 9, 0, 0, 8, 0, 11, 0, 163, 9, 0, 0, 8, 0, 12, 0, 168, 9, 0, 0])
            
            var decoder = NetlinkAttributeDecoder()
            decoder.log = { print("Decoder:", $0) }
            
            // parse response
            guard let messages = try? NetlinkGenericMessage.from(data: data),
                let message = messages.first,
                let attributes = try? decoder.decode(message),
                let wiphyAttribute = attributes.first(where: { $0.type == NetlinkAttributeType.NL80211.wiphy }),
                let wiphy = UInt32(attributeData: wiphyAttribute.payload),
                let interfaceAttribute = attributes.first(where: { $0.type == NetlinkAttributeType.NL80211.interfaceIndex }),
                let interface = UInt32(attributeData: interfaceAttribute.payload)
                else { XCTFail("Could not parse message from data"); return }
            
            XCTAssertEqual(message.data, data)
            XCTAssertEqual(message.length, 160)
            XCTAssertEqual(Int(message.length), data.count)
            XCTAssertEqual(message.type.rawValue, 28) // driver ID
            XCTAssertEqual(message.command.rawValue, NetlinkGenericCommand.NL80211.newScanResults.rawValue)
            XCTAssertEqual(message.version.rawValue, 1)
            XCTAssertEqual(message.flags, 0)
            XCTAssertEqual(message.sequence, 0)
            
            XCTAssertEqual(wiphy, 4)
            XCTAssertEqual(interface, 8)
            
            do {
                let value = try decoder.decode(NL80211TriggerScanStatus.self, from: message)
                
                XCTAssertEqual(value.wiphy, 4)
                XCTAssertEqual(value.interface, 8)
                XCTAssertEqual(value.wirelessDevice, 17179869185)
                XCTAssertEqual(value.scanSSIDs, [])
                XCTAssertEqual(value.scanFrequencies, [
                    2412,
                    2417,
                    2422,
                    2427,
                    2432,
                    2437,
                    2442,
                    2447,
                    2452,
                    2457,
                    2462,
                    2467,
                    2472
                    ])
            }
                
            catch { XCTFail("Could not decode: \(error)"); return }
        }
    }
    
    func testScanData() {
        
        /**
         NL80211_CMD_TRIGGER_SCAN sent 36 bytes to the kernel.
         Waiting for scan to complete...
         Got 33.
         Got NL80211_CMD_NEW_SCAN_RESULTS.
         Scan is done.
         NL80211_CMD_GET_SCAN sent 28 bytes to the kernel.
         callback_dump
         0x58, 0x01, 0x00, 0x00, 0x1C, 0x00, 0x02, 0x00, 0xB1, 0x5B, 0x5E, 0x5B, 0x2F, 0x4E, 0x00, 0xC1, 0x22, 0x01, 0x00, 0x00, 0x08, 0x00, 0x2E, 0x00, 0xCA, 0x05, 0x00, 0x00, 0x08, 0x00, 0x03, 0x00, 0x05, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x99, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x28, 0x01, 0x2F, 0x00, 0x0A, 0x00, 0x01, 0x00, 0x18, 0xA6, 0xF7, 0x99, 0x81, 0x90, 0x00, 0x00, 0x04, 0x00, 0x0E, 0x00, 0x0C, 0x00, 0x03, 0x00, 0x05, 0xD2, 0x98, 0x43, 0x00, 0x00, 0x00, 0x00, 0x61, 0x00, 0x06, 0x00, 0x00, 0x0A, 0x43, 0x4F, 0x4C, 0x45, 0x4D, 0x41, 0x4E, 0x43, 0x44, 0x41, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x0C, 0x12, 0x18, 0x24, 0x03, 0x01, 0x02, 0x2A, 0x01, 0x00, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x00, 0x00, 0x32, 0x04, 0x30, 0x48, 0x60, 0x6C, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0xDD, 0x09, 0x00, 0x03, 0x7F, 0x01, 0x01, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x80, 0xB1, 0x98, 0x43, 0x00, 0x00, 0x00, 0x00, 0x67, 0x00, 0x0B, 0x00, 0x00, 0x0A, 0x43, 0x4F, 0x4C, 0x45, 0x4D, 0x41, 0x4E, 0x43, 0x44, 0x41, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x0C, 0x12, 0x18, 0x24, 0x03, 0x01, 0x02, 0x05, 0x04, 0x00, 0x01, 0x00, 0x80, 0x2A, 0x01, 0x00, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x00, 0x00, 0x32, 0x04, 0x30, 0x48, 0x60, 0x6C, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0xDD, 0x09, 0x00, 0x03, 0x7F, 0x01, 0x01, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x06, 0x00, 0x04, 0x00, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x00, 0x31, 0x04, 0x00, 0x00, 0x08, 0x00, 0x02, 0x00, 0x71, 0x09, 0x00, 0x00, 0x08, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x0A, 0x00, 0x70, 0x03, 0x00, 0x00, 0x08, 0x00, 0x07, 0x00, 0xD0, 0xEE, 0xFF, 0xFF,
         18:a6:f7:99:81:90, 2417 MHz, COLEMANCDA
         callback_dump
         0x34, 0x02, 0x00, 0x00, 0x1C, 0x00, 0x02, 0x00, 0xB1, 0x5B, 0x5E, 0x5B, 0x2F, 0x4E, 0x00, 0xC1, 0x22, 0x01, 0x00, 0x00, 0x08, 0x00, 0x2E, 0x00, 0xCA, 0x05, 0x00, 0x00, 0x08, 0x00, 0x03, 0x00, 0x05, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x99, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x04, 0x02, 0x2F, 0x00, 0x0A, 0x00, 0x01, 0x00, 0x7A, 0xE2, 0x8F, 0x7C, 0x0B, 0xB2, 0x00, 0x00, 0x04, 0x00, 0x0E, 0x00, 0x0C, 0x00, 0x03, 0x00, 0xCC, 0x48, 0x4C, 0x4C, 0x00, 0x00, 0x00, 0x00, 0xCF, 0x00, 0x06, 0x00, 0x00, 0x1F, 0x41, 0x6C, 0x73, 0x65, 0x79, 0x20, 0x43, 0x6F, 0x6C, 0x65, 0x6D, 0x61, 0x6E, 0x20, 0x4D, 0x69, 0x6C, 0x6C, 0x65, 0x72, 0xE2, 0x80, 0x99, 0x73, 0x20, 0x69, 0x50, 0x68, 0x6F, 0x6E, 0x65, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x24, 0x30, 0x48, 0x6C, 0x03, 0x01, 0x06, 0x20, 0x01, 0x00, 0x23, 0x02, 0x11, 0x00, 0x2A, 0x01, 0x04, 0x32, 0x04, 0x0C, 0x12, 0x18, 0x60, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x04, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x04, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x0C, 0x00, 0x2D, 0x1A, 0x21, 0x00, 0x17, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3D, 0x16, 0x06, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0x01, 0x04, 0xDD, 0x0A, 0x00, 0x17, 0xF2, 0x06, 0x01, 0x01, 0x03, 0x01, 0x00, 0x00, 0xDD, 0x0D, 0x00, 0x17, 0xF2, 0x06, 0x02, 0x01, 0x06, 0x58, 0xE2, 0x8F, 0x7C, 0x0B, 0xB3, 0xDD, 0x09, 0x00, 0x10, 0x18, 0x02, 0x01, 0x00, 0x1C, 0x00, 0x00, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x89, 0x41, 0x4B, 0x4C, 0x00, 0x00, 0x00, 0x00, 0xD5, 0x00, 0x0B, 0x00, 0x00, 0x1F, 0x41, 0x6C, 0x73, 0x65, 0x79, 0x20, 0x43, 0x6F, 0x6C, 0x65, 0x6D, 0x61, 0x6E, 0x20, 0x4D, 0x69, 0x6C, 0x6C, 0x65, 0x72, 0xE2, 0x80, 0x99, 0x73, 0x20, 0x69, 0x50, 0x68, 0x6F, 0x6E, 0x65, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x24, 0x30, 0x48, 0x6C, 0x03, 0x01, 0x06, 0x05, 0x04, 0x01, 0x03, 0x00, 0x00, 0x20, 0x01, 0x00, 0x23, 0x02, 0x11, 0x00, 0x2A, 0x01, 0x04, 0x32, 0x04, 0x0C, 0x12, 0x18, 0x60, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x04, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x04, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x0C, 0x00, 0x2D, 0x1A, 0x21, 0x00, 0x17, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3D, 0x16, 0x06, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0x01, 0x04, 0xDD, 0x0A, 0x00, 0x17, 0xF2, 0x06, 0x01, 0x01, 0x03, 0x01, 0x00, 0x00, 0xDD, 0x0D, 0x00, 0x17, 0xF2, 0x06, 0x02, 0x01, 0x06, 0x58, 0xE2, 0x8F, 0x7C, 0x0B, 0xB3, 0xDD, 0x09, 0x00, 0x10, 0x18, 0x02, 0x01, 0x00, 0x1C, 0x00, 0x00, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x04, 0x00, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x00, 0x11, 0x15, 0x00, 0x00, 0x08, 0x00, 0x02, 0x00, 0x85, 0x09, 0x00, 0x00, 0x08, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x0A, 0x00, 0x94, 0x01, 0x00, 0x00, 0x08, 0x00, 0x07, 0x00, 0x10, 0xF5, 0xFF, 0xFF, 7a:e2:8f:7c:0b:b2, 2437 MHz, Alsey Coleman Miller\xe2\x80\x99s iPhone
         NL80211_CMD_GET_SCAN received 0 bytes from the kernel.
         */
        
        let data = Data([0x58, 0x01, 0x00, 0x00, 0x1C, 0x00, 0x02, 0x00, 0xB1, 0x5B, 0x5E, 0x5B, 0x2F, 0x4E, 0x00, 0xC1, 0x22, 0x01, 0x00, 0x00, 0x08, 0x00, 0x2E, 0x00, 0xCA, 0x05, 0x00, 0x00, 0x08, 0x00, 0x03, 0x00, 0x05, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x99, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x28, 0x01, 0x2F, 0x00, 0x0A, 0x00, 0x01, 0x00, 0x18, 0xA6, 0xF7, 0x99, 0x81, 0x90, 0x00, 0x00, 0x04, 0x00, 0x0E, 0x00, 0x0C, 0x00, 0x03, 0x00, 0x05, 0xD2, 0x98, 0x43, 0x00, 0x00, 0x00, 0x00, 0x61, 0x00, 0x06, 0x00, 0x00, 0x0A, 0x43, 0x4F, 0x4C, 0x45, 0x4D, 0x41, 0x4E, 0x43, 0x44, 0x41, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x0C, 0x12, 0x18, 0x24, 0x03, 0x01, 0x02, 0x2A, 0x01, 0x00, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x00, 0x00, 0x32, 0x04, 0x30, 0x48, 0x60, 0x6C, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0xDD, 0x09, 0x00, 0x03, 0x7F, 0x01, 0x01, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x80, 0xB1, 0x98, 0x43, 0x00, 0x00, 0x00, 0x00, 0x67, 0x00, 0x0B, 0x00, 0x00, 0x0A, 0x43, 0x4F, 0x4C, 0x45, 0x4D, 0x41, 0x4E, 0x43, 0x44, 0x41, 0x01, 0x08, 0x82, 0x84, 0x8B, 0x96, 0x0C, 0x12, 0x18, 0x24, 0x03, 0x01, 0x02, 0x05, 0x04, 0x00, 0x01, 0x00, 0x80, 0x2A, 0x01, 0x00, 0x30, 0x14, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x01, 0x00, 0x00, 0x0F, 0xAC, 0x02, 0x00, 0x00, 0x32, 0x04, 0x30, 0x48, 0x60, 0x6C, 0xDD, 0x18, 0x00, 0x50, 0xF2, 0x02, 0x01, 0x01, 0x80, 0x00, 0x03, 0xA4, 0x00, 0x00, 0x27, 0xA4, 0x00, 0x00, 0x42, 0x43, 0x5E, 0x00, 0x62, 0x32, 0x2F, 0x00, 0xDD, 0x09, 0x00, 0x03, 0x7F, 0x01, 0x01, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x06, 0x00, 0x04, 0x00, 0x64, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x00, 0x31, 0x04, 0x00, 0x00, 0x08, 0x00, 0x02, 0x00, 0x71, 0x09, 0x00, 0x00, 0x08, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x0A, 0x00, 0x70, 0x03, 0x00, 0x00, 0x08, 0x00, 0x07, 0x00, 0xD0, 0xEE, 0xFF, 0xFF])
        
        var decoder = NetlinkAttributeDecoder()
        decoder.log = { print("Decoder:", $0) }
        
        // parse response
        guard let message = NetlinkGenericMessage(data: data),
            let attributes = try? decoder.decode(message.payload),
            let interfaceAttribute = attributes.first(where: { $0.type == NetlinkAttributeType.NL80211.interfaceIndex }),
            let interface = UInt32(attributeData: interfaceAttribute.payload)
            else { XCTFail("Could not parse message from data"); return }
        
        XCTAssertEqual(message.data, data)
        XCTAssertEqual(message.length, 344)
        XCTAssertEqual(Int(message.length), data.count)
        XCTAssertEqual(message.type.rawValue, 28) // driver ID
        XCTAssertEqual(message.command.rawValue, NetlinkGenericCommand.NL80211.newScanResults.rawValue)
        XCTAssertEqual(message.version.rawValue, 1)
        XCTAssertEqual(message.flags, 2)
        XCTAssertEqual(message.sequence, 1532910513)
        XCTAssertEqual(interface, 5)
        
        do {
            let value = try decoder.decode(NL80211ScanResult.self, from: message)
            XCTAssertEqual(value.interface, 5)
            XCTAssertEqual(value.generation, 1482)
            XCTAssertEqual(value.wirelessDevice, 0x0100000001)
            XCTAssertEqual(value.bss.bssid.description, "18:A6:F7:99:81:90")
            
            // ssid name
            let ssidLength = min(Int(value.bss.informationElements[1]), 32)
            XCTAssertEqual(String(data: Data(value.bss.informationElements[2 ..< 2 + ssidLength]), encoding: .utf8), "COLEMANCDA")
        }
        
        catch { XCTFail("Could not decode: \(error)"); return }
    }
}
