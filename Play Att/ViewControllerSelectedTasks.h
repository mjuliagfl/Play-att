//
//  ViewControllerSelectedTasks.h
//  Play Att
//
//  Created by Maria Julia Godoy on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSelectedTasks : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property NSMutableArray* selectedTasksList;
@property NSMutableArray* tasksList;
@end
