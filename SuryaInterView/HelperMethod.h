//
//  HelperMethod.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface HelperMethod : NSObject

+(BOOL)validateEmail:(NSString *)email;

+ (void) showLoadingView;

+ (void) dismiss;

+ (void) showAlertWithError:(NSError *) error;

+ (NSDictionary *) paramsForUserListWithEmail:(NSString *) email;

+ (NSError *) genericError;

+ (NSError *) errorFromString:(NSString *) message;

+ (void) saveTheUserList:(NSData *) responseData;

+ (NSDictionary *) getLocalUserList;

@end
