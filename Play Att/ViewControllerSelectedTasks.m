//
//  ViewControllerSelectedTasks.m
//  Play Att
//
//  Created by Maria Julia Godoy on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//



#import "ViewControllerSelectedTasks.h"
#import "ViewController.h"
#import "Task.h"
#import "Reachability.h"
#import "ViewControllerShowPlayLists.h"

@interface ViewControllerSelectedTasks ()
@property (weak, nonatomic) IBOutlet UITableView *tableSelectedTasks;
@property (weak, nonatomic) IBOutlet UIButton *notDisturbYes;
@property (weak, nonatomic) IBOutlet UIButton *notDisturbNo;
@property (weak, nonatomic) IBOutlet UIButton *choosePlaylist;
@property BOOL connected;
@property BOOL action;
@property BOOL chosen;
@property BOOL segue;


@end

@implementation ViewControllerSelectedTasks

- (void)viewDidLoad {
    [super viewDidLoad];
    self.action = NO;
    self.chosen = NO;
    self.tableSelectedTasks.dataSource = self;
    self.tableSelectedTasks.delegate = self;
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    
}

-(UITableViewCell(*) ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] init]; //alloc a space for each cell
    UILabel *timelbl = [[UILabel alloc] initWithFrame: CGRectZero];
    CGRect frame = timelbl.frame;
    frame.origin.x = 320;
    //frame.origin.y = 9;
    frame.size.height = 40;
    frame.size.width = 80;
    timelbl.frame = frame;
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    //[timelbl setFont:[UIFont ]];
    [timelbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    
    if(indexPath.row < [self.selectedTasksList count]){
        
        
        Task *tsk = self.selectedTasksList[indexPath.row ]; //pick activity according to the cell number
        cell.textLabel.text = tsk.name ; //puts the name of the task as the cell label
        //alimentando o label do time com o tempo da atividade
        //pegando a hora e minutos
        NSString* hours = [NSString stringWithFormat:@"%02li", (long)[tsk.time hour]];
        NSString* minutes = [NSString stringWithFormat:@"%02li", (long)[tsk.time minute]];
        NSString* formattedtime = [NSString stringWithFormat: @" %@:%@", hours, minutes];
        
        timelbl.text = formattedtime;
        [cell.contentView addSubview:timelbl];
        
        
    }
    
    
    return cell;
    
}
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    return [self.selectedTasksList count];
    //return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    //NSLog(@"PRIMEIRO O PERFORM");
    
    
    self.connected = [self testConnection];
    
    if(!self.connected){
        return YES;
    }
    else {
        UIAlertView *stillConnected = [[UIAlertView alloc]
                                       initWithTitle:@"Warning" message:@"You are still connected to the internet. While you are focusing, you will recieve alerts, notifications and calls. Are you sure you want to continue?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles: @"Cancel", nil];
        [stillConnected show];
        
        
        NSLog(@"chegou efddf");
        if(self.chosen){
            
            
            NSLog(@"entrou");
            if(self.action){
                NSLog(@"checou");
                
                return YES;
            }
            else{
                NSLog(@"checou");
                
                return NO;
                
                
            }
            
            
        }
        NSLog(@"pulou");
        
        
        
        
    }
    
    
    return NO;
}*/

//verifies if the user is connected to the internet
- (BOOL)testConnection{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"desconectado");
        
        return NO;
    }
    else {
        NSLog(@"conectado");
        
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToPlayList"]) {
        ViewControllerShowPlayLists * BController = (ViewControllerShowPlayLists*)segue.destinationViewController;
        BController.selectedTasksList = self.selectedTasksList;
    }
    
    if([segue.identifier isEqualToString:@"backSegue"]){
        ViewController *destViewController = segue.destinationViewController;
        //destViewController.selectedTasksList = self.selectedTasksList;
        destViewController.tasksList = self.tasksList;
        
    }
}

- (IBAction)buttonPressed:(id)sender {
    self.connected = [self testConnection];
    
    if(!self.connected){
        return [self performSegueWithIdentifier:@"GoToPlayList" sender:self];
    }else {
        UIAlertView *stillConnected = [[UIAlertView alloc]
                                       initWithTitle:@"Warning" message:@"You are still connected to the internet. While you are focusing, you will recieve alerts, notifications and calls. Are you sure you want to continue?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles: @"Cancel", nil];
        [stillConnected show];
        //
        //
        //        NSLog(@"chegou efddf");
        //        if(self.chosen){
        //
        //
        //            NSLog(@"entrou");
        //            if(self.action){
        //                NSLog(@"checou");
        //
        //                return YES;
        //            }
        //            else{
        //                NSLog(@"checou");
        //
        //                return NO;
        //
        //
        //            }
        //
        //
        //        }
        //        NSLog(@"pulou");
        
        
        
        
    }
    //apresentar a pergunta
    //ver a resposta se for o valor que vcs querem, performeSegue...
    
}


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [alertView cancelButtonIndex]){
        self.action = YES;
        self.chosen = YES;
        [self performSegueWithIdentifier:@"GoToPlayList" sender:self];
        NSLog(@"clicou sim ******");
    }else{
        self.action = NO;
        self.chosen = YES;
        NSLog(@"clicou nao ******");
    }
}




@end
