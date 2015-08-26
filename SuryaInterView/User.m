//
//  User.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        
        self.emailId = [coder decodeObjectForKey:@"emailId"];
        self.firstName = [coder decodeObjectForKey:@"firstName"];
        self.lastName = [coder decodeObjectForKey:@"lastName"];
        self.imageUrl = [coder decodeObjectForKey:@"imageUrl"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.emailId forKey:@"emailId"];
    [coder encodeObject:self.firstName forKey:@"firstName"];
    [coder encodeObject:self.lastName forKey:@"lastName"];
    [coder encodeObject:self.imageUrl forKey:@"imageUrl"];
}

+ (instancetype) instanceWithDictionary:(NSDictionary *)dictionary {

    User * instance = [[User alloc]init];
    [instance setValuesForKeysWithDictionary:dictionary];
    return instance;
}

- (void) setValuesForKeysWithDictionary:(NSDictionary *)keyedValues {

    if(![keyedValues isKindOfClass:[NSDictionary class]])
        return;
    
    [super setValuesForKeysWithDictionary:keyedValues];
    
}

- (void) setValue:(id)value forKey:(NSString *)key {

    [super setValue:value forKey:key];
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

