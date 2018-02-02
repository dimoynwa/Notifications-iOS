//
//  AllNotifications.m
//  Notification
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "AllNotifications.h"

@interface AllNotifications ()

@property(readwrite) NSMutableArray* allNotifications;

@end

@implementation AllNotifications

static BOOL isInited = NO;

-(instancetype) init {
    if(isInited) {
        return self;
    }
    self = [super init];
    if(self) {
        self.allNotifications = [NSMutableArray array];
        isInited = YES;
    }
    return self;
}

+(instancetype) sharedAllNotifications {
    static AllNotifications* instanse = nil;
    if(!instanse) {
        instanse = [[super alloc] init];
    }
    return instanse;
}

+(instancetype)alloc {
    return [AllNotifications sharedAllNotifications];
}

-(id)copy {
    return [AllNotifications sharedAllNotifications];
}

-(id)mutableCopy {
    return [AllNotifications sharedAllNotifications];
}

-(void) addNotification : (Notification*) notification {
    if(notification && ![self.allNotifications containsObject:notification]) {
        [self.allNotifications addObject:notification];
    }
}

-(NSInteger) numberOfNotificatios {
    return [self.allNotifications count];
}

-(Notification*) notificationForIndex:(NSInteger)index {
    return [self.allNotifications objectAtIndex:index];
}

@end
