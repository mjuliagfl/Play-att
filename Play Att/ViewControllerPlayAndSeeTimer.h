//
//  ViewControllerPlayAndSeeTimer.h
//  Play Att
//
//  Created by vinicius emanuel on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Foundation/Foundation.h>
#import "Task.h"
#import <Parse/Parse.h>
#import "ViewController.h"

@interface ViewControllerPlayAndSeeTimer : UIViewController
{
    MPMusicPlayerController *musicPlayer;
    MPMediaItemCollection *collection;
}

@property NSMutableArray *SongsToPlay;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;
@property (weak, nonatomic) IBOutlet UIButton *EndActiPutton;
@property (weak, nonatomic) IBOutlet UIButton *ArregoButton;

@property (weak, nonatomic) IBOutlet UILabel *tempo;
@property (weak, nonatomic) IBOutlet UILabel *qualatividade;
@property (weak, nonatomic) IBOutlet UILabel *musicname;

@property NSMutableArray* selectedTasksList;

@property NSInteger MinutsToNextTask;
@property NSInteger Index;
@property NSMutableArray* tasksList;

- (void)updateTime;

@end
