# Network Activity Indicator

### Overview

The other day, I built a project to improve the Network Activity Indicator on iOS. The project contains a fix to the API and a demo application showing how the changes are used.


### What is the Network Activity Spinner?

On iOS, there’s a small spinner in the system status bar that is visible when the current app is performing network activity. The indicator is conveniently located next to the the cellular signal strength and WiFi strength indicators. This piece of UI gives great feedback to the user about ongoing network activity. The indicator can be used by the user to troubleshoot small issues. If content is taking a while to load, the user can assess the problem. The strength of the network connection (shown next to the indicator) may be weak, and slowing down the process. Depending on the connection status, the user may decide it is not worth waiting for the content to load and move on to working on something else. Ideally, none of these issues would even occur in the first place.  Due to technical limitations, this is not possible, thus the existence of the status bar and the network activity indicator.

This indicator is important for an application that uses the network. For the best experience, only some network activity should qualify for showing the spinner, otherwise the spinner would constantly be spinning for all activity. It would be great if the OS automatically managed the network activity indicator, but it is not possible. The OS cannot determine what activity qualifies, as only the application knows for certain what the activity is. [Apple’s documentation](https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplication_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40006728-CH3-SW23) defines when the indicator is shown:
> Display the network activity indicator to provide feedback when your application accesses the network for more than a couple of seconds. If the operation finishes sooner than that, you don’t have to show the network activity indicator, because the indicator would be likely to disappear before users notice its presence.

More information on the iOS status bar and the Network Activity Indicator can be found in the [iOS Human Interface Guidelines](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/MobileHIG.pdf) on pages 138 and 181, respectively.


### What’s happened to it?

The network activity indicator seems to be a forgotten part of iOS. Since the introduction of the iPhone, proper usage has declined. No changes to the API appear to have been made since the first release of the SDK. Many apps do not use this functionality at all anymore. Because of the inconsistent use of this functionality across applications, it’s meaning has been lost on users. Not only is it somewhat unclear what the spinner is for, users can no longer rely on it. Since iOS app developers are also users, the indicator’s meaning has also become unclear to them, making the problem even worse.

Without action, the network indicator is doomed to spirally decline into nothingness. Something must be done to fix this. In order to solve the issue, the origin of the problem must be found.


### Current API

The current API for showing or hiding the spinner is just that. The API allows the app to directly show and hide the spinner. The indicator’s visibility is just a Boolean property of the application:

`
@property(nonatomic, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible
`

This seems pretty simple, right? The app is responsible for turning it on and back off itself.

However, this breaks down when the app has multiple concurrent network connections. After a connection terminates, it may turn off this property on other ongoing network activity. This results in the spinner being prematurely hidden and incorrect.

**Some developers realize the issue.**
However, there has not been a great or consistent way of solving it. Developers may try to avoid the concurrency issue entirely by not using the indicator.

**Some developers don’t realize the issue.**
They use the current API naively and it breaks on the user while using the app.

Regardless of the developer, the user will not find the indicator reliable across their apps and may lose trust in it, forever ignoring it.

The issue does not lie with the developers, it is with the API.

I believe this can be fixed and the downwards trend can be reversed. I created a [category](https://developer.apple.com/library/ios/documentation/general/conceptual/devpedia-cocoacore/Category.html) on `UIApplication` that will make working with it easier.


### Proposed Solution: API Changes

The solution I came up with involves keeping a count of the number of ongoing network activity sessions. This counter is incremented when some network activity starts and decremented when the activity stopped. The indicator is present when more than one request is active (the counter is greater than 1), and hidden when all network activity has stopped (the counter is 0). Now, after telling the application that some networking activity has stopped, the indicator isn’t necessarily hidden.

The changes I made to `UIApplication` is such that it still does two things regarding the networking activity indicator. However, the changes align with what developers may have previously done. The implementation is such that, using the counter, the expected behavior of the spinner is the actual behavior. The new interface is:

	- (void)beganNetworkActivity;
	- (void)endedNetworkActivity;

When initiating or handling the conclusion of relevant network activity, the responsible code tells the application so. The application object is responsible for handling the visibility of the spinner.

The demo app included in the project shows the application being told that some network activity has started and stopped after tapping on a button simulating ongoing network activity.

Ideally, the `networkActivityIndicatorVisible` property could just be removed or set to be read-only. However, because `UIApplication` should remain reasonably backwards compatible, and keep a complete history of the header, it can’t be. I am unsure if part of a property can be deprecated (set from read/write to read-only). Deprecating the `setNetworkActivityIndicatorVisible:` method (the property’s setter) will likely not work because the property is still assumed to be writable. When using dot syntax for the property, the change to the setter method might not be caught.


### Documentation

In addition to the API changes I’ve made, the documentation for when to use the spinner needs to be more clearly defined so that developers know what activity qualifies for the indicator. The documentation should note that the indicator should only be shown during network activity that is affecting the user interface. Some networking tasks, like iCloud syncing, should not be presented to the user via the networking activity indicator.


### Conclusion

This small project will hopefully increase consistent usage of the Networking Activity Indicator. The code is immediately better for developers and will eventually make an impact on the user’s experience with this functionality on iOS.
