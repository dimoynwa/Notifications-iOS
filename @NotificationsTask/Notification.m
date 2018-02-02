//
//  Notification.m
//  Notification
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "Notification.h"

@interface Notification ()

@property(readwrite) NSString* notificationType;
@property(readwrite) NSString* notificationTypeText;
@property(readwrite) NSString* message;
@property(readwrite) NSMutableArray* users;
@property(readwrite) NSString* date;
@property(readwrite) NSString* notificationEvent;
@property(readwrite) NSInteger likes;

@end

@implementation Notification

-(instancetype) initWithNotificationType:(NSString *)notType andNotificationTypeText:(NSString *)notTypeText andMessage:(NSString *)message andDate:(NSString *)date andNotificationEvent : (NSString*) notEvent andLkes:(NSInteger)likes {
    self = [super init];
    if(self) {
        self.notificationType = notType;
        self.notificationTypeText = notTypeText;
        self.message = message;
        self.date = date;
        self.users = [NSMutableArray array];
        self.notificationEvent = notEvent;
        self.likes = likes;
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        self.users = [NSMutableArray array];
    }
    return self;
}

-(void) addUser:(User *)user {
    if(user) {
        [self.users addObject:user];
    }
}

+(NSString*) timeFrom:(NSString *)date {
    NSDateFormatter* form = [[NSDateFormatter alloc] init];
    [form setDateFormat:@"yyyy-MM-dd"];
    NSString* dat = [date substringToIndex:10];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* notDate = [form dateFromString:dat];
    NSDate* currentDate = [NSDate date];
    NSDateComponents* comp = [gregorianCalendar components:NSCalendarUnitDay fromDate:notDate toDate:currentDate options:0];
    NSInteger days = [comp day];
    if(days == 0) {
        [form setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
        notDate = [form dateFromString:date];
        currentDate = [NSDate date];
        NSInteger t = [notDate timeIntervalSinceDate:currentDate];
        if(t < 60)
            return [NSString stringWithFormat:@"%lds",(long)t];
        NSInteger min = t/60;
        if (min < 60)
            return [NSString stringWithFormat:@"%ldm",(long)min];
        NSInteger hours = t/3600;
        return [NSString stringWithFormat:@"%ldh",(long)hours];
    
    }
    if(days < 7)
        return [NSString stringWithFormat:@"%ldd",(long)days];
    NSInteger weeks = days/7;
    if(weeks < 4 || days <= 31)
        return [NSString stringWithFormat:@"%ldw",(long)weeks];
    NSInteger months = days/30;
    return [NSString stringWithFormat:@"%ldm",(long)months];
}

@end
