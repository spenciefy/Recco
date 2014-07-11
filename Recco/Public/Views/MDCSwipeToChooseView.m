//
// MDCSwipeToChooseView.m
//
// Copyright (c) 2014 to present, Brian Gesiak @modocache
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "MDCSwipeToChooseView.h"
#import "MDCSwipeToChoose.h"
#import "MDCGeometry.h"
#import "UIView+MDCBorderedLabel.h"
#import "UIColor+MDCRGB8Bit.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "MDCSwipeToChooseDelegate.h"

static CGFloat const MDCSwipeToChooseViewHorizontalPadding = 10.f;
static CGFloat const MDCSwipeToChooseViewTopPadding = 20.f;
static CGFloat const MDCSwipeToChooseViewLabelWidth = 65.f;

@interface MDCSwipeToChooseView ()
@property (nonatomic, strong) MDCSwipeToChooseViewOptions *options;
@end

@implementation MDCSwipeToChooseView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame];
    if (self) {
        _options = options ? options : [MDCSwipeToChooseViewOptions new];
        [self setupViews];
        [self constructLikedView];
        [self constructNopeImageView];
        [self setupSwipeToChoose];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5.f;
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = [UIColor colorWith8BitRed:220.f
                                                 green:220.f
                                                  blue:220.f
                                                 alpha:1.f].CGColor;
    
    _posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 400)];
    _posterImageView.clipsToBounds = YES;
    [self addSubview:_posterImageView];
    
    _viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _viewButton.frame = CGRectMake(0, 0, 280, 400);

    [_viewButton addTarget:self action:@selector(viewTapped:) forControlEvents:UIControlEventTouchUpInside];
    _viewButton.clipsToBounds = YES;
    [self addSubview:_viewButton];
    
    
    _movieMPAARating = [[UILabel alloc] initWithFrame:CGRectMake(_posterImageView.frame.size.width-60, 0, 60, 30)];
    _movieMPAARating.backgroundColor = [UIColor grayColor];
    _movieMPAARating.textAlignment = NSTextAlignmentCenter;
    _movieMPAARating.textColor = [UIColor whiteColor];
    _movieMPAARating.alpha = 0.6;
    _movieMPAARating.font = [UIFont boldSystemFontOfSize:15];
    [_posterImageView addSubview:_movieMPAARating];
    
    _runtimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _runtimeLabel.backgroundColor = [UIColor grayColor];
    _runtimeLabel.textAlignment = NSTextAlignmentCenter;
    _runtimeLabel.textColor = [UIColor whiteColor];
    _runtimeLabel.alpha = 0.6;
    _runtimeLabel.font = [UIFont boldSystemFontOfSize:15];
    [_posterImageView addSubview:_runtimeLabel];
    
    _movieInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, _posterImageView.frame.size.height, _posterImageView.frame.size.width, 68)];
    _movieInfoView.backgroundColor = [UIColor whiteColor];
    _movieInfoView.clipsToBounds = YES;
    [self addSubview:_movieInfoView];
    
    _movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(7, 2, _movieInfoView.frame.size.width - 15, 30)];
    _movieTitle.textAlignment = NSTextAlignmentLeft;
    _movieTitle.textColor = [UIColor darkGrayColor];
    _movieTitle.font = [UIFont systemFontOfSize:20];
    _movieTitle.adjustsFontSizeToFitWidth = YES;
    [_movieInfoView addSubview:_movieTitle];
    
    _tomatoRatingImage = [[UIImageView alloc]initWithFrame:CGRectMake(7, _movieTitle.frame.size.height + 3, 28, 28)];
    [_movieInfoView addSubview:_tomatoRatingImage];
    
    _tomatoRatingLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tomatoRatingImage.frame.origin.x+_tomatoRatingImage.frame.size.width + 5 , _movieTitle.frame.size.height + 3, 40, 28)];
    _tomatoRatingLabel.textColor = [UIColor darkGrayColor];
    _tomatoRatingLabel.font = [UIFont systemFontOfSize:13];
    _tomatoRatingLabel.textAlignment = NSTextAlignmentLeft;
    [_movieInfoView addSubview:_tomatoRatingLabel];
    
    _audienceRatingImage = [[UIImageView alloc]initWithFrame:CGRectMake(_tomatoRatingLabel.frame.origin.x + _tomatoRatingLabel.frame.size.width , _movieTitle.frame.size.height + 3, 28, 28)];
    [_movieInfoView addSubview:_audienceRatingImage];
    
    _audienceRatingLabel = [[UILabel alloc]initWithFrame:CGRectMake(_audienceRatingImage.frame.origin.x + _audienceRatingImage.frame.size.width + 5, _movieTitle.frame.size.height + 3, 40, 28)];
    _audienceRatingLabel.textColor = [UIColor darkGrayColor];
    _audienceRatingLabel.font = [UIFont systemFontOfSize:13];
    _audienceRatingLabel.textAlignment = NSTextAlignmentLeft;
    [_movieInfoView addSubview:_audienceRatingLabel];
    
    _genreLabel = [[UILabel alloc]initWithFrame:CGRectMake(_movieInfoView.frame.size.width - 140, _movieTitle.frame.size.height+2, 130, 30)];
    _genreLabel.textAlignment = NSTextAlignmentRight;
    _genreLabel.font = [UIFont systemFontOfSize:15];
    _genreLabel.textColor = [UIColor grayColor];
    [_movieInfoView addSubview:_genreLabel];
    
    [self bringSubviewToFront:_viewButton];
    
}

