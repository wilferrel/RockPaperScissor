//
//  RPSResultViewController.h
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIAlertView.h"

@interface RPSResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAccelerometerDelegate>{
	UITableView *recentResultsTable;
	RPSAppDelegate *appDelegate;
	SIAlertView *rockAlert;
	SIAlertView *paperAlert;
	SIAlertView *scissorsAlert;
	
	NSArray *userChoices;
	UIActionSheet *actionSheet;
	UIPickerView *pickerView;
	IBOutlet UIButton *playAgainButton;
	IBOutlet UILabel *resultsLabel;
}
@property (weak, nonatomic) IBOutlet UITableView *recentResultsTable;
@property (strong, nonatomic) NSMutableDictionary *resultsDictionary;
@property (assign, nonatomic) BOOL interactiveMode;
- (IBAction)playAgain:(id)sender;


@end
