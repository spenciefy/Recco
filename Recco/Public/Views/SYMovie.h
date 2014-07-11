//
//  SYMovie.h
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYMovie : NSObject

@property (nonatomic, copy) NSString *movieID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *posterImage;
@property (nonatomic, copy) NSString *mpaaRating;
@property (nonatomic, copy) NSNumber *criticRating;
@property (nonatomic, copy) NSNumber *audienceRating;
@property (nonatomic, copy) NSString *runtime;


- (instancetype)initWithTitle:(NSString *)title
                      movieID:(NSString *)movieID
                  posterImage:(NSString *)posterImage
                   mpaaRating:(NSString *)mpaaRating
                 criticRating:(NSNumber *)criticRating
               audienceRating:(NSNumber *)audienceRating
                       runtime:(NSString *)runtime;

@end
