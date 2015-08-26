//
//  Configuration.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoadingViewTag 766633

/**
 *  API Urls
 *
 *  @return API Urls for  api calls
 */

#define kUserListAPIURL @"list"

@interface Configuration : NSObject

extern NSString * apiBaseUrl;
extern NSString * genericMessage;
@end


