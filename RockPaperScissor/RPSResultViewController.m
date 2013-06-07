//
//  RPSResultViewController.m
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import "RPSResultViewController.h"
#import "RPSResultCell.h"
#import "SIAlertView.h"

@interface RPSResultViewController ()

@end

@implementation RPSResultViewController
@synthesize recentResultsTable=_recentResultsTable;
@synthesize resultsDictionary,interactiveMode;





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
	[recentResultsTable reloadData];
	//User Choices for Picker
	userChoices=[NSArray arrayWithObjects:@"Rock",@"Paper",@"Scissors", nil];
}
-(BOOL)canBecomeFirstResponder{
	return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
	self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundImage"]];
	
	appDelegate = (RPSAppDelegate *)[[UIApplication sharedApplication] delegate];
	resultsDictionary=[[NSMutableDictionary alloc]init];
	
	//Notification Center
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResults) name:@"UpdateTable" object:nil];
	
		if(interactiveMode)
	{
		[self runInteractiveModeProcess];
		playAgainButton.hidden = TRUE;
		resultsLabel.hidden =TRUE;

	}
	
	
}

-(void)runInteractiveModeProcess{
	SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Rock.." andMessage:@"Shake to continue"];
	[alertView becomeFirstResponder];
	[alertView addButtonWithTitle:@""
							 type:SIAlertViewButtonTypeDestructive
						  handler:^(SIAlertView *alert) {
						  }];
	alertView.didDismissHandler = ^(SIAlertView *alertView) {
		NSLog(@"%@, didDismissHandler", alertView);
		
		SIAlertView *alertView2 = [[SIAlertView alloc] initWithTitle:@"Paper.." andMessage:@"Shake to continue"];
		[alertView2 addButtonWithTitle:@""
								 type:SIAlertViewButtonTypeCancel
							  handler:^(SIAlertView *alert) {
							  }];
		alertView2.didDismissHandler = ^(SIAlertView *alertView) {
			NSLog(@"%@, didDismissHandler", alertView);
			SIAlertView *alertView3 = [[SIAlertView alloc] initWithTitle:@"Scissor.." andMessage:@"Shake to continue"];
			[alertView3 addButtonWithTitle:@""
									 type:SIAlertViewButtonTypeDefault
								  handler:^(SIAlertView *alert) {
								  }];
			alertView3.didDismissHandler = ^(SIAlertView *alertView) {
				NSLog(@"%@, didDismissHandler", alertView);
				NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				
				[RPSHelperClass getComputerSelection:[defaults objectForKey:USERSELECTION] completion:^(BOOL finished, NSError *errorReturned) {
					if (finished)
					{
						NSLog(@"You have selected %@",[defaults objectForKey:USERSELECTION]);
						[recentResultsTable reloadData];
						playAgainButton.hidden = FALSE;
						resultsLabel.hidden =FALSE;

					}
					else
					{
						NSLog(@"Service Error : %@",[errorReturned localizedDescription]);
						
					}
				}];

			};
			
			alertView3.transitionStyle = SIAlertViewTransitionStyleBounce;
			[alertView3 show];
			
		};
		
		alertView2.transitionStyle = SIAlertViewTransitionStyleBounce;
		[alertView2 show];
	};
	
	alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
	[alertView show];
}
-(void)updateResults{
	[self.recentResultsTable reloadData];
}


#pragma mark -
#pragma mark UITableview Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cell"]];
							
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	

    return [appDelegate.gameResultsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultCell";
	RPSResultCell *cell = (RPSResultCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil];

		cell = [nib objectAtIndex:0];
	}
		
	//NSDateFormatter
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MMM dd, yyyy HH:mm"];
	
	
	// Configure the cell...
	NSDictionary *info = [appDelegate.gameResultsArray  objectAtIndex:indexPath.row];
	
    cell.cellWinner.text = [info objectForKey:@"result"];
	cell.cellTimeOfPlay.text =[format stringFromDate:[info objectForKey:@"time"]];
	cell.userPick.text =[info objectForKey:@"userpick"];
	if ([cell.cellWinner.text isEqualToString:@"Lost"]) {
		cell.cellWinner.textColor= [UIColor redColor];
	}
	else if ([cell.cellWinner.text isEqualToString:@"Won"])
	{
		cell.cellWinner.textColor= [UIColor greenColor];
	}
	else
	{
		cell.cellWinner.textColor= [UIColor yellowColor];
	}
	cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cell"]];
	cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   NSLog(@"Row pressed!!");
}
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAgain:(id)sender
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
	
	if (interactiveMode)
	{
		[self runInteractiveModeProcess];
	}
	else
	{
		[RPSHelperClass getComputerSelection:[defaults objectForKey:USERSELECTION] completion:^(BOOL finished, NSError *errorReturned) {
			if (finished)
			{
				NSLog(@"You have selected %@",[defaults objectForKey:USERSELECTION]);
				[self.recentResultsTable reloadData];
			}
			else
			{
				NSLog(@"Service Error : %@",[errorReturned localizedDescription]);
			}
		}];
	}
}

-(void)viewWillDisappear:(BOOL)animated{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
