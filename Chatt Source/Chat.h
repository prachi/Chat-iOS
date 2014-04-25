//
//  Chat.h
//  Chat Template
//
//  Created by Guest-admin on 4/17/14.
//  Copyright (c) 2014 Xin ZhangZhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Chat : NSManagedObject

@property (nonatomic, retain) NSNumber * groupId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * timestamp;

@end
