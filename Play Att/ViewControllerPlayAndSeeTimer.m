//
//  ViewControllerPlayAndSeeTimer.m
//  Play Att
//
//  Created by vinicius emanuel on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewControllerPlayAndSeeTimer.h"
#import "Task.h"
#import <Foundation/Foundation.h>
#import "ViewControllerParabens.h"
#import "ViewControllerVacilo.h"
#import "ViewControllermassafera.h"

@interface ViewControllerPlayAndSeeTimer ()

@end

@implementation ViewControllerPlayAndSeeTimer
@synthesize SongsToPlay;
@synthesize MinutsToNextTask;
@synthesize Index;

static NSInteger Sec;
static NSInteger Min;
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Min = 0;
    Sec = 0;
    // Do any additional setup after loading the view.
    self.tasksList = [[NSMutableArray alloc] init];
    [self queryParseForData:^(NSArray *arrayOfDataPoints) {
        // Update the table with the results.
        
        
    }];
    
    if([self.selectedTasksList count]== 0)
    {
        NSLog(@"if       1");
        [self performSegueWithIdentifier:@"acabouatividade" sender:self];
        
        //go to tu é fera boy
        //mandar nada
    }
    
    MinutsToNextTask = 0;
    Index = 0;
    self.qualatividade.text = nil;
    self.musicname.text = nil;
    self.tempo.text = nil;
    
    if([SongsToPlay count] != 0)
    {
        musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
        collection = [[MPMediaItemCollection alloc] initWithItems:SongsToPlay];
        
        [musicPlayer setQueueWithItemCollection:collection];
        [musicPlayer setRepeatMode:MPMusicRepeatModeAll];
        [musicPlayer play];
    }
    
    if([self.selectedTasksList count] != 0)
    {
        Task *MyTask = [self.selectedTasksList objectAtIndex:0];
        //self.LabelAtividades.text = MyTask.name;
        NSInteger minutos = (long)MyTask.time.minute;
        NSInteger horas = (long)MyTask.time.hour;
        
        MinutsToNextTask = horas*60 + minutos;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePaused)
    {
        [self.PlayButton setImage:[UIImage imageNamed:@"playButton-101x101px.png"] forState:UIControlStateNormal];
    }
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying)
    {
        [self.PlayButton setImage:[UIImage imageNamed:@"pauseButton-101x101px.png"] forState:UIControlStateNormal];

    }
}

- (void)queryParseForData:(void (^)(NSArray *))completionHandler{
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    // [query whereKey:@"name" equalTo:@"Ir pra casa"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Query found all your objects, return the completion handler
            completionHandler(objects);
            for (int i = 0; i < [objects count]; i++){
                NSString *name = objects[i][@"name"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                NSDate *today = [dateFormat dateFromString:objects[i][@"time"]];
                
                //NSString *dateString = [dateFormat stringFromDate:today];
                // NSLog(dateString);
                
                NSDateComponents *time = [[NSCalendar currentCalendar]
                                          components:NSCalendarUnitHour | NSCalendarUnitMinute
                                          fromDate:today];
                Task *newTask = [[Task alloc] initWithName:name Time:time Status:NO];
                [self.tasksList addObject:newTask];
                
            }
            
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PlaySong:(id)sender {
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePaused)
    {
        [self.PlayButton setImage:[UIImage imageNamed:@"pauseButton-101x101px.png"] forState:UIControlStateNormal];
        [musicPlayer play];
    }
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying)
    {
        [self.PlayButton setImage:[UIImage imageNamed:@"playButton-101x101px.png"] forState:UIControlStateNormal];
        [musicPlayer pause];
    }
}

- (IBAction)EndTask:(id)sender {
    
}
- (IBAction)ArregoButton:(id)sender {
}

- (void)updateTime{
    
    Sec++;
    
    if(Sec==60)
    {
        Sec = 0;
        Min++;
    }
    
    NSLog(@"%ld %ld %ld",(long)Min,(long)Sec,(long)Index);
    
    if(MinutsToNextTask-Min-1>=0)
    self.tempo.text = [NSString stringWithFormat:@"%d: %d", (int)(MinutsToNextTask-Min)-1,(int)(60-Sec)];
    
    if(Min == self.MinutsToNextTask)
    {
        Min = 0;
        Index++;
        {
            
            if([SongsToPlay count]!=0 && [self.selectedTasksList count]!=0)
            {
                //ViewControllerVacilo *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"saidapelotempo"];
                //secondViewController.SongsToPlay = self.SongsToPlay;
                //secondViewController.selectedTasksList = self.selectedTasksList;
                //[self.navigationController pushViewController:secondViewController animated:YES];
            }
            //go to vacilao
            //mandar lista de tasks
            //mandar lista de musicas
            //voltar com tasks com tempo alterado
            //voltar com musicas
        }
    }
    
    if([self.selectedTasksList count] != 0)
    {
        Task *MyTask = [self.selectedTasksList objectAtIndex:Index];
        NSInteger minutos = (long)MyTask.time.minute;
        NSInteger horas = (long)MyTask.time.hour;
        self.qualatividade.text = MyTask.name;
        MinutsToNextTask = horas*60 + minutos;
    }
    
    if(SongsToPlay != nil)
    {
        MPMediaItem  *songItem = [musicPlayer nowPlayingItem];
        self.musicname.text = songItem.title;
    }
    
    if([self.selectedTasksList count]== 0)
    {
        NSLog(@"if       2");
        [self performSegueWithIdentifier:@"acabouatividade" sender:self];
        
        //go to tu é fera boy
        //mandar nada
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [timer invalidate];
    [musicPlayer stop];
    if ([segue.identifier isEqualToString:@"Feito"]) {
        
        [musicPlayer pause];
        if([self.selectedTasksList count] != 0)
        {
            [self.selectedTasksList removeObjectAtIndex:0];
        }
        
        if([self.selectedTasksList count]== 0)
        {
            NSLog(@"if       3");
            [self performSegueWithIdentifier:@"acabouatividade" sender:self];
            
            //go to tu é fera boy
            //mandar nada
        }
        
        ViewControllerParabens * BController = (ViewControllerParabens*)segue.destinationViewController;
        BController.selectedTasksList = self.selectedTasksList;
        BController.SongsToPlay = self.SongsToPlay;
    }
    
    if ([segue.identifier isEqualToString:@"noob"]) {
        
        [musicPlayer pause];
        ViewControllerVacilo * BController = (ViewControllerVacilo*)segue.destinationViewController;
        if([SongsToPlay count]!=0 && [self.selectedTasksList count]!=0)
        {
            BController.selectedTasksList = self.selectedTasksList;
            BController.SongsToPlay = self.SongsToPlay;
        }
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"backToList"]) {
        ViewController * BController = (ViewController*)segue.destinationViewController;
        BController.tasksList = self.tasksList;
    }
    
}

@end
