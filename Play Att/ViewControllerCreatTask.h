//
//  ViewControllerCreatTask.h
//  Play Att
//
//  Created by vinicius emanuel on 30/04/15.
//  Copyright (c) 2015 Mateus Fernandes Correia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewControllerCreatTask : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *NameOfTask;

@property (weak, nonatomic) IBOutlet UIDatePicker *Timer;

@property (weak, nonatomic) IBOutlet UIButton *Nop;
@property (weak, nonatomic) IBOutlet UIButton *Save;

@property (weak, nonatomic) IBOutlet UITextView *Detalhes;


@property NSMutableArray* tasksList;

-(IBAction)OcultarTeclado:(id)sender;
-(IBAction)ClickBackGrond:(id)sender;

@end
