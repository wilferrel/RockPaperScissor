//
//  RPSHelperClass.m
//  RockPaperScissor
//
//  Created by Wil Ferrel on 6/6/13.
//  Copyright (c) 2013 WilFerrel. All rights reserved.
//

#import "RPSHelperClass.h"

@implementation RPSHelperClass

+(NSString *)determineOutcome:(NSString *)responseString userPick:(NSString *)userPick
{
	if ([responseString rangeOfString:@"won"].location == NSNotFound)
	{
		if ([responseString rangeOfString:@"lost"].location == NSNotFound)
		{
			if ([responseString rangeOfString:@"tied"].location != NSNotFound)
			{
				[self addResultToDictionary:@"Tied" picked:userPick];
				return @"Tied";
			}
			else
			{
				return nil;
			}

		}
		else
		{
			[self addResultToDictionary:@"Lost" picked:userPick];
			return @"Lost";
		}
	}
	else
	{
		[self addResultToDictionary:@"Won" picked:userPick];
		return @"Won";
	}
	
}
/*
+(void)getComputerSelection:(NSString *)userSelection
{
	NSURL *hostURL = [NSURL URLWithString:@"http://roshambo.herokuapp.com"];
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:hostURL];
	
	[httpClient setDefaultHeader:@"Accept" value:@"text/plain"];
	NSMutableURLRequest *urlRequest = [httpClient requestWithMethod:@"GET" path:[NSString stringWithFormat:@"/throws/%@",[userSelection lowercaseString]] parameters:nil];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:urlRequest];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Success %@",operation.responseString);
		
		NSLog(@"Result is %@",[self determineOutcome:operation.responseString userPick:userSelection]);
		
	}
									 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Failure %@",[error localizedDescription]);
		
	}];
	[operation start];
}
*/
+(void)getComputerSelection:(NSString *)userSelection completion:(void (^)(BOOL, NSError *))completion{
	NSURL *hostURL = [NSURL URLWithString:@"http://roshambo.herokuapp.com"];
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:hostURL];
	
	[httpClient setDefaultHeader:@"Accept" value:@"text/plain"];
	NSMutableURLRequest *urlRequest = [httpClient requestWithMethod:@"GET" path:[NSString stringWithFormat:@"/throws/%@",[userSelection lowercaseString]] parameters:nil];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:urlRequest];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Success %@",operation.responseString);
		
		NSLog(@"Result is %@",[self determineOutcome:operation.responseString userPick:userSelection]);
		completion(TRUE,nil);
	}
									 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
										 NSLog(@"Failure %@",[error localizedDescription]);
										 completion(FALSE,error);
									 }];
	[operation start];
}

+(void)addResultToDictionary:(NSString *)result picked:(NSString *)picked{
	RPSAppDelegate *appDelegate = (RPSAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
	
	[dict setObject:result forKey:@"result"];
	[dict setObject:[NSDate date] forKey:@"time"];
	[dict setObject: picked forKey:@"userpick"];
	[appDelegate.gameResultsArray addObject:dict];
	
	//[[NSNotificationCenter defaultCenter]
    // postNotificationName:@"ShowResults"
    // object:self];
	
	[[NSNotificationCenter defaultCenter]
     postNotificationName:@"UpdateTable"
     object:self];
}

@end
