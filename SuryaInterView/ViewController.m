//
//  ViewController.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/25/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "ViewController.h"
#import "HelperMethod.h"
#import "UsersTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailTextField becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark UITextFieldDelegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self getUsersListWithEmail:textField.text];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    textField.layer.borderColor = [UIColor clearColor].CGColor;
    return YES;
}

- (void)getUsersListWithEmail:(NSString *) email {
 
    NSString * trimedEmail = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([HelperMethod validateEmail:trimedEmail]) {
        
        [self.emailTextField resignFirstResponder];
        [self checkLocalDataAndGetUserList:trimedEmail];
    } else {
        
        self.emailTextField.layer.borderWidth = 1.0f;
        self.emailTextField.layer.cornerRadius = 7.0f;
        self.emailTextField.layer.borderColor = [UIColor redColor].CGColor;
    }
}

- (void) checkLocalDataAndGetUserList:(NSString *)email {
    
    [APIHandler instance].emailId = email;
    NSDictionary * savedDict = [HelperMethod getLocalUserList];
    NSArray * items = savedDict[@"items"];
    NSMutableArray * userList = [NSMutableArray new];
    for (NSDictionary * dictionary in items) {
        User * user = [User instanceWithDictionary:dictionary];
        if(user)
            [userList addObject:user];
    }
   
    if(userList.count > 0) {
        
        [self showUsersViewWith:userList andNeedRefresh:YES];
        
    } else {
        
        [HelperMethod showLoadingView];
        
        [[APIHandler instance] usersWithEmail:email successBlock:^(id responseObject) {
            
            [HelperMethod dismiss];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showUsersViewWith:(NSArray*)responseObject andNeedRefresh:NO];
            });
            
        } failureBlock:^(NSError * error) {
            
            [HelperMethod dismiss];
            [HelperMethod showAlertWithError:error];
            
        }];
    }

}

- (void) showUsersViewWith:(NSArray *)users andNeedRefresh:(BOOL) refresh {
   
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UsersTableViewController * usersTableViewController = [storyBoard instantiateViewControllerWithIdentifier:@"UsersVIewSrorybradID"];
    usersTableViewController.Users = users;
    usersTableViewController.needUserDataRefresh = refresh;
    [self.navigationController pushViewController:usersTableViewController animated:YES];
   
}

@end
