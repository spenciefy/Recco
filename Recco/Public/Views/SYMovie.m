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
                        rtURL:(NSString *)rtURL
                        IMDBURL:(NSString *)IMDBURL{
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
        _IMDBURL = IMDBURL;
    }
    return self;
}

#pragma mark - NSCoding

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.movieID forKey:@"movieID"];
    [encoder encodeObject:self.posterImage forKey:@"posterImage"];
    [encoder encodeObject:self.mpaaRating forKey:@"mpaaRating"];
    [encoder encodeObject:self.criticRating forKey:@"criticRating"];
    [encoder encodeObject:self.audienceRating forKey:@"audienceRating"];
    [encoder encodeObject:self.runtime forKey:@"runtime"];
    [encoder encodeObject:self.genres forKey:@"genres"];
    [encoder encodeObject:self.synopsis forKey:@"synopsis"];
    [encoder encodeObject:self.rtURL forKey:@"rtURL"];
    [encoder encodeObject:self.IMDBURL forKey:@"IMDBURL"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.movieID = [decoder decodeObjectForKey:@"movieID"];
    self.posterImage = [decoder decodeObjectForKey:@"posterImage"];
    self.mpaaRating = [decoder decodeObjectForKey:@"mpaaRating"];
    self.criticRating = [decoder decodeObjectForKey:@"criticRating"];
    self.audienceRating = [decoder decodeObjectForKey:@"audienceRating"];
    self.runtime = [decoder decodeObjectForKey:@"runtime"];
    self.genres = [decoder decodeObjectForKey:@"genres"];
    self.synopsis = [decoder decodeObjectForKey:@"synopsis"];
    self.rtURL = [decoder decodeObjectForKey:@"rtURL"];
    self.IMDBURL = [decoder decodeObjectForKey:@"IMDBURL"];
    
    return self;
}

@end