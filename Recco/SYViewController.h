//
//  SYViewController.h
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMovieView.h"
#import "MDCSwipeToChooseDelegate.h"
#import "MDCSwipeToChooseView.h"
#import "SYMovie.h"

typedef void (^completion)(BOOL);

@interface SYViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) SYMovie *currentMovie;
@property (nonatomic, strong) SYMovieView *frontCardView;
@property (nonatomic, strong) SYMovieView *backCardView;

- (void)getRandomMoviesFor:(NSUInteger)numberOfMovies completionBlock:(void (^)(BOOL success))completionBlock;

@end
