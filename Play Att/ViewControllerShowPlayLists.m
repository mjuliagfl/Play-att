//
//  ViewController.m
//  Play Att
//
//  Created by vinicius emanuel on 29/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewControllerShowPlayLists.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ViewControllerPlayAndSeeTimer.h"


@interface ViewControllerShowPlayLists ()

@end


@implementation ViewControllerShowPlayLists


MPMediaQuery *myPlaylistsQuery;

NSArray *playlists;

@synthesize NamesOfPlayLists;

@synthesize SongsToPlay;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\
    
    NamesOfPlayLists = [[NSMutableArray alloc] init];
    SongsToPlay = [[NSMutableArray alloc] init];
    
    myPlaylistsQuery = [MPMediaQuery playlistsQuery];
    
    playlists = [myPlaylistsQuery collections];
    
    self.switchStates = [[NSMutableArray alloc]init];
    
   
    
    //[NamesOfPlayLists addObject: @"erfff"];
    
    for (MPMediaPlaylist *playlist in playlists)
    {
        [NamesOfPlayLists addObject:[playlist valueForProperty: MPMediaPlaylistPropertyName] ];
        //NSLog (@"%@ ", [playlist valueForProperty: MPMediaPlaylistPropertyName]);
        
        //[SongsToPlay addObjectsFromArray:[playlist items]];
    }
    
    for(int i = 0; i < [self.NamesOfPlayLists count]; i++){
        
        [self.switchStates addObject:@"OFF"];
        NSLog(@"if off");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
//    NSLog(segue.identifier);
//    if ([segue.identifier isEqualToString:@"ToPlay"]) {
//          NSLog(@"if 1");
    ViewControllerPlayAndSeeTimer * BController = (ViewControllerPlayAndSeeTimer*)segue.destinationViewController;
        for(int i = 0; i < [self.NamesOfPlayLists count]; i++){
            if([self.switchStates[i] isEqualToString:@"ON"]){
                
                  NSLog(@"if on");
                
                [SongsToPlay addObjectsFromArray:[playlists[i] items]];
            }
        //}
    }
    
    BController.SongsToPlay = self.SongsToPlay;
    BController.selectedTasksList = self.selectedTasksList;
    
    NSLog(@"aqui");
}

/**************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NamesOfPlayLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    UISwitch *selectSwitch = [[UISwitch alloc] initWithFrame: CGRectZero]; //init the switch
    
    UILabel *txtlbl = [[UILabel alloc] initWithFrame: CGRectZero];
    
    [txtlbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    //[timelbl setFont:[UIFont ]];
    //[timelbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
    //change the place of the sitch
    CGRect frame = selectSwitch.frame;
    frame.origin.x = 2;
    frame.origin.y = 7;
    selectSwitch.frame = frame;
    
    CGRect frametxt = txtlbl.frame;
    frametxt.origin.x = 60;
    
    frametxt.size.height = 40;
    frametxt.size.width = 350;
    txtlbl.frame = frametxt;
    
    txtlbl.text =[NamesOfPlayLists objectAtIndex:indexPath.row];
    [selectSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    [cell.contentView addSubview:selectSwitch];
    
    [cell.contentView addSubview:txtlbl];
    
    
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
    NSIndexPath *indexPathOfSwitch = [self.TableViewPlayLists indexPathForCell:parentCell];
    if(sender.on){
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"ON"];
    }
    else{
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"OFF"];
    }
    NSLog(@"index patch switch: %ld", (long)indexPathOfSwitch.row);
    
}
//
//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [SongsToPlay addObjectsFromArray:[playlists[indexPath.row] items]];
//
//    NSLog(@"%ld",indexPath.row);
//}


@end
