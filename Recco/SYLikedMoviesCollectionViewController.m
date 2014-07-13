//
//  SYLikedMoviesCollectionViewController.m
//  Recco
//
//  Created by Cluster 5 on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYLikedMoviesCollectionViewController.h"
#import "SYData.h"
#import "SYMovie.h"
#import "UIImageView+WebCache.h"
#import "SYMovieDetailViewController.h"

@implementation SYLikedMoviesCollectionViewController
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
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"Recco" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editLiked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    SYData *syData = [SYData sharedManager];
    likedMovies = syData.likedMovies;
    
    isDeleteActive = FALSE;
}

- (void)viewDidAppear:(BOOL)animated {

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [likedMovies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MovieCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    SYMovie *movie = [likedMovies objectAtIndex: indexPath.row];
    
    UIImageView *movieImage = (UIImageView *)[cell viewWithTag: 1];
    if([movieObject.posterImage isEqualToString:@"N/A"]){
        [movieImage setImage:[UIImage imageNamed:@"posterNullState.png"]];
    }else{
        [movieImage setImageWithURL:[NSURL URLWithString: movie.posterImage]];
    }
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(isDeleteActive){
        selectedIndexPath = indexPath.row;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this movie from your liked movies?" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
        [alert show];
    } else {
        movieObject = [likedMovies objectAtIndex: indexPath.row];
        [self performSegueWithIdentifier:@"pushDetailFromLiked" sender:self];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        SYData *syData = [SYData sharedManager];
        [syData.likedMovies removeObjectAtIndex: selectedIndexPath];
        [self.collectionView performBatchUpdates:^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        } completion:nil];
 
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:syData.likedMovies];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"likedMovies"];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pushDetailFromLiked"]){
        SYMovieDetailViewController *detailVC = segue.destinationViewController;
        detailVC.movie = movieObject;
    }
}

- (void)editLiked {
    if(!isDeleteActive){
        rightButton.title = @"View";
        isDeleteActive = TRUE;
    }else{
        rightButton.title = @"Edit";
        isDeleteActive = FALSE;
    }
}

@end
