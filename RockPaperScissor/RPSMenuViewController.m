//
//  RPSMenuViewController.m
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import "RPSMenuViewController.h"
#import "RPSAppDelegate.h"
#import "RPSResultViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"

@interface RPSMenuViewController ()

@end

@implementation RPSMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
	userChoices=[NSArray arrayWithObjects:@"Rock",@"Paper",@"Scissors", nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToResult) name:@"ShowResults" object:nil];
	
	self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundImage"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playTouched:(id)sender
{
	[self userSelection];
}

-(void)userSelection{
	//Diplay UIPicker with choices
	actionSheet = [[UIActionSheet alloc] initWithTitle:@"Make your selection"
															 delegate:nil
                                                    cancelButtonTitle:nil
											   destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
	
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	
	CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
	
	pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
	pickerView.showsSelectionIndicator = YES;
	pickerView.dataSource = self;
	pickerView.delegate = self;
	
	[actionSheet addSubview:pickerView];
	
	UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
	closeButton.momentary = YES;
	closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor blackColor];
	[closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
	
	[actionSheet addSubview:closeButton];
	
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
	
	[actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

#pragma mark-
#pragma mark PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	return [userChoices count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [userChoices objectAtIndex:row];
}

#pragma mark -
#pragma mark - Action Buttons
-(IBAction)dismissActionSheet:(id)sender{
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setValue:[userChoices objectAtIndex:[pickerView selectedRowInComponent:0]] forKey:USERSELECTION];
	[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	

	if ([interactiveSwitch isOn]) {
		[self moveToResult];
	}
	else
	{
		[RPSHelperClass getComputerSelection:[defaults objectForKey:USERSELECTION] completion:^(BOOL finished, NSError *errorReturned) {
			if (finished)
			{
				NSLog(@"You have selected %@",[defaults objectForKey:USERSELECTION]);
				[self moveToResult];
			}
			else
			{
				NSLog(@"Service Error : %@",[errorReturned localizedDescription]);
			}
		}];
	}
			
	
	
	

}
-(void)moveToResult{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	RPSResultViewController *resultScreen = (RPSResultViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RPSResultViewController"];
	
		resultScreen.interactiveMode =[interactiveSwitch isOn];
	
	
	[self.navigationController pushViewController:resultScreen animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
