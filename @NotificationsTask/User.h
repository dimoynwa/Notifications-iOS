//
//  User.h
//  Notifications2
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(readonly) NSString* name;
@property(readonly) NSString* avatar;

-(instancetype) initWithName : (NSString*) name andAvatar : (NSString*) avatar;

@end
