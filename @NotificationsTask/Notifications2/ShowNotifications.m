//
//  ShowNotifications.m
//  Notifications2
//
//  Created by Dimaka on 4/30/15.
//  Copyright (c) 2015 Dimaka. All rights reserved.
//

#import "ShowNotifications.h"

@interface ShowNotifications ()

@end

@implementation ShowNotifications

static CGFloat normalNotificationCellHeigth;
static CGFloat noMessageNotificationCellHeigth;
static CGFloat longMessageNotificationCellHeigth;
static NSInteger symbolsOnALine = 45;
static NSString* noMessage = @"NoMessageNotificationCell";
static NSString* normalCell = @"NotificationCell";
static NSString* longMessage = @"LongMessageNotificationCell";

-(instancetype) init {
    self = [super init];
    if(self) {
        [[getInformation alloc] init];
        normalNotificationCellHeigth = [[UIScreen mainScreen] bounds].size.height / 8;
        noMessageNotificationCellHeigth = 2*normalNotificationCellHeigth/3;
        longMessageNotificationCellHeigth = 4*normalNotificationCellHeigth/3;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:@"NotificationCell"];
    [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:@"NoMessageNotificationCell"];
    [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:@"LongMessageNotificationCell"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(update:) name:@"Notification" object:nil];
    [self.navigationItem setTitle:@"Notifications"];
}

-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) update:(NSNotification*) note {
    [[AllNotifications sharedAllNotifications] addNotification:note.userInfo[@"info"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AllNotifications sharedAllNotifications].numberOfNotificatios;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellId = normalCell;
    if([[self messageForIndex:indexPath.row] length] >symbolsOnALine)
        cellId = longMessage;
    if([[self messageForIndex:indexPath.row] isEqualToString:@""])
        cellId = noMessage;
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //Setting a cell
    
    CGFloat h = noMessageNotificationCellHeigth - 10;
    cell.userImage.layer.cornerRadius = h/2;
    cell.userImage.clipsToBounds = YES;
    cell.userName.textColor = [UIColor blueColor];
    cell.notificationInfo.textColor = [UIColor colorWithRed:0 green:0 blue:120 alpha:0.7];
    [cell.message setNumberOfLines:0];
    cell.time.textColor = [UIColor grayColor];
    cell.userName.adjustsFontSizeToFitWidth = YES;
    cell.notificationInfo.adjustsFontSizeToFitWidth = YES;
    cell.message.adjustsFontSizeToFitWidth = YES;
    cell.time.adjustsFontSizeToFitWidth = YES;
    
    cell.notificationInfo.text = [self notificationInfoForIndex:indexPath.row];
    NSString* username = [self usernameForIndex:indexPath.row];
    NSMutableAttributedString* attUserName = [[NSMutableAttributedString alloc] initWithString:username];
    NSRange range = [username rangeOfString:@" and "];
    [attUserName addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    cell.userName.attributedText = attUserName;
    cell.message.text = [self messageForIndex:indexPath.row];
    cell.notificationImage.image = [self notificationImageForIndex:indexPath.row];
    cell.userImage.image = [self imageForIndex:indexPath.row];
    cell.clock.image = [UIImage imageNamed:@"icon-time.png"];
    cell.time.text = [self timeForIndex:indexPath.row];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self messageForIndex:indexPath.row] isEqualToString:@""])
        return noMessageNotificationCellHeigth;
    if([[self messageForIndex:indexPath.row] length] > symbolsOnALine)
        return longMessageNotificationCellHeigth;
    return normalNotificationCellHeigth;
}

-(NSString*) notificationInfoForIndex : (NSInteger) index {
    Notification* n = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    if([n.notificationEvent isEqualToString:@"My post"] || [n.notificationEvent isEqualToString:@"My photo"]) {
        return n.notificationTypeText;
    }
    NSString* str = [NSString stringWithFormat:@"%@ %@",n.notificationTypeText,n.notificationEvent];
    return str;
}
-(NSString*) usernameForIndex : (NSInteger) index {
    Notification* a = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    if(([a.notificationTypeText isEqualToString:@"liked your post"] || [a.notificationTypeText isEqualToString:@"liked your photo"]) && a.likes > 1) {
        return [NSString stringWithFormat:@"%@ and %ld others",((User*)[a.users objectAtIndex:0]).name,a.likes - 1];
    }
    return ((User*)[a.users objectAtIndex:0]).name;
}
-(NSString*) messageForIndex : (NSInteger) index {
    Notification* a = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    return a.message;
}
-(UIImage*) imageForIndex : (NSInteger) index {
    Notification* a = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    if(a.likes > 1 && ([a.notificationTypeText isEqualToString:@"liked your photo"] || [a.notificationTypeText isEqualToString:@"liked your post"])) {
        return [UIImage imageNamed:@"avatar.png"];
    }
    else {
        NSString* p  = ((User*)[a.users objectAtIndex:0]).avatar;
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:p]];
        return [UIImage imageWithData:data];
    }
}
-(UIImage*) notificationImageForIndex : (NSInteger) index {
    Notification* a = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    if([a.notificationTypeText isEqualToString:@"liked your photo"] || [a.notificationTypeText isEqualToString:@"liked your post"])
        return [UIImage imageNamed:@"icon-notifications-like.png"];
    if([a.notificationTypeText isEqualToString:@"following you"])
        return [UIImage imageNamed:@"icon-notifications-large.png"];
    return [UIImage imageNamed:@"icon-notifications-comment.png"];
}
-(NSString*) timeForIndex: (NSInteger) index {
    Notification* a = [[AllNotifications sharedAllNotifications] notificationForIndex:index];
    return [Notification timeFrom:[a date]];
}

@end
