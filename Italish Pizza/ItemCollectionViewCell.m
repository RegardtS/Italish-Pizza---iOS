//
//  ItemCollectionViewCell.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/17.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@implementation ItemCollectionViewCell

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5;
        self.btnDelete.hidden = NO;
    }else {
        self.alpha = 1.f;
        self.btnDelete.hidden = YES;
    }
}

@end
