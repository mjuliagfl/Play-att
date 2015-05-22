//
//  ViewControllerVacilo.h
//  Play Att
//
//  Created by vinicius emanuel on 03/05/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerVacilo : UIViewController

@property NSMutableArray *SongsToPlay;
@property NSMutableArray* selectedTasksList;
@property (weak, nonatomic) IBOutlet UIDatePicker *novotempo;

@end
