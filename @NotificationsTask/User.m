//
//  User.m
//  Notifications2
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "User.h"

@interface User ()

@property(readwrite) NSString* name;
@property(readwrite) NSString* avatar;

@end

@implementation User


-(instancetype) initWithName:(NSString *)name andAvatar:(NSString *)avatar {
    self = [super init];
    if(self) {
        self.name = name;
        self.avatar = avatar;
    }
    return self;
}

@end
