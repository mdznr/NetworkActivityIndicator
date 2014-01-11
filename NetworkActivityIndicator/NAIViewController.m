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
	UIActivityIndicatorView *spinner = (UIActivityIndicatorView *) cell.accessoryView;
	
	if ( [spinner isAnimating ] ) {
		[spinner stopAnimating];
		[[UIApplication sharedApplication] endedNetworkActivity];
	} else {
		[spinner startAnimating];
		[[UIApplication sharedApplication] beganNetworkActivity];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
