//
//  ChatController.swift
//  houzie
//
//  Created by Abdurrosyid Handoyo on 2/10/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import UIKit

class ChatController: JSQMessagesViewController {
    
    // MARK: Variable declaration
    
    let messageData: NSMutableArray = []
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    let senderAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "avatar.png"), diameter: 30)
    let botId = "90283-412412-41"
    let botDisplayName = "Roomtech Bot"
    let botAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "bot.png"), diameter: 30)
    
    // MARK: View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Houzie"
        
        self.senderId = "053496-4509-289"
        self.senderDisplayName = "Handoyo"
        self.showLoadEarlierMessagesHeader = true
        
        initMessageData()
    }
    
    // MARK: Initialization
    
    func initMessageData() {
        self.messageData.addObject(JSQMessage(
            senderId: self.senderId,
            senderDisplayName: self.senderDisplayName,
            date: NSDate.distantPast(),
            text: "!smarthome get temperature"
            )
        )
        self.messageData.addObject(JSQMessage(
            senderId: self.botId,
            senderDisplayName: self.botDisplayName,
            date: NSDate.distantPast(),
            text: "Current Temperature is 28.59°C"
            )
        )
    }
    
    // MARK: JSQMessagesViewController method overrides
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        self.messageData.addObject(JSQMessage(
            senderId: senderId,
            senderDisplayName: senderDisplayName,
            date: date,
            text: text
            )
        )
        
        self.finishSendingMessageAnimated(true)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    // Mark: JSQMessagesCollectionView data source
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messageData[indexPath.row] as! JSQMessageData
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messageData.removeObjectAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messageData[indexPath.row]
        switch(message.senderId()) {
            case self.senderId:
                return self.outgoingBubble
            default:
                return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.messageData[indexPath.row]
        switch(message.senderId()) {
            case self.senderId:
                return self.senderAvatar
            default:
                return self.botAvatar
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = self.messageData[indexPath.row]
        return NSAttributedString(string: message.senderDisplayName())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = self.messageData[indexPath.row]
        
        return NSAttributedString(string: message.senderDisplayName())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = self.messageData[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return NSAttributedString(string: dateFormatter.stringFromDate(message.date!!))
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messageData.count
    }
}
