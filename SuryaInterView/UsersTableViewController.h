//
//  UsersTableViewController.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "APIHandler.h"

@interface UsersTableViewController : UITableViewController

@property (strong , nonatomic) NSArray * Users;
@property (nonatomic ) BOOL  needUserDataRefresh;

@end
