//
//  Copyright (c) 2014 Pawel Dudek. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBDCarouselCollectionViewLayout : UICollectionViewLayout

@property(nonatomic, strong) NSIndexPath *indexPathForCenteredItem;
@property(nonatomic) CGSize itemSize;
@property(nonatomic) CGFloat interItemSpace;

@end
