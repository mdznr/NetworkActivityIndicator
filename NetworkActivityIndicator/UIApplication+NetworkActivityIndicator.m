//
//  UIApplication+NetworkActivityIndicator.m
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "UIApplication+NetworkActivityIndicator.h"

#import <libkern/OSAtomic.h>

@implementation UIApplication (NetworkActivityIndicator)

// UIApplication is a singleton so we can just use a static global.
static volatile int32_t g_numberOfConnections;

#pragma mark Public API

- (void)beganNetworkActivity
{
    // Using interlocked atomic operations to avoid races and reduce complexity.
	self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &g_numberOfConnections) > 0;
}

- (void)endedNetworkActivity
{
	self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &g_numberOfConnections) > 0;
}

@end
