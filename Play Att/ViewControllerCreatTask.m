//
//  ViewControllerCreatTask.m
//  Play Att
//
//  Created by vinicius emanuel on 30/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewControllerCreatTask.h"
#import "Task.h"
#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewControllerCreatTask ()

@end

@implementation ViewControllerCreatTask
@synthesize tasksList;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Timer.countDownDuration = 300.0f;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)OcultarTeclado:(id)sender
{
    [sender resignFirstResponder];
}
-(IBAction)ClickBackGrond:(id)sender
{
    [_NameOfTask resignFirstResponder];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Salvar"]) {
        ViewController * BController = (ViewController*)segue.destinationViewController;
        BController.tasksList = self.tasksList;
    }
    else if([segue.identifier isEqualToString:@"Cancelar"]){
        ViewController * BController = (ViewController*)segue.destinationViewController;
        BController.tasksList = self.tasksList;
    
    }
}


- (IBAction)NewTask:(id)sender {
    NSString *name = self.NameOfTask.text;
    NSDate *date = [self.Timer date];
    
    NSDateComponents *time = [[NSCalendar currentCalendar]
                              components:NSCalendarUnitHour | NSCalendarUnitMinute
                              fromDate:date];
   // NSString* hours = [NSString stringWithFormat:@"%02li", [time hour]];
   //NSString* minutes = [NSString stringWithFormat:@"%02li", [time minute]];
   //NSString* formattedtime = [NSString stringWithFormat: @" %@:%@", hours, minutes];
   //NSLog(formattedtime);
    
    Task *newTask = [[Task alloc] initWithName:name Time:time Status:NO];
    
    [self.tasksList addObject:newTask];
    
    //Save to Parse
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    PFObject *testObject = [PFObject objectWithClassName:@"Task"];
    testObject[@"name"] = name;
    testObject[@"time"] = dateString;
    
    [testObject saveInBackground];
    //Save to Parse --END
    
    NSLog(@"%ld", [tasksList count]);
    
    
}

@end
