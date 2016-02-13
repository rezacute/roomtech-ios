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
  
    title = "Houzie"
    senderId = "053496-4509-289"
    senderDisplayName = "Handoyo"
    showLoadEarlierMessagesHeader = true
    
    messageData.addObject(
      JSQMessage(
        senderId: senderId,
        senderDisplayName: senderDisplayName,
        date: NSDate.distantPast(),
        text: "!smarthome get temperature"
      )
    )
    messageData.addObject(
      JSQMessage(
        senderId: botId,
        senderDisplayName: botDisplayName,
        date: NSDate.distantPast(),
        text: "Current Temperature is 28.59°C"
      )
    )
  }
  
  // MARK: JSQMessagesViewController method overrides
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    JSQSystemSoundPlayer.jsq_playMessageSentSound()
    
    messageData.addObject(
      JSQMessage(
        senderId: senderId,
        senderDisplayName: senderDisplayName,
        date: date,
        text: text
      )
    )
    
    finishSendingMessageAnimated(true)
  }
  
  override func didPressAccessoryButton(sender: UIButton!) {
    inputToolbar?.contentView?.textView?.resignFirstResponder()
    
    let actionSheetController = UIAlertController(
      title: "Media",
      message: "Send media message",
      preferredStyle: UIAlertControllerStyle.ActionSheet
    )
    actionSheetController.addAction(
      UIAlertAction(
        title: "Image",
        style: UIAlertActionStyle.Default,
        handler: { (UIAlertAction) -> Void in
          let imagePickerController = UIImagePickerController()
          imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
          imagePickerController.allowsEditing = false
          imagePickerController.delegate = self
          self.presentViewController(imagePickerController, animated: true, completion: { () -> Void in
          })
        }
      )
    )
    actionSheetController.addAction(
      UIAlertAction(
        title: "Cancel",
        style: UIAlertActionStyle.Cancel,
        handler: { (UIAlertAction) -> Void in
        }
      )
    )
    presentViewController(actionSheetController, animated: true) { () -> Void in
    }
  }
  
  // MARK: JSQMessagesCollectionView data source
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    return messageData[indexPath.row] as! JSQMessageData
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
    messageData.removeObjectAtIndex(indexPath.row)
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
    let message = messageData[indexPath.row]
    switch(message.senderId()) {
      case senderId:
        return outgoingBubble
      default:
        return incomingBubble
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
    let message = messageData[indexPath.row]
    switch(message.senderId()) {
      case senderId:
        return senderAvatar
      default:
        return botAvatar
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    let message = messageData[indexPath.row]
    return NSAttributedString(string: message.senderDisplayName())
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    let message = messageData[indexPath.row]
    return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    let message = messageData[indexPath.row]
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return NSAttributedString(string: dateFormatter.stringFromDate(message.date!!))
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messageData.count
  }
}

// MARK: UIImagePickerControllerDelegate

extension ChatController: UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    self.dismissViewControllerAnimated(true) { () -> Void in
    }
    
    let imageItem = JSQPhotoMediaItem(image: image)
    let imageMessage = JSQMessage(
      senderId: senderId,
      senderDisplayName: senderDisplayName,
      date: NSDate(),
      media: imageItem
    )
    messageData.addObject(imageMessage)
    collectionView?.reloadData()
  }
}

// MARK: UINavigationControllerDelegate

extension ChatController: UINavigationControllerDelegate {
  
}
