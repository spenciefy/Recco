//
//  SYMovieDetailViewController.h
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMovie.h"

@interface SYMovieDetailViewController : UIViewController
@property (nonatomic, retain) SYMovie *movieObject;
@property (strong, nonatomic) IBOutlet UIImageView *posterImageView;
@property (strong, nonatomic) IBOutlet UIImageView *tomatoImageView;
@property (strong, nonatomic) IBOutlet UILabel *tomatoRating;
@property (strong, nonatomic) IBOutlet UIImageView *audienceImageView;
@property (strong, nonatomic) IBOutlet UILabel *audienceRating;
@property (strong, nonatomic) IBOutlet UILabel *movieLength;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UITextView *synopsis;
@property (strong, nonatomic) IBOutlet UIButton *imdb;
@property (strong, nonatomic) IBOutlet UIButton *rottenTomatoes;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end
