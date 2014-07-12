//
//  SYMovieDetailViewController.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYMovieDetailViewController.h"

#import "SYMovie.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface SYMovieDetailViewController ()
@end

@implementation SYMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationItem.titleView.clipsToBounds = NO;
    self.title = _movie.title;
    UILabel* tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0,00, 200, 40)];
    tlabel.text = self.navigationItem.title;
    tlabel.textColor= [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
    tlabel.font = [UIFont fontWithName:@"HanSolo" size: 37.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView=tlabel;
    
    if([_movie.posterImage isEqualToString:@"N/A"]){
        [self.posterImageView setImage:[UIImage imageNamed:@"posterNullState.png"]];
    }else{
        [self.posterImageView setImageWithURL:[NSURL URLWithString:_movie.posterImage]];
    }
    [self.mpaaRatingLabel setText:_movie.mpaaRating];
    if(![_movie.criticRating isEqualToNumber:[NSNumber numberWithInt:-1]]){
        self.criticRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.criticRating stringValue]];
        if([_movie.criticRating intValue] > 60){
            self.criticImage.image = [UIImage imageNamed:@"red_tomato.png"];
        }
        else{
            self.criticImage.image = [UIImage imageNamed:@"green_tomato.png"];
        }
    }else{
        self.criticRatingLabel.text = @"N/A";
        self.criticImage.image = [UIImage imageNamed:@"red_tomato.png"];
    }
    
    if(![_movie.audienceRating isEqualToNumber:[NSNumber numberWithInt:-1]]){
        self.audienceRatingLabel.text = [NSString stringWithFormat:@"%@%%",[_movie.audienceRating stringValue]];
        if([_movie.criticRating intValue] > 60){
            self.audienceImage.image = [UIImage imageNamed:@"popcorn_up.png"];
        }
        else{
            self.audienceImage.image = [UIImage imageNamed:@"popcorn_down.png"];
        }
    }else{
        self.audienceRatingLabel.text = @"N/A";
        self.audienceImage.image = [UIImage imageNamed:@"popcorn_up.png"];
    }
    
    if([_movie.runtime isEqualToString:@""]){
        self.movieTimeLabel.text = [NSString stringWithFormat:@"Runtime N/A"];
    }
    else{
        self.movieTimeLabel.text = [NSString stringWithFormat:@"%@ minutes", _movie.runtime];
    }
    
    self.movieGenresTextView.text = [_movie.genres componentsJoinedByString:@" "];
    [self.movieGenresTextView sizeToFit];
//   
//    [self.movieSynopsisTextView sizeToFit];
//    [self.movieSynopsisTextView layoutIfNeeded];
//    
    CGRect frame = self.movieSynopsisTextView.frame;
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:14];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    self.movieSynopsisTextView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self textViewHeightForAttributedText:[[NSAttributedString alloc]initWithString:_movie.synopsis attributes:attributes] andWidth:frame.size.width]);
    
     self.movieSynopsisTextView.text = _movie.synopsis;
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    NSLog(@"calculated size.height: %f", size.height);
    return size.height;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [_movieScrollView setContentOffset:CGPointMake(0,0)];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
