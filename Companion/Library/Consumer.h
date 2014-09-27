//
//  Consumer.h
//  Companion
//
//  Created by Eduardo Antoni Carrillo Albor on 9/27/14.
//  Copyright (c) 2014 Keduardo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@interface Consumer : NSObject
+(instancetype)sharedInstance;

-(void)requestCompanionsAroundCoordinate:(CLLocation*)location completitionBlock:(void (^) (NSArray* companions))completitionBlock;

@end
