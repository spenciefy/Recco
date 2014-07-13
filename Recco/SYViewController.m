//
//  SYViewController.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYViewController.h"
#import "SYData.h"
#import "SYMovieDetailViewController.h"
#import "SVProgressHUD.h"

#define kAPI_KEY @"zsjdduvb57m6g4gjys4hyyub"

@interface SYViewController ()
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSMutableArray *displayedMovies;

@property (nonatomic, strong) SVProgressHUD *progressHUD;
@end

@implementation SYViewController

#pragma mark - Object Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        // This view controller maintains a list of SYMovieView
        // instances to display.
       
    }
    return self;
}
#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    SYData *syData = [SYData sharedManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *likedMovies = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"likedMovies"]];
    if([likedMovies count]){
    syData.likedMovies = [likedMovies mutableCopy];
    }
    _movies = [[NSMutableArray alloc] init];
    _displayedMovies = [[NSMutableArray alloc] init];
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD show];
    [self getRandomMoviesFor:5 completionBlock:^(BOOL success) {
        if(success){
            [SVProgressHUD dismiss];
            self.frontCardView = [self popMovieViewWithFrame:[self frontCardViewFrame]];
            [self.view addSubview:self.frontCardView];
            
            self.backCardView = [self popMovieViewWithFrame:[self backCardViewFrame]];
            [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
            
        }
    }];
   
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - MDCSwipeToChooseDelegate Protocol Methods

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    SYData *syData = [SYData sharedManager];
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You noped %@.", self.currentMovie.title);
        
    } else {
        NSLog(@"You liked %@", self.currentMovie.title);
        [syData.likedMovies addObject:self.currentMovie];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:syData.likedMovies];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"likedMovies"];
        
    
        [self addMovieRecommendationForMovie:self.currentMovie.movieID];
    }
    
    if([self.movies count] <= 3){
        [self getRandomMoviesFor:3 completionBlock:^(BOOL success){
         }];
    }
    
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popMovieViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 1.f;
                         } completion:^(BOOL finished) {
                             [_displayedMovies addObject: self.currentMovie.movieID];
                             NSLog(@"displayed movies %@", self.displayedMovies);
                         }];
        
    }
    
 
}

-(void) viewWasTapped:(UIView *)view{
    [self performSegueWithIdentifier:@"pushDetailFromMain" sender:self];
}

