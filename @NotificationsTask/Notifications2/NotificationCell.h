//
//  NotificationCell.h
//  Notifications2
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
{
    NSString* reuseID;
}
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *notificationInfo;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UIImageView *notificationImage;
@property (strong, nonatomic) IBOutlet UIImageView *clock;
@property (strong, nonatomic) IBOutlet UILabel *time;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
