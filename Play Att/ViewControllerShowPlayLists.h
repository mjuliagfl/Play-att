//
//  ViewController.h
//  Play Att
//
//  Created by vinicius emanuel on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerShowPlayLists : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *TableViewPlayLists;

@property NSMutableArray *NamesOfPlayLists;

@property NSMutableArray *SongsToPlay;

@property NSMutableArray* selectedTasksList;

@property NSMutableArray* switchStates;
@property NSMutableArray* selectedPlaylistsList;

@end
