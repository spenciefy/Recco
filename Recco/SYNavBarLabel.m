//
//  SYNavBarLabel.m
//  Recco
//
//  Created by Spencer Yen on 7/12/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYNavBarLabel.h"

@implementation SYNavBarLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:CGRectMake(30, 0, self.superview.bounds.size.width-60, self.superview.bounds.size.height)];
}

@end
