//
//  UserCell.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "UserCell.h"

@interface UserCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *useremailLabel;

@end


@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
    self.userImageView.layer.cornerRadius = CGRectGetWidth(self.userImageView.bounds)/2;
    self.userImageView.layer.masksToBounds = YES;
}

- (void) configureCellWithUser:(User *) user {

  //  [self.userImageView setImageWithURl:user.imageUrl placeHolderimage:nil];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.imageUrl] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.useremailLabel.text = user.emailId;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    
}

- (void) prepareForReuse {
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

