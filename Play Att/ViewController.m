//
//  ViewController.m
//  Play Att
//
//  Created by Mateus Fernandes Correia on 28/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
#import "ViewControllerCreatTask.h"
#import "ViewControllerSelectedTasks.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.switchStates = [[NSMutableArray alloc] init];
    
    
    NSLog(@"%ld chegou", [self.tasksList count]);
    
    self.tableTasks.dataSource = self;
    self.tableTasks.delegate = self;
    
    if([self.tasksList count]==0)
        self.tasksList = [[NSMutableArray alloc] init];
    //NSDateComponents *z = nil;
    
    for(int i = 0; i< [self.tasksList count]; i++){
        [self.switchStates addObject:@"OFF"];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

//metodo pra controlar o tableview
-(UITableViewCell(*) ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] init]; //alloc a space for each cell
    
    UISwitch *selectSwitch = [[UISwitch alloc] initWithFrame: CGRectZero]; //init the switch
    
    //time label
    UILabel *timelbl = [[UILabel alloc] initWithFrame: CGRectZero];
    UILabel *txtlbl = [[UILabel alloc] initWithFrame: CGRectZero];
    CGRect framel = timelbl.frame;
    framel.origin.x = 310;
    //frame.origin.y = 9;
    framel.size.height = 40;
    framel.size.width = 80;
    
    [txtlbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    //[timelbl setFont:[UIFont ]];
    [timelbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    
    
    //timelbl.font = [UIFont fontWithName:@"System" size:60];
    // [UIFont fon]
    timelbl.frame = framel;
    
    
    
    //change the place of the sitch
    CGRect frame = selectSwitch.frame;
    frame.origin.x = 2;
    frame.origin.y = 7;
    selectSwitch.frame = frame;
    
    CGRect frametxt = txtlbl.frame;
    frametxt.origin.x = 60;
    
    frametxt.size.height = 40;
    frametxt.size.width = 265;
    txtlbl.frame = frametxt;
    
    [selectSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    if(indexPath.row < [_tasksList count]){
        Task *t = self.tasksList[indexPath.row ]; //pick activity according to the cell number
        txtlbl.text = t.name ; //puts the name of the task as the cell label
        
        //pegando a hora e minutos
        NSString* hours = [NSString stringWithFormat:@"%02li", (long)[t.time hour]];
        NSString* minutes = [NSString stringWithFormat:@"%02li", (long)[t.time minute]];
        NSString* formattedtime = [NSString stringWithFormat: @" %@:%@", hours, minutes];
        
        
        timelbl.text = formattedtime;
        [cell.contentView addSubview:timelbl];
        [cell.contentView addSubview:selectSwitch];
        [cell.contentView addSubview:txtlbl];
        // add subview of the switch to the cell
    }
    
    
    if([[self.switchStates objectAtIndex:indexPath.row]isEqualToString:@"ON"]){
        selectSwitch.on = YES;
    }
    else{
        selectSwitch.on = NO;
    }
    
    return cell;
    
}

-(void) switchChanged: (UISwitch *) sender{
    UITableViewCell *parentCell =(UITableViewCell*) [[sender superview]superview];
    NSIndexPath *indexPathOfSwitch = [self.tableTasks indexPathForCell:parentCell];
    if(sender.on){
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"ON"];
    }
    else{
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"OFF"];
    }
    NSLog(@"index patch switch: %ld", (long)indexPathOfSwitch.row);
    
}
- (IBAction)okayAction:(id)sender {
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
}

-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasksList count];
}

- (NSInteger)numberOfSectionsTableView:(UITableViewCell *)tableView{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Plus"]) {
        ViewControllerCreatTask * BController = (ViewControllerCreatTask*)segue.destinationViewController;
        BController.tasksList = self.tasksList;
    }
    
    if ([segue.identifier isEqualToString:@"toSelectedScreen"]) {
        self.selectedTasksList = [[NSMutableArray alloc]init];
        for(int i = 0; i < [self.tasksList count]; i++){
            if([self.switchStates[i] isEqualToString:@"ON"]){
                [self.selectedTasksList addObject:self.tasksList[i]];
            }
        }
        ViewControllerSelectedTasks *destViewController = segue.destinationViewController;
        destViewController.selectedTasksList = self.selectedTasksList;
        destViewController.tasksList = self.tasksList;
    }
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Remove from Database --BEGIN
        
        Task *t = self.tasksList[indexPath.row ];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Task"];
        
        [query whereKey:@"name" equalTo:t.name];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *object, NSError *error)  {
            
            // Do something with the returned PFObject in the gameScore variable.
            
            [object[0] deleteInBackground];
            
            NSLog(@"Removeu uma task");
            
        }];
        
        //Remove from Database --END
        
        [self.tasksList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Deu erro %ld", editingStyle);
    }
}

@end