- (void)constructLikedView {
    CGRect frame = CGRectMake(MDCSwipeToChooseViewHorizontalPadding,
                              MDCSwipeToChooseViewTopPadding,
                              CGRectGetMidX(_viewButton.bounds),
                              MDCSwipeToChooseViewLabelWidth);
    self.likedView = [[UIView alloc] initWithFrame:frame];
    [self.likedView constructBorderedLabelWithText:self.options.likedText
                                             color:self.options.likedColor
                                             angle:self.options.likedRotationAngle];
    self.likedView.alpha = 0.f;
    [self.viewButton addSubview:self.likedView];
}

- (void)constructNopeImageView {
    CGFloat width = CGRectGetMidX(self.posterImageView.bounds);
    CGFloat xOrigin = CGRectGetMaxX(_viewButton.bounds) - width - MDCSwipeToChooseViewHorizontalPadding;
    self.nopeView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin,
                                                                  MDCSwipeToChooseViewTopPadding,
                                                                  width,
                                                                  MDCSwipeToChooseViewLabelWidth)];
    [self.nopeView constructBorderedLabelWithText:self.options.nopeText
                                            color:self.options.nopeColor
                                            angle:self.options.nopeRotationAngle];
    self.nopeView.alpha = 0.f;
    [self.viewButton addSubview:self.nopeView];
}

- (void)setupSwipeToChoose {
    MDCSwipeOptions *options = [MDCSwipeOptions new];
    options.delegate = self.options.delegate;
    options.threshold = self.options.threshold;

    __block UIView *likedImageView = self.likedView;
    __block UIView *nopeImageView = self.nopeView;
    __weak MDCSwipeToChooseView *weakself = self;
    options.onPan = ^(MDCPanState *state) {
        if (state.direction == MDCSwipeDirectionNone) {
            likedImageView.alpha = 0.f;
            nopeImageView.alpha = 0.f;
        } else if (state.direction == MDCSwipeDirectionLeft) {
            likedImageView.alpha = 0.f;
            nopeImageView.alpha = state.thresholdRatio;
        } else if (state.direction == MDCSwipeDirectionRight) {
            likedImageView.alpha = state.thresholdRatio;
            nopeImageView.alpha = 0.f;
        }

        if (weakself.options.onPan) {
            weakself.options.onPan(state);
        }
    };

    [self mdc_swipeToChooseSetup:options];
}

- (void)viewTapped:(id)sender{
    id<MDCSwipeToChooseDelegate> delegate = _options.delegate;
    if ([delegate respondsToSelector:@selector(viewDidCancelSwipe:)]) {
        [delegate viewWasTapped:self];;
    }
}

@end
