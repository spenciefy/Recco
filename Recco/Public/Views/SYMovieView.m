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

@implementation SYMovieView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                        movie:(SYMovie *)movie
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        self.clipsToBounds = YES;
        
        _movie = movie;
        [self.posterImageView setImageWithURL:[NSURL URLWithString:_movie.posterImage]];
        self.movieTitle.text = _movie.title;
        self.movieMPAARating.text = _movie.mpaaRating;
        self.audienceRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.audienceRating stringValue]];
        self.tomatoRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.criticRating stringValue]];
        if([_movie.criticRating intValue] > 60){
            self.tomatoRatingImage.image = [UIImage imageNamed:@"red_tomato.png"];
        }
        else{
            self.tomatoRatingImage.image = [UIImage imageNamed:@"green_tomato.png"];
        }
        if([_movie.audienceRating intValue]> 60){
            self.audienceRatingImage.image = [UIImage imageNamed:@"popcorn_up.png"];
        }
        else{
            self.audienceRatingImage.image = [UIImage imageNamed:@"popcorn_down.png"];
        }
        self.runtimeLabel.text = [NSString stringWithFormat:@"%@ minutes", _movie.runtime];
     
        //self.genreLabel.text = [_movie.genres componentsJoinedByString:@", "];
        self.genreLabel.text = [_movie.genres firstObject];
        //self.genreLabel.text = [NSString stringWithFormat:@"%@, %@", [_movie.genres firstObject], [_movie.genres objectAtIndex:1]];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.posterImageView.autoresizingMask = self.autoresizingMask;
    }
    return self;
}

@end
