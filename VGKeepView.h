//
//  VGKeepView.h
//  VGAnimation
//
//  Created by Admin on 4/21/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VGKeepView : NSObject <NSCopying>

@property (strong, nonatomic) UIView* view;
- (instancetype)initWithView:(UIView*) inView;

@end
