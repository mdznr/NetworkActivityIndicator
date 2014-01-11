//
//  UIApplication+NetworkActivityIndicator.h
//  NetworkActivityIndicator
//
//  Created by Matt Zanchelli on 1/10/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (NetworkActivityIndicator)

/*
 This category will automatically keep track of concurrent network activity and display the network activity indicator accordingly.
 */

// This method should not exist
- (void)setNetworkActivityIndicatorVisible:(BOOL)networkActivityIndicatorVisible NS_DEPRECATED_IOS(2_0, 7_0);

// This should be readonly
@property (nonatomic, readonly) BOOL networkActivityIndicatorVisible;

#warning Documentation for when to use the Network Activity Indicator
/// Tell the application that network activity has begun. The network activity indicator will then be shown.
- (void)beganNetworkActivity;

/// Tell the application that a session of network activity has begun. The network activity indicator will remain showing or hide depending the presence of other ongoing network activity in the app.
- (void)endedNetworkActivity;

@end
