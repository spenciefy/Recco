//
//  SYMovieView.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYMovieView.h"
#import "SYMovie.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation SYMovieView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                        withParentFrame:(CGRect)parentFrame
                        movie:(SYMovie *)movie
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame withParentFrame:parentFrame options:options];
    if (self) {
        self.clipsToBounds = YES;
        
        _movie = movie;
        NSLog(@"movie url: %@", _movie.posterImage);
    
        if([_movie.posterImage isEqualToString:@"N/A"]){
            [self.posterImageView setImage:[UIImage imageNamed:@"posterNullState.png"]];
        }else{
            [self.posterImageView setImageWithURL:[NSURL URLWithString:_movie.posterImage]];
        }

        
        //[self.viewButton setBackgroundImageWithURL:[NSURL URLWithString:_movie.posterImage] forState:UIControlStateNormal];
        self.movieTitle.text = _movie.title;
        self.movieMPAARating.text = _movie.mpaaRating;
        
        if(![_movie.criticRating isEqualToNumber:[NSNumber numberWithInt:-1]]){
            self.tomatoRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.criticRating stringValue]];
            if([_movie.criticRating intValue] > 60){
                self.tomatoRatingImage.image = [UIImage imageNamed:@"red_tomato.png"];
            }
            else{
                self.tomatoRatingImage.image = [UIImage imageNamed:@"green_tomato.png"];
            }
        }else{
            self.tomatoRatingLabel.text = @"N/A";
                self.tomatoRatingImage.image = [UIImage imageNamed:@"red_tomato.png"];
        }
        
        if(![_movie.audienceRating isEqualToNumber:[NSNumber numberWithInt:-1]]){
            self.audienceRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.audienceRating stringValue]];
            if([_movie.criticRating intValue] > 60){
                self.audienceRatingImage.image = [UIImage imageNamed:@"popcorn_up.png"];
            }
            else{
                self.audienceRatingImage.image = [UIImage imageNamed:@"popcorn_down.png"];
            }
        }else{
            self.audienceRatingLabel.text = @"N/A";
            self.audienceRatingImage.image = [UIImage imageNamed:@"popcorn_up.png"];
        }
        
        if([_movie.runtime isEqualToString:@""]){
            self.runtimeLabel.text = [NSString stringWithFormat:@"Runtime N/A"];
        }
        else{
            self.runtimeLabel.text = [NSString stringWithFormat:@"%@ minutes", _movie.runtime];
        }
     
        self.genreLabel.text = [_movie.genres firstObject];

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.posterImageView.autoresizingMask = self.autoresizingMask;
    }
    return self;
}

@end
