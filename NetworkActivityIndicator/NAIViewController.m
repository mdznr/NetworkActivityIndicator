//
//  NAIViewController.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "NAIViewController.h"

// Import the UIApplication category for Network Activity Indicator
#import "UIApplication+NetworkActivityIndicator.h"

@implementation NAIViewController

// For the sake of this demo, all cells are the same.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	aiv.hidesWhenStopped = YES;
	cell.accessoryView = aiv;
	return cell;
}

// Selected table view row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	// Not excellent, but done for simplicity of the demo project
	UIActivityIndicatorView *spinner = (UIActivityIndicatorView *) cell.accessoryView;
	
	// If the individual download is starting or stopping
	BOOL startingActivity = ![spinner isAnimating];
	
	if ( startingActivity ) {
		// Animate the spinner in the cell
		[spinner startAnimating];
		// Tell the application (simulated) network activity has begun
		[[UIApplication sharedApplication] beganNetworkActivity];
		// Update cell label to red "Stop"
		cell.textLabel.text = @"Stop Simulated Activity";
		cell.textLabel.textColor = [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f];
	} else {
		// Stop the animation (end simulated network activity)
		[spinner stopAnimating];
		// Tell the application (simulated) neywork activity has stopped
		[[UIApplication sharedApplication] endedNetworkActivity];
		// Update cell label to blue "Start"
		cell.textLabel.text = @"Start Simulated Activity";
		cell.textLabel.textColor = [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f];
	}
}

@end
