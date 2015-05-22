//
//  PreLoadViewController.m
//  Play Att
//
//  Created by Déborah Mesquita on 02/05/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "PreLoadViewController.h"
#import "Task.h"
#import <Parse/Parse.h>

@interface PreLoadViewController ()

@end

@implementation PreLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tasksList = [[NSMutableArray alloc] init];
    [self queryParseForData:^(NSArray *arrayOfDataPoints) {
        // Update the table with the results.
        
        
    }];
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
                NSString *descricao = objects[i][@"descricao"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                NSDate *today = [dateFormat dateFromString:objects[i][@"time"]];
                
                NSString *dateString = [dateFormat stringFromDate:today];
               // NSLog(dateString);
                
                NSDateComponents *time = [[NSCalendar currentCalendar]
                                          components:NSCalendarUnitHour | NSCalendarUnitMinute
                                          fromDate:today];
                Task *newTask = [[Task alloc] initWithName:name Details:descricao Time:time Status:NO];
                [self.tasksList addObject:newTask];
                
            }
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"iniciarParse"]) {
        ViewController * BController = (ViewController*)segue.destinationViewController;
        BController.tasksList = self.tasksList;
    }
}


@end
