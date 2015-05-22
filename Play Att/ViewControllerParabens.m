//
//  ViewControllerParabens.m
//  Play Att
//
//  Created by vinicius emanuel on 03/05/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewControllerParabens.h"
#import "ViewControllerPlayAndSeeTimer.h"

@interface ViewControllerParabens ()

@end

@implementation ViewControllerParabens

@synthesize selectedTasksList;
@synthesize SongsToPlay;
NSTimer*timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tempo.text = nil;
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agora:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [timer invalidate];
    if ([segue.identifier isEqualToString:@"agora"]) {
        ViewControllerPlayAndSeeTimer * BController = (ViewControllerPlayAndSeeTimer*)segue.destinationViewController;
        BController.selectedTasksList = self.selectedTasksList;
        BController.SongsToPlay = self.SongsToPlay;
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selectedTasksList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    Task *t = self.selectedTasksList[indexPath.row ];
    
    cell.textLabel.text =t.name;
    
    return cell;
}


//////////////////////////////////////////////////////////////

- (void)updateTime{
    
    static NSInteger Sec=0;
    static NSInteger Min=0;
    
    Sec++;
    
    if(Sec==60)
    {
        Sec = 0;
        Min++;
    }
    self.tempo.text = [NSString stringWithFormat:@"%d: %d", (int)(4-Min),(int)(60-Sec)];
    
    if(Min==5)
    {
        //voltar para a view anterior com a mesma lista de atividades e mesma lista de musicas
        
        ViewControllerPlayAndSeeTimer *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aprincipalcoisaafazer"];
        secondViewController.SongsToPlay = self.SongsToPlay;
        secondViewController.selectedTasksList = self.selectedTasksList;
        [self.navigationController pushViewController:secondViewController animated:YES];
    }
}

@end
