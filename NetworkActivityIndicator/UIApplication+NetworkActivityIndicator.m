//
//  UIApplication+NetworkActivityIndicator.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "UIApplication+NetworkActivityIndicator.h"

#import <objc/runtime.h>

static void *NumberOfConnectionsPropertyKey;

@implementation UIApplication (NetworkActivityIndicator)


#pragma mark Number of Connections

- (NSNumber *)numberOfConnections
{
	NSNumber *result = objc_getAssociatedObject(self, &NumberOfConnectionsPropertyKey);
	if (result == nil) {
		result = @(0);
		objc_setAssociatedObject(self, &NumberOfConnectionsPropertyKey, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return result;
}

- (void)setNumberOfConnections:(NSNumber *)numberOfConnections
{
	objc_setAssociatedObject(self, &NumberOfConnectionsPropertyKey, numberOfConnections, OBJC_ASSOCIATION_RETAIN);
}


#pragma mark Increment/Decrement

- (void)incrementNumberOfConnections
{
	// Get the number of connections, increment
	NSNumber *numberOfConnections = [self numberOfConnections];
	numberOfConnections = [NSNumber numberWithInt:([numberOfConnections integerValue]+1.0)];
	
	// Save the number of connections
	[self setNumberOfConnections:numberOfConnections];
	
	// Show the network activity indicator
	if ( !self.networkActivityIndicatorVisible ) {
		self.networkActivityIndicatorVisible = YES;
	}
}

- (void)decrementNumberOfConnections
{
	// Get the number of connections, decrement
	NSNumber *numberOfConnections = [self numberOfConnections];
	numberOfConnections = [NSNumber numberWithInt:([numberOfConnections integerValue]-1.0f)];
	
	// Save the number of connections
	[self setNumberOfConnections:numberOfConnections];
	
	if ( self.networkActivityIndicatorVisible && numberOfConnections.integerValue < 1 ) {
		self.networkActivityIndicatorVisible = NO;
	}
}


#pragma Public API

- (void)beganNetworkActivity
{
	[self incrementNumberOfConnections];
}

- (void)endedNetworkActivity;
{
	[self decrementNumberOfConnections];
}

@end
