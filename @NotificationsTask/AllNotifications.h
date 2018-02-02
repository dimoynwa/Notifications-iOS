//
//  AllNotifications.h
//  Notification
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

@interface AllNotifications : NSObject

-(void) addNotification : (Notification*) notification;
+(instancetype) sharedAllNotifications;

-(NSInteger) numberOfNotificatios;
-(Notification*) notificationForIndex : (NSInteger) index;

@end
