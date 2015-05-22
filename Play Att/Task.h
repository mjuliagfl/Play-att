//
//  Task.h
//  Play Att
//
//  Created by Maria Julia Godoy on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

//defining class attributes

@property NSString* name;
@property NSDateComponents* time;
@property BOOL status;


//init method signature

-(id) initWithName: (NSString *) name
                Time: (NSDateComponents *) time
                Status: (BOOL) status;


@end
