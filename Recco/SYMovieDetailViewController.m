//
//  SYMovieDetailViewController.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYMovieDetailViewController.h"
#import "SYNavBarLabel.h"
#import "SYMovie.h"
#import "UIImageView+WebCache.h"
#import "SVWebViewController.h"
#import "SVProgressHUD.h"

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

    self.movieScrollView.delegate = self;

    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD show];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];

    self.navigationController.navigationItem.titleView.clipsToBounds = NO;
    self.title = _movie.title;
    SYNavBarLabel* tlabel=[[SYNavBarLabel alloc] init];
    tlabel.text = self.navigationItem.title;
    tlabel.textColor= [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
    tlabel.font = [UIFont fontWithName:@"HanSolo" size: 30.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth=YES;
    [tlabel sizeToFit];
    [tlabel setTextAlignment:NSTextAlignmentCenter];
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
    
    self.movieGenresTextView.text = [_movie.genres componentsJoinedByString:@"\n"];
    [self.movieGenresTextView sizeToFit];
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:text];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.movieSynopsisTextView setScrollEnabled:NO];
    CGRect frame = self.movieSynopsisTextView.frame;
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:14];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    self.rtButton.frame = CGRectMake(self.rtButton.frame.origin.x, frame.origin.y + [self textViewHeightForAttributedText:[[NSAttributedString alloc]initWithString:_movie.synopsis attributes:attributes] andWidth:frame.size.width] + 10, self.rtButton.frame.size.width, self.rtButton.frame.size.height);
    
    self.imdbButton.frame = CGRectMake(self.imdbButton.frame.origin.x, self.rtButton.frame.origin.y + 55, self.imdbButton.frame.size.width, self.imdbButton.frame.size.height);

    self.movieSynopsisTextView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self textViewHeightForAttributedText:[[NSAttributedString alloc]initWithString:_movie.synopsis attributes:attributes] andWidth:frame.size.width]);
    self.movieSynopsisTextView.text = _movie.synopsis;
    
    self.imdbButton.hidden = NO;
    self.rtButton.hidden = NO;
    
    [SVProgressHUD dismiss];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.movieScrollView.contentSize = self.contentView.frame.size;
}

-(IBAction)viewInRottenTomatoes:(id)sender{
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:_movie.rtURL];
    [self presentViewController:webViewController animated:YES completion:nil];
}

-(IBAction)viewInIMDB:(id)sender{
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[NSString stringWithFormat:@"http://imdb.com/title/tt%@", _movie.IMDBURL]];
    
    [self presentViewController:webViewController animated:YES completion:nil];
}

@end
