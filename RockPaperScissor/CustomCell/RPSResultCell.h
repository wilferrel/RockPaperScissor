//
//  RPSResultCell.h
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPSResultCell : UITableViewCell{
	
}
@property (weak, nonatomic) IBOutlet UILabel *cellWinner;
@property (weak, nonatomic) IBOutlet UILabel *cellTimeOfPlay;
@property (weak, nonatomic) IBOutlet UILabel *userPick;
@end
