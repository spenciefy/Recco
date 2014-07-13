//
//  SYLikedMoviesCollectionViewController.h
//  Recco
//
//  Created by Cluster 5 on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMovie.h"

@interface SYLikedMoviesCollectionViewController : UICollectionViewController {
    NSMutableArray* likedMovies;
    SYMovie *movieObject;
    UIBarButtonItem *rightButton;
    BOOL isDeleteActive;
    int selectedIndexPath;
}

@end
