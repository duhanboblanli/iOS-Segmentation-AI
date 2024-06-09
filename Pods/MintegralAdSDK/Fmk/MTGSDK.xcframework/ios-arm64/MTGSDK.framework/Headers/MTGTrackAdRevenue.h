//
//  MTGTrackAdRevenue.h
//  MTGSDK
//
//  Created by lee on 2023/6/30.
//  Copyright © 2023 Mintegral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTGTrackAdRevenueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTGTrackAdRevenue : NSObject

/// Track ad revenue.
/// - Parameter adRevenueModel: adRevenue Ad revenue object model containing all the relevant ad revenue tracking data. Use MTGTrackAdRevenueAdMobModel|MTGTrackAdRevenueMaxModel|MTGTrackAdRevenueIronSourceModel
+ (void)trackAdRevenueWithAdRevenueModel:(nonnull MTGTrackAdRevenueModel *)adRevenueModel;

@end

NS_ASSUME_NONNULL_END
