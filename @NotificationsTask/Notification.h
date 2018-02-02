//
//  Notification.h
//  Notification
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Notification : NSObject

@property(readonly) NSString* notificationType;
@property(readonly) NSString* notificationTypeText;
@property(readonly) NSString* message;
@property(readonly) NSMutableArray* users;
@property(readonly) NSString* date;
@property(readonly) NSString* notificationEvent;
@property(readonly) NSInteger likes;

-(instancetype) initWithNotificationType:(NSString*) notType andNotificationTypeText : (NSString*) notTypeText andMessage : (NSString*) message andDate : (NSString*) date andNotificationEvent : (NSString*) notEvent andLkes : (NSInteger) likes;
-(void) addUser : (User*) user;

+(NSString*) timeFrom : (NSString*) date;

@end
