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

@property (nonatomic, strong) SYMovie *movie;

@property (weak, nonatomic) IBOutlet UIScrollView *movieScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@property (weak, nonatomic) IBOutlet UILabel *mpaaRatingLabel;

@property (weak, nonatomic) IBOutlet UILabel *criticRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceRatingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *criticImage;
@property (weak, nonatomic) IBOutlet UIImageView *audienceImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTimeLabel;

@property (weak, nonatomic) IBOutlet UITextView *movieGenresTextView;
@property (weak, nonatomic) IBOutlet UITextView *movieSynopsisTextView;


@end
