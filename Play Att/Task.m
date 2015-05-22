//
//  Task.m
//  Play Att
//
//  Created by Maria Julia Godoy on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "Task.h"

@implementation Task

//implementation of the init method
-(id) initWithName: (NSString *) name
           Details: (NSString * ) details
              Time: (NSDateComponents *) time
            Status: (BOOL) status
{
    
    if(self = [super init]){
        _name = name;
        _details = details;
        _time = time;
        _status = status;
        
        
    }
    
    return self;
    
}

@end
