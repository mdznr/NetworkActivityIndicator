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

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner4;

@end

@implementation NAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tappedButton1:(id)sender
{
	if ( !_spinner1.isAnimating ) {
		[_spinner1 startAnimating];
		[[UIApplication sharedApplication] beganNetworkActivity];
	} else {
		[_spinner1 stopAnimating];
		[[UIApplication sharedApplication] stoppedNetworkActivity];
	}
}

- (IBAction)tappedButton2:(id)sender
{
	if ( !_spinner2.isAnimating ) {
		[_spinner2 startAnimating];
		[[UIApplication sharedApplication] beganNetworkActivity];
	} else {
		[_spinner2 stopAnimating];
		[[UIApplication sharedApplication] stoppedNetworkActivity];
	}
}

- (IBAction)tappedButton3:(id)sender
{
	if ( !_spinner3.isAnimating ) {
		[_spinner3 startAnimating];
		[[UIApplication sharedApplication] beganNetworkActivity];
	} else {
		[_spinner3 stopAnimating];
		[[UIApplication sharedApplication] stoppedNetworkActivity];
	}
}

- (IBAction)tappedButton4:(id)sender
{
	if ( !_spinner4.isAnimating ) {
		[_spinner4 startAnimating];
		[[UIApplication sharedApplication] beganNetworkActivity];
	} else {
		[_spinner4 stopAnimating];
		[[UIApplication sharedApplication] stoppedNetworkActivity];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
