//
//  ETFoursquareImages.m
//  ETFoursquareImagesDemo
//
//  Created by Eugene Trapeznikov on 11/21/13.
//  Copyright (c) 2013 Eugene Trapeznikov. All rights reserved.
//

#import "ETFoursquareImages.h"

@implementation ETFoursquareImages

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setImages:(NSArray *)_imagesArray{
    if (_imagesArray.count != 0) {
        //images
        imagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,imagesHeight)];
        imagesScrollView.backgroundColor = [UIColor whiteColor];
        imagesScrollView.canCancelContentTouches = NO;
        imagesScrollView.showsHorizontalScrollIndicator = NO;
        imagesScrollView.showsVerticalScrollIndicator = NO;
        imagesScrollView.bounces = NO;
        imagesScrollView.delegate = self;
        imagesScrollView.clipsToBounds = YES;
        imagesScrollView.scrollEnabled = YES;
        imagesScrollView.pagingEnabled = YES;
        
        for (int i=0;i<_imagesArray.count;i++){
            UIImage *image = [_imagesArray objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, imagesHeight)];
            [imageView setImage:image];
            [imagesScrollView addSubview:imageView];
        }
        imagesScrollView.contentSize = CGSizeMake(_imagesArray.count * self.frame.size.width, imagesHeight);
        [self addSubview:imagesScrollView];
    }
}

-(void)setImagesHeight:(int)_imagesHeight{
    imagesHeight = _imagesHeight;
}

@end
