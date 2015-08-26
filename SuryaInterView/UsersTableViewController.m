//
//  UsersTableViewController.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UserCell.h"

@interface UsersTableViewController ()

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Users";
    if(self.needUserDataRefresh) {
        [self updateUserList];
    }
}

- (void)updateUserList {
   
    [[APIHandler instance] usersWithEmail:[APIHandler instance].emailId successBlock:^(id responseObject) {
        
        self.Users = (NSArray *)responseObject;
        [self.tableView reloadData];
    } failureBlock:^(NSError * error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.Users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCell *cell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:@"UsersCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell configureCellWithUser:self.Users[indexPath.row]];
    return cell;
}


@end
