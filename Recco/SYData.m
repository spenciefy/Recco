//
//  SYData.m
//  Recco
//
//  Created by Cluster 5 on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYData.h"

@implementation SYData
@synthesize displayedMovies, likedMovies;

+ (id)sharedManager {
    static SYData *syData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        syData = [[self alloc] init];
    });
    return syData;
}

- (id)init {
    if (self = [super init]) {
        likedMovies = [[NSMutableArray alloc] init];
        displayedMovies = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
