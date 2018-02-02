//
//  getInformation.m
//  Notification
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "getInformation.h"


@implementation getInformation

-(instancetype)init {
    self = [super init];
    if(self) {
        NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youlocalapp.com/api/notifications/load/?largeScreen&token=f2908658dc92d32a491d2e5b30aad86e"]];
        
        NSURLSessionDataTask* downloadJSONTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSError* err = nil;
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&err];
            
            if (err != nil) {
                NSLog(@"Error : %@", [err localizedDescription]);
            }
            else {
                NSArray* items = [json objectForKey:@"notifications"];
                for (NSDictionary* item in items) {
                    
                    NSString* notificationType = item[@"notificationType"];
                    NSString* notificationTypeText = item[@"notificationTypeText"];
                    NSString* message = item[@"message"];
                    NSString* date = item[@"notificationDate"];
                    NSString* event = item[@"notificationEvent"];
                    NSString* likesS = item[@"likes"];
                    NSInteger likes = [likesS integerValue];
                    Notification* info = [[Notification alloc] initWithNotificationType:notificationType andNotificationTypeText:notificationTypeText andMessage:message andDate:date andNotificationEvent:event andLkes:likes];
                    for(NSDictionary* user in item[@"users"]) {
                        
                        NSString* name = user[@"fullname"];
                        NSString* avatar = user[@"avatar_50"];
                        User* u = [[User alloc] initWithName:name andAvatar:avatar];
                        [info addUser:u];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification" object:self userInfo:[NSDictionary dictionaryWithObjects:@[info] forKeys:@[@"info"]]];
                }
            }
            
            
        }];
        [downloadJSONTask resume];
    }
    return self;
}

@end
