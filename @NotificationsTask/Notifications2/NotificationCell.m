//
//  NotificationCell.m
//  Notifications2
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

@synthesize userImage;
@synthesize userName;
@synthesize notificationInfo;
@synthesize notificationImage;
@synthesize message;
@synthesize time;
@synthesize clock;

static NSString* noMessage = @"NoMessageNotificationCell";
static NSString* normalCell = @"NotificationCell";
static NSString* longMessage = @"LongMessageNotificationCell";
static CGFloat normalNotificationCellHeigth;
static CGFloat noMessageNotificationCellHeigth;
static CGFloat longMessageNotificationCellHeigth;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        normalNotificationCellHeigth = [[UIScreen mainScreen] bounds].size.height / 8;
        noMessageNotificationCellHeigth = 2*normalNotificationCellHeigth/3;
        longMessageNotificationCellHeigth = 4*normalNotificationCellHeigth/3;
        
        reuseID = reuseIdentifier;
        userName = [[UILabel alloc] init];
        [userName setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        userImage = [[UIImageView alloc] init];
        [userImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        notificationImage = [[UIImageView alloc] init];
        [notificationImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        notificationInfo = [[UILabel alloc] init];
        [notificationInfo setTranslatesAutoresizingMaskIntoConstraints:NO];
        message = [[UILabel alloc] init];
        [message setTranslatesAutoresizingMaskIntoConstraints:NO];
        time = [[UILabel alloc] init];
        [time setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        clock = [[UIImageView alloc] init];
        [clock setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:userName];
        [self.contentView addSubview:userImage];
        [self.contentView addSubview:notificationImage];
        [self.contentView addSubview:notificationInfo];
        [self.contentView addSubview:message];
        [self.contentView addSubview:time];
        [self.contentView addSubview:clock];
        
        double forNormal = 5+ (normalNotificationCellHeigth - noMessageNotificationCellHeigth)/2;
        double forLong = 5 + (longMessageNotificationCellHeigth - noMessageNotificationCellHeigth)/2;
        NSNumber* forNormalNumber = [NSNumber numberWithDouble:forNormal];
        NSNumber* forLongNumber = [NSNumber numberWithDouble:forLong];
        
        NSDictionary* views = NSDictionaryOfVariableBindings(userName,userImage,notificationImage,notificationInfo,message,time,clock);
        
        //Setting constraints
        
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[userImage]-5-|" options:0 metrics:nil views:views];
        if([reuseIdentifier isEqualToString:normalCell])
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-forNormal-[userImage]-forNormal-|" options:0 metrics:@{@"forNormal":forNormalNumber} views:views];
        if([reuseIdentifier isEqualToString:longMessage]) {
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-forLong-[userImage]-forLong-|" options:0 metrics:@{@"forLong":forLongNumber} views:views];
        }
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[userImage]-5-[userName]-5-[clock][time]-5-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[userImage]-5-[notificationImage]-5-[notificationInfo]-5-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[userImage]-5-[message]-5-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[userName]-5-[notificationInfo]-5-[message]-5-|" options:0 metrics:nil views:views];
        if([reuseIdentifier isEqualToString:noMessage]) {
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[userName]-5-[notificationInfo]-5-|" options:0 metrics:nil views:views];
            [message removeFromSuperview];
        }
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName(==notificationImage)]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName(==notificationInfo)]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName]-5-[notificationImage]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        //
        if([reuseIdentifier isEqualToString:normalCell]) {
            constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName(==message)]" options:0 metrics:nil views:views];
            [self.contentView addConstraints:constraints];
        }
        if([reuseIdentifier isEqualToString:longMessage]) {
            NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:userName attribute:NSLayoutAttributeHeight multiplier:2.0 constant:0];
            [self.contentView addConstraint:constraint];
        }
        //
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName(==time)]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userName(==clock)]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[time]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[clock]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[time]-5-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraints];
        NSLayoutConstraint* constraints1 = [NSLayoutConstraint constraintWithItem:userImage attribute: NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:userImage attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self.contentView addConstraint:constraints1];
        constraints1 = [NSLayoutConstraint constraintWithItem:notificationImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:notificationImage attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self.contentView addConstraint:constraints1];
        constraints1 = [NSLayoutConstraint constraintWithItem:clock attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:clock attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self.contentView addConstraint:constraints1];
        
        //End of setting constrains

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
