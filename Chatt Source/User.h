//
//  User.h
//  Chat Template
//
//  Created by Guest-admin on 4/17/14.
//  Copyright (c) 2014 Xin ZhangZhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSData * friends;

@end