-(void)addMovieRecommendationForMovie:(NSString *)movieID {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/similar.json?apikey=%@&limit=5",movieID,kAPI_KEY]]];
    NSLog(@"request to get reccos: %@", [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/similar.json?apikey=%@&limit=5",movieID,kAPI_KEY]);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *movies = [[NSMutableArray alloc]init];
        movies = [[object objectForKey:@"movies"]mutableCopy];
        if([movies count] > 0){
        for (int i = 0; i < [movies count]; ++i) {
            int nElements = [movies count] - i;
            int n = (arc4random() % nElements) + i;
            [movies exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        for(int i = 0; i < [movies count]; i++){
            NSDictionary *movieDict = [movies objectAtIndex:i];
           
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.omdbapi.com/?i=tt%@", [[movieDict objectForKey:@"alternate_ids"]objectForKey:@"imdb" ]]]]
                                  options:kNilOptions
                                  error:&error];
            SYMovie *movie = [[SYMovie alloc]initWithTitle:[movieDict objectForKey:@"title"] movieID:[movieDict objectForKey:@"id"] posterImage:[json objectForKey:@"Poster"] mpaaRating:[movieDict objectForKey:@"mpaa_rating"] criticRating:[[movieDict objectForKey:@"ratings"] objectForKey:@"critics_score"] audienceRating:[[movieDict objectForKey:@"ratings"] objectForKey:@"audience_score"]  runtime:[NSString stringWithFormat:@"%@",[movieDict objectForKey:@"runtime"]] genres:[[json objectForKey:@"Genre"] componentsSeparatedByString:@", "] synopysis:[movieDict objectForKey:@"synopsis"] rtURL:[[movieDict objectForKey:@"links"]objectForKey:@"alternate"] IMDBURL:[[movieDict objectForKey:@"alternate_ids"]objectForKey:@"imdb" ]];
            NSLog(@"self.displayedmovies: %@", self.displayedMovies);
#warning this should technically be here but then we will run out of movies to display and that is no no
         //   if(![self.displayedMovies containsObject:movie.movieID]){
                 NSLog(@"adding: %@", [movieDict objectForKey:@"title"]);
                [self.movies addObject:movie];
         //   }
            }
        }else{
            NSLog(@"tried to get recommended movies but zero suggestions");
        }
    }];
}
#pragma mark - Internal Methods

- (void)setFrontCardView:(SYMovieView *)frontCardView {
    // Keep track of the Movie currently being chosen.
    // Quick and dirty, just for the purposes of this sample app.
    _frontCardView = frontCardView;
    self.currentMovie = frontCardView.movie;
}

- (void)getRandomMoviesFor:(NSUInteger)numberOfMovies completionBlock:(void (^)(BOOL success))completionBlock{
    
        NSString *url = @"";
        switch (arc4random() % 6) {
            case 0:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@&limit=50",kAPI_KEY];
                break;
            case 1:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@&page_limit=50",kAPI_KEY];
                break;
            case 2:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?apikey=%@&limit=50",kAPI_KEY];
                 break;
            case 3:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&limit=50",kAPI_KEY];
                 break;
            case 4:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json?apikey=%@&page_limit=50",kAPI_KEY];
                 break;
            case 5:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=%@&page_limit=50",kAPI_KEY];
                 break;
            case 6:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/upcoming.json?apikey=apikey=%@&&page_limit=50",kAPI_KEY];
                break;
            default:
                url = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/new_releases.json?apikey=%@&limit=50",kAPI_KEY];
                break;
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *movies = [[NSMutableArray alloc]init];
            
            movies = [[object objectForKey:@"movies"]mutableCopy];
            if([movies count] > 0){
            for (int i = 0; i < [movies count]; ++i) {
                int nElements = [movies count] - i;
                int n = (arc4random() % nElements) + i;
                [movies exchangeObjectAtIndex:i withObjectAtIndex:n];
            }
            for(int i = 0; i < numberOfMovies; i++){
                NSDictionary *movieDict = [movies objectAtIndex:i];
 
                NSError* error;
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.omdbapi.com/?i=tt%@", [[movieDict objectForKey:@"alternate_ids"]objectForKey:@"imdb" ]]]]
                                      options:kNilOptions
                                      error:&error];
                
                SYMovie *movie = [[SYMovie alloc]initWithTitle:[movieDict objectForKey:@"title"] movieID:[movieDict objectForKey:@"id"] posterImage:[json objectForKey:@"Poster"] mpaaRating:[movieDict objectForKey:@"mpaa_rating"] criticRating:[[movieDict objectForKey:@"ratings"] objectForKey:@"critics_score"] audienceRating:[[movieDict objectForKey:@"ratings"] objectForKey:@"audience_score"]  runtime:[NSString stringWithFormat:@"%@",[movieDict objectForKey:@"runtime"]] genres:[[json objectForKey:@"Genre"] componentsSeparatedByString:@", "] synopysis:[movieDict objectForKey:@"synopsis"] rtURL:[[movieDict objectForKey:@"links"]objectForKey:@"alternate"] IMDBURL:[[movieDict objectForKey:@"alternate_ids"]objectForKey:@"imdb" ]];
                #warning this should technically be here but then we will run out of movies to display and that is no no
               // if(![self.displayedMovies containsObject:movie.movieID]){
                    NSLog(@"adding: %@", [movieDict objectForKey:@"title"]);
                    [self.movies addObject:movie];
              //  }
            }
            }
            else{
                NSLog(@"No results for random, url: %@", url);
            }
            completionBlock(YES);
        }];
   
}


- (SYMovieView *)popMovieViewWithFrame:(CGRect)frame {
    if ([self.movies count] == 0) {
        return nil;
    }
    
  
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.threshold = 160.f;
    options.onPan = ^(MDCPanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 10.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };
    
    // Create a MovieView with the top Movie in the people array, then pop
    // that Movie off the stack.
    SYMovieView *MovieView = [[SYMovieView alloc] initWithFrame:frame
                                                withParentFrame:self.view.frame
                                                    movie:self.movies[0]
                                                    options:options];
    [self.movies removeObjectAtIndex:0];
    return MovieView;
}

#pragma mark View Contruction

- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 80.f;
    CGFloat bottomPadding = 100.f;

    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}

- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 10.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

#pragma mark Control Events

// Programmatically "nopes" the front card view.
- (void)nopeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}

// Programmatically "likes" the front card view.
- (void)likeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pushDetailFromMain"]){
    SYMovieDetailViewController *detailVC = segue.destinationViewController;
    detailVC.movie = _currentMovie;
    }
}

@end

