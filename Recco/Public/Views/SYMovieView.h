//
//  SYMovieView.h
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDCSwipeToChooseView.h"
#import "MDCSwipeToChoose.h"

@class SYMovie;

@interface SYMovieView : MDCSwipeToChooseView

@property (nonatomic, strong, readonly) SYMovie *movie;

- (instancetype)initWithFrame:(CGRect)frame
              withParentFrame:(CGRect)parentFrame
                        movie:(SYMovie *)movie
                      options:(MDCSwipeToChooseViewOptions *)options;

@end