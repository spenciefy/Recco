//
//  SYMovie.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYMovie.h"

@implementation SYMovie

#pragma mark - Object Lifecycle

- (instancetype)initWithTitle:(NSString *)title
                      movieID:(NSString *)movieID
                  posterImage:(NSString *)posterImage
                   mpaaRating:(NSString *)mpaaRating
                 criticRating:(NSNumber *)criticRating
               audienceRating:(NSNumber *)audienceRating
                      runtime:(NSString *)runtime
                       genres:(NSArray *)genres
                    synopysis:(NSString *)synopsis
                        rtURL:(NSString *)rtURL {
    self = [super init];
    if (self) {
        _title = title;
        _movieID = movieID;
        _posterImage = posterImage;
        _mpaaRating = mpaaRating;
        _criticRating = criticRating;
        _audienceRating = audienceRating;
        _runtime = runtime;
        _genres = genres;
        _synopsis = synopsis;
        _rtURL = rtURL;
    }
    return self;
}

@end