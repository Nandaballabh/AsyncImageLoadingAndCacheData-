//
//  APIHandler.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "APIHandler.h"

@interface APIHandler()

@property (strong , nonatomic) NSString * apiBaseUrl;

@end

@implementation APIHandler

static APIHandler * _instance = nil;


/**
 *  Singleton object
 *
 *  @return instance object of this class
 */

+ (instancetype) instance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
        _instance.apiBaseUrl = apiBaseUrl;
    });
    return _instance;
}


- (void) sendAsyncRequestWithUrl:(NSString *) urlString method:(NSString*) method params:(id)params successBlock:(void (^) (id responseObject))success failureBlock:(void (^) (id responseObject))failure {
    
    NSString * urlPath = [self.apiBaseUrl stringByAppendingPathComponent:urlString];
    NSURL * url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[self dataFromJsonString:params]];
    NSLog(@"Request:\n%@\n%@",request,request.allHTTPHeaderFields);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(!connectionError) {
          
            if(data) {
                
                NSError * error = nil;
                NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"Response Object : \n%@",responseDict);
                if(!error) {
                
                    NSArray * items = responseDict[@"items"];
                    NSMutableArray * userList = [NSMutableArray new];
                    for (NSDictionary * dictionary in items) {
                        User * user = [User instanceWithDictionary:dictionary];
                        if(user)
                           [userList addObject:user];
                    }
                    
                    // Save data locally
                    [HelperMethod saveTheUserList:data];
                    success (userList);

                } else {
                    
                    NSString * responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"Response string : \n%@",responseString);
                    failure([HelperMethod errorFromString:responseString]);
                }

            } else {
                failure ([HelperMethod genericError]);
            }
            
        } else {
            
            failure(connectionError);
        }
    }];
    
}



/**
 *  Convert parameters  to NSData
 *
 *  @param post parameters
 *
 *  @return post data
 */

- (NSData *)dataFromJsonString:(id ) postParams {
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:postParams
                                                   options:0 // non-pretty printing
                                                     error:&error];
    if(error)
        NSLog(@"JSON Parsing Error: %@", error);
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}


/**
 *  Get users details with email id
 *
 *  @param email   email address
 *  @param success API success block
 *  @param failure API failure block
 */

- (void) usersWithEmail:(NSString *)email successBlock:(void (^) (id responseObject))success failureBlock:(void (^) (NSError *error))failure {
    
    NSDictionary * params = [HelperMethod paramsForUserListWithEmail:email];
    [self sendAsyncRequestWithUrl:kUserListAPIURL method:@"POST" params:params successBlock:success failureBlock:failure];
}

@end
