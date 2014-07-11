//
//  MDCSwipeToChooseDelegate.h
//  MDCSwipeToChoose
//
//  Created by Brian Ivan Gesiak on 4/8/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDCSwipeDirection.h"

/*!
 * Classes that adopt the `MDCSwipeToChooseDelegate` protcol may respond to
 * swipe events, such as when a view has been swiped and chosen, or when a
 * swipe has been cancelled and no choice has been made.
 *
 * To customize the animation and appearance of a MDCSwipeToChoose-based view,
 * use `MDCSwipeOptions` and the `-mdc_swipeToChooseSetup:` method.
 */
@protocol MDCSwipeToChooseDelegate <NSObject>
@optional

- (void)viewDidCancelSwipe:(UIView *)view;

- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction;

- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction;

- (void)viewWasTapped:(UIView *)view;


@end
