//
//  RPSAppDelegate.h
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INTERACTIVEMODE @"interactivemode"
#define USERSELECTION @"userselecion"

@interface RPSAppDelegate : UIResponder <UIApplicationDelegate>{
UINavigationController *navigationController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *gameResultsArray;

@end
