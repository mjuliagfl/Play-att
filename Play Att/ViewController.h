//
//  ViewController.h
//  Play Att
//
//  Created by Mateus Fernandes Correia on 28/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray* tasksList;
@property NSMutableArray* switchStates;
@property NSMutableArray* selectedTasksList;

@property (weak, nonatomic) IBOutlet UITableView *tableTasks;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

