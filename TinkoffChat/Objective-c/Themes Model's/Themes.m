//
//  Themes.m
//  TinkoffChat
//
//  Created by Konstantin on 04/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Themes.h"

@implementation Themes

- (instancetype) initFirstTheme:(UIColor *)lightColor secondTheme:(UIColor *)blueColor thirdTheme:(UIColor *)blackColor {
    if (self = [super init]) {
        self.lightColor = lightColor;
        self.blueColor = blueColor;
        self.blackColor = blackColor;
    }
    return self;
}

- (void) dealloc {
    [_lightColor release];
    [_blueColor release];
    [_blackColor release];
    
    [super dealloc];
}

- (UIColor *)lightColor {
    return _lightColor;
        
    }
- (void)setLightColor:(UIColor *)lightColor {
    if (_lightColor != lightColor) {
        [_lightColor release];
        _lightColor = [lightColor retain];
    }
}

- (UIColor *)blueColor {
    return _blueColor;
}

- (void)setBlueColor:(UIColor *)blueColor {
    if (_blueColor != blueColor) {
        [_blueColor release];
        _blueColor = [blueColor retain];
    }
}


- (UIColor *)blackColor {
    return _blackColor;
}

- (void)setBlackColor:(UIColor *)blackColor {
    if (_blackColor != blackColor) {
        [_blackColor release];
        _blackColor = [blackColor retain];
    }
}

@end
