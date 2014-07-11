//
//  SYData.h
//  Recco
//
//  Created by Cluster 5 on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYData : NSObject
@property (nonatomic, retain) NSMutableArray* likedMovies;
@property (nonatomic, retain) NSMutableArray* displayedMovies;
+ (id)sharedManager;

@end
