//
//  RPSMenuViewController.h
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPSMenuViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
	IBOutlet UISwitch *interactiveSwitch;
	NSArray *userChoices;
	UIActionSheet *actionSheet;
	UIPickerView *pickerView;
	RPSAppDelegate *appDelegate;

}
- (IBAction)playTouched:(id)sender;


@end
