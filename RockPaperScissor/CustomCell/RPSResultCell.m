//
//  RPSResultCell.m
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import "RPSResultCell.h"

@implementation RPSResultCell

@synthesize cellTimeOfPlay=_cellTimeOfPlay, cellWinner=_cellWinner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
