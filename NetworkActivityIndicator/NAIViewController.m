//
//  NAIViewController.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "NAIViewController.h"

#import "UIApplication+NetworkActivityIndicator.h"

@interface NAIViewController ()

@end

@implementation NAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// For the sake of this demo, all cells are the same.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	aiv.hidesWhenStopped = YES;
	cell.accessoryView = aiv;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	// Not excellent, but done for simplicity of the demo project
	UIActivityIndicatorView *spinner = (UIActivityIndicatorView *) cell.accessoryView;
	
	// If the individual download is active or not
	if ( [spinner isAnimating ] ) {
		[spinner stopAnimating];
		cell.textLabel.text = @"Start Simulated Activity";
		cell.textLabel.textColor = [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f];
		[[UIApplication sharedApplication] endedNetworkActivity];
	} else {
		[spinner startAnimating];
		cell.textLabel.text = @"Stop Simulated Activity";
		cell.textLabel.textColor = [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f];
		[[UIApplication sharedApplication] beganNetworkActivity];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
