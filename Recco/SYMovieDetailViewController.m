//
//  SYMovieDetailViewController.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYMovieDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface SYMovieDetailViewController ()

@end

@implementation SYMovieDetailViewController
@synthesize movieObject, posterImageView, tomatoImageView, tomatoRating, audienceImageView, audienceRating, movieLength, rating, synopsis, imdb, rottenTomatoes, detailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationItem.titleView.clipsToBounds = NO;
    self.title = movieObject.title;
    UILabel* tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0,00, 200, 40)];
    tlabel.text = self.navigationItem.title;
    tlabel.textColor= [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
    tlabel.font = [UIFont fontWithName:@"HanSolo" size: 37.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.titleView = tlabel;
    
    //Movie Detail
    //double initialTextViewHeight = synopsis.frame.size.height;
    
    [posterImageView setImageWithURL:[NSURL URLWithString: movieObject.posterImage]];
    
    if([movieObject.criticRating intValue] > 60)
        tomatoImageView.image = [UIImage imageNamed: @"red_tomato.png"];
    else
        tomatoImageView.image = [UIImage imageNamed: @"green_tomato.png"];
    tomatoRating.text = [NSString stringWithFormat: @"%%%i", [movieObject.criticRating intValue]];
    
    if([movieObject.audienceRating intValue] > 60)
        audienceImageView.image = [UIImage imageNamed: @"popcorn_up"];
    else
        audienceImageView.image = [UIImage imageNamed: @"popcorn_down"];
    audienceRating.text = [NSString stringWithFormat: @"%%%i", [movieObject.audienceRating intValue]];
    
    movieLength.text = [NSString stringWithFormat: @"%@ Minutes", movieObject.runtime];
    
    rating.text = [NSString stringWithFormat: @"Rated: %@", movieObject.mpaaRating];
    
    [synopsis setText: movieObject.synopsis];
    [synopsis setFont:[UIFont fontWithName:@"Helvetica" size: 25]];
    CGRect synopFrame = synopsis.frame;
    synopFrame.size.height = [self textViewHeightForAttributedText:movieObject.synopsis andWidth: 320];
    NSLog(@"344q443t4 %f", synopFrame.size.height);
    NSLog(@"errqeqff %f", synopsis.frame.size.height);
    synopsis.frame = synopFrame;
    NSLog(@"errqeqff %f", synopsis.frame.size.height);
    
    CGRect imdbRect = imdb.frame;
    imdbRect.origin.y = synopsis.frame.origin.y + 40;
    imdb.frame = imdbRect;
    CGRect rottenTomatoesRect = rottenTomatoes.frame;
    rottenTomatoesRect.origin.y = synopsis.frame.origin.y + 40;
    rottenTomatoes.frame = rottenTomatoesRect;
    
    CGRect detailViewFrame = detailView.frame;
    NSLog(@"erqqqqqqrqeqff %f", detailView.frame.size.height);
    detailViewFrame.size.height *=2;
    detailView.frame = detailViewFrame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    


}

- (CGFloat)textViewHeightForAttributedText: (NSString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setText: text];
    [calculationView setFont:[UIFont fontWithName:@"Helvetica" size: 25]];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
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
