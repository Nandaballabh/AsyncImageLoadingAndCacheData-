

//
//  HelperMethod.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "HelperMethod.h"
#import "Configuration.h"

@implementation HelperMethod

+ (BOOL)validateEmail:(NSString *)email {
    
    if(email.length == 0)
        return NO;
    NSString *emailRegex = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (void) showLoadingView {
  
    UIView * backGroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.45f];
    backGroundView.tag = kLoadingViewTag;
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = backGroundView.center;
    activityIndicator.hidesWhenStopped = YES;
    [backGroundView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow addSubview:backGroundView];
        });
    } completion:^(BOOL finished) {
        
    }];
}

+ (void) dismiss {
   
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView * backGroundView = [[UIApplication sharedApplication].keyWindow viewWithTag:kLoadingViewTag];
            [backGroundView removeFromSuperview];
        });
        
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void) showAlertWithError:(NSError *) error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * message = error.localizedDescription;
        [[[UIAlertView alloc] initWithTitle:@"" message:message.length ? message :NSLocalizedString(@"genericError.Message", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    });
}

+ (NSDictionary *) paramsForUserListWithEmail:(NSString *) email {
   
    return @{@"emailId":email};
    
}

+ (NSError *) genericError {
    
    return [NSError errorWithDomain:@"com.nandaballabh.suryainterView" code:0 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"genericError.Message", @"")}];
}

+ (NSError *) errorFromString:(NSString *) message {
    return [NSError errorWithDomain:@"com.nandaballabh.suryainterView" code:0 userInfo:@{NSLocalizedDescriptionKey:message.length ? message :NSLocalizedString(@"genericError.Message", @"")}];
}

+ (void) saveTheUserList:(NSData *) responseData {
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths.lastObject stringByAppendingPathExtension:@"usersList.json"];
    [responseData writeToFile:filePath atomically:YES];
}

+ (NSDictionary *) getLocalUserList {
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths.lastObject stringByAppendingPathExtension:@"usersList.json"];
    NSData * savedData = [[NSData alloc]initWithContentsOfFile:filePath];
    if(savedData) {
        NSError * error = nil;
        NSDictionary * savedDict = [NSJSONSerialization JSONObjectWithData:savedData options:0 error:&error];
        if(savedDict) {
            return savedDict;
        }
        return nil;
    }
    return nil;
}
@end

