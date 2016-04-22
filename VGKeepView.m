//
//  VGKeepView.m
//  VGAnimation
//
//  Created by Admin on 4/21/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import "VGKeepView.h"

@implementation VGKeepView 

- (instancetype)initWithView:(UIView*) inView
{
    self = [super init];
    if (self) {
        self.view = inView;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;

}

@end


