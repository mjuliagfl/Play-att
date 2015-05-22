//
//  ViewControllerParabens.h
//  Play Att
//
//  Created by vinicius emanuel on 03/05/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface ViewControllerParabens : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *tempo;
@property (weak, nonatomic) IBOutlet UITableView *tablevoew;
@property (weak, nonatomic) IBOutlet UIButton *agora;

@property NSMutableArray* selectedTasksList;
@property NSMutableArray *SongsToPlay;

@end
