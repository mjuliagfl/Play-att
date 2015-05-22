//
//  ViewControllerVacilo.m
//  Play Att
//
//  Created by vinicius emanuel on 03/05/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import "ViewControllerVacilo.h"
#import "ViewControllerPlayAndSeeTimer.h"

@interface ViewControllerVacilo ()

@end

@implementation ViewControllerVacilo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.novotempo.countDownDuration = 300.0f;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ViewControllerPlayAndSeeTimer * BController = (ViewControllerPlayAndSeeTimer*)segue.destinationViewController;
    BController.selectedTasksList = self.selectedTasksList;
    BController.SongsToPlay = self.SongsToPlay;
}


@end
