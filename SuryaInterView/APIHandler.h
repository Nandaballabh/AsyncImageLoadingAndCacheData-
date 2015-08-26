//
//  APIHandler.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configuration.h"
#import "HelperMethod.h"
#import "User.h"

@interface APIHandler : NSObject

@property (strong , nonatomic) NSString * emailId ;
/**
 *  Singleton object
 *
 *  @return instance object of this class
 */

+ (instancetype) instance;


/**
 *  Get users details with email id
 *
 *  @param email   email address
 *  @param success API success block
 *  @param failure API failure block
 */


- (void) usersWithEmail:(NSString *)email successBlock:(void (^) (id responseObject))success failureBlock:(void (^) (NSError *error))failure;

@end
