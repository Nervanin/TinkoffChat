//
//  MultipeerCommunicator.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class MultipeerCommunicator: NSObject, Communicator {
    
    
    var delegate: CommunicatorDelegate?
    var online: Bool
    var sessions: [String: MCSession] = [String: MCSession]()
    
    lazy var session : MCSession = {
        let session = MCSession(peer: selfPeerID)
        session.delegate = self
        return session
    }()
    
    let serviceType = "tinkoff-chat"
    let advertiserService : MCNearbyServiceAdvertiser
    let browserService : MCNearbyServiceBrowser
    let selfPeerID : MCPeerID = MCPeerID(displayName: UIDevice.current.name)
    let discoveryInfo = ["userName": "KonstanTEEn"]
    
    init(delegate: CommunicatorDelegate) {
        advertiserService = MCNearbyServiceAdvertiser(peer: selfPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
        browserService = MCNearbyServiceBrowser(peer: selfPeerID, serviceType: serviceType)
        online = true
        super.init()
        
        self.delegate = delegate
        browserService.delegate = self
        advertiserService.delegate = self
        browserService.startBrowsingForPeers()
        advertiserService.startAdvertisingPeer()
        
    }
    
    deinit {
        advertiserService.stopAdvertisingPeer()
        browserService.stopBrowsingForPeers()
    }
    
    func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX)) + \(Date.timeIntervalSinceReferenceDate) + \(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
    
    func sendMessage(string: String, to userId: String, competionandler: ((Bool, Error?) -> ())?) {
        let sendMessage = ["eventType": "TextMessage", "messageId": generateMessageId(), "text": string]
        
        do {
            let json = try JSONSerialization.data(withJSONObject: sendMessage, options: .prettyPrinted)
            if let session = sessions[userId] {
                try session.send(json, toPeers: session.connectedPeers, with: .reliable)
            }
        } catch {
            print(error)
            competionandler!(false, error)
        }
        competionandler!(true, nil)
    }
    
}

extension MultipeerCommunicator: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .connected {
            print("\(peerID) connected")
        } else {
            print("\(peerID) not connected")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            delegate?.didReceiveMessage(text: json["text"] as! String, fromUser: peerID.displayName, toUser: selfPeerID.displayName)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    
}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        var session = sessions[peerID.displayName]
        
        if session == nil {
            session = MCSession(peer: selfPeerID, securityIdentity: nil, encryptionPreference: .none)
            session?.delegate = self
            sessions[peerID.displayName] = session
        }
        invitationHandler(true, session)
    }
    
    
    
}



extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        guard peerID.displayName != selfPeerID.displayName else {
            return
        }

        guard let userInfo = info else {
            return
        }
//
        guard let userName = userInfo["userName"] else {
            return
        }
        
        var session = sessions[peerID.displayName]
        if session != nil {
            session = MCSession(peer: selfPeerID, securityIdentity: nil, encryptionPreference: .none)
            session?.delegate = self
            sessions[peerID.displayName] = session
        }
        
        browser.invitePeer(peerID, to: session!, withContext: nil, timeout: 60.0)
        delegate?.didFoundUser(userID: peerID.displayName, userName: userName)
        
        
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
    }
    
    
}
