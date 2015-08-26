//
//  UserCell.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UIImageView+Addition.h"
#import "UIImageView+WebCache.h"

@interface UserCell : UITableViewCell

- (void) configureCellWithUser:(User *) user;

@end
