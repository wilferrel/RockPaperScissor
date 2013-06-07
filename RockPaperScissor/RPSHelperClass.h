//
//  RPSHelperClass.h
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "RPSAppDelegate.h"

#define MY_DELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]


@interface RPSHelperClass : NSObject{
	
}
+(NSString *)determineOutcome:(NSString *)responseString userPick:(NSString *)userPick;



//+(void)getComputerSelection:(NSString *)userSelection;
+(void)addResultToDictionary:(NSString *)result picked:(NSString *)picked;


+(void)getComputerSelection:(NSString *)userSelection completion:(void (^)(BOOL finished, NSError *errorReturned))completion;
@end
