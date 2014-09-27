//
//  Consumer.m
//  Companion
//
//  Created by Eduardo Antoni Carrillo Albor on 9/27/14.
//  Copyright (c) 2014 Keduardo. All rights reserved.
//

#import "Consumer.h"

@implementation Consumer
+(instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

-(void)requestCompanionsAroundCoordinate:(CLLocation *)location completitionBlock:(void (^)(NSArray *))completitionBlock
{
    
}
@end
