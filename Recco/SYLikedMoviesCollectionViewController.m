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
    
    SYData *syData = [SYData sharedManager];
    likedMovies = syData.likedMovies;
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
    [movieImage setImageWithURL:[NSURL URLWithString: movie.posterImage]];
    
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
