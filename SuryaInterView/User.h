//
//  User.h
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong , nonatomic) NSString * emailId;
@property (strong , nonatomic) NSString * imageUrl;
@property (strong , nonatomic) NSString * firstName;
@property (strong , nonatomic) NSString * lastName;

+ (instancetype) instanceWithDictionary:(NSDictionary *)dictionary;

@end
