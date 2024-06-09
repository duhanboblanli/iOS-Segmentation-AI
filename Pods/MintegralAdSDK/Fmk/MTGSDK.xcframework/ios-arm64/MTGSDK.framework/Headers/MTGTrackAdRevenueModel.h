//
//  MTGTrackAdRevenueModel.h
//  MTGSDK
//
//  Created by lee on 2023/6/30.
//  Copyright © 2023 Mintegral. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
   Defined attribution platform name.
 */
#define MTGAttributionPlatformNameAppsFlyer    @"AppsFlyer"
#define MTGAttributionPlatformNameAdjust       @"Adjust"
#define MTGAttributionPlatformNameTenjin       @"Tenjin"
#define MTGAttributionPlatformNameSingular     @"Singular"
#define MTGAttributionPlatformNameKochava      @"Kochava"
#define MTGAttributionPlatformNameBranch       @"Branch"
#define MTGAttributionPlatformNameReyun        @"Reyun"
#define MTGAttributionPlatformNameSolarEngine  @"SolarEngine"
#define MTGAttributionPlatformNameAppMetrica   @"AppMetrica"
#define MTGAttributionPlatformNameMyTracker    @"MyTracker"
#define MTGAttributionPlatformNameAdbrix       @"Adbrix"
#define MTGAttributionPlatformNameApsalar      @"Apsalar"
#define MTGAttributionPlatformNameDataEye      @"DataEye"
#define MTGAttributionPlatformNameFox          @"Fox"
#define MTGAttributionPlatformNameTalkingData  @"TalkingData"
#define MTGAttributionPlatformNameUmeng        @"Umeng"
#define MTGAttributionPlatformNameAirbridge    @"Airbridge"
#define MTGAttributionPlatformNameJustTrack    @"JustTrack"

@interface MTGTrackAdRevenueModel : NSObject

///The attribution platform user id.
@property (nonatomic,copy,nullable) NSString *attributionUserID;

/**
 * @brief The attribution platform name.
 *
 * @note If you have integrated the sdk of the attribution platform, pass the name of the attribution platform.
 *       Use the attribution platform name macro defined in the MTGTrackAdRevenueModel class. If the attribution platform you use does not exist in the defined macro definition, you can pass the name of the attribution platform you use.
 */
@property (nonatomic,copy,nullable) NSString *attributionPlatformName;

///The extra data.
@property (nonatomic,copy,nullable) NSDictionary *extraData;

@end



@class GADAdValue;
@interface MTGTrackAdRevenueAdMobModel : MTGTrackAdRevenueModel

///The currently displayed ad type,use Rewarded|Banner|Interstitial|Native|AppOpen.
@property (nonatomic,copy,nonnull) NSString *adType;

///The admob ad unit id.
@property (nonatomic,copy,nonnull) NSString *adUnitID;

/// The monetary value earned from an ad,admob GADAdValue instance.
@property (nonatomic,strong,nonnull) GADAdValue *adValue;

/// JSON-safe dictionary representation of the ad network response info.
@property (nonatomic,strong,nonnull) NSDictionary *loadedAdDictionaryRepresentation;

@end



@class MAAd;
@interface MTGTrackAdRevenueMaxModel : MTGTrackAdRevenueModel

///The max MAAd instance.
@property (nonatomic,strong,nonnull) MAAd *maxAd;

@end



@interface MTGTrackAdRevenueIronSourceModel : MTGTrackAdRevenueModel

///The ironSource instance id.
@property (nonatomic,copy,nullable) NSString *instanceId;

///The ironSource ISImpressionData.all_data
@property (nonatomic,strong,nonnull) NSDictionary *impressionData;

@end




///If you use other mediation, you can create a MTGTrackAdRevenueCustomModel and assign values to the properties.
@interface MTGTrackAdRevenueCustomModel : MTGTrackAdRevenueModel
///The mediation platform name.
@property (nonatomic,copy,nonnull)   NSString *mediationName;

///The mediation unit id.
@property (nonatomic,copy,nonnull)   NSString *mediationUnitId;

///The ad network name.
@property (nonatomic,copy,nonnull)   NSString *adNetworkName;

///The precision of the revenue value for this ad.
@property (nonatomic,copy,nonnull)   NSString *precision;

///The revenue currency code.
@property (nonatomic,copy,nullable)   NSString *currency;

//The ad’s revenue amount
@property (nonatomic,strong) NSNumber *revenue;

///The ad network unit info.
@property (nonatomic,strong,nullable) NSDictionary *adNetworkUnitInfo;

///is bidding
@property (nonatomic,assign) BOOL isBidding;

///The mediation ad type.
@property (nonatomic,copy,nonnull) NSString *adType;

///The DSP id network that provided the loaded ad when the ad is served through AppLovin Exchange.
@property (nonatomic,copy,nullable) NSString *dspId;

///The DSP network that provided the loaded ad when the ad is served through AppLovin Exchange.
@property (nonatomic,copy,nullable) NSString *dspName;

///The mediation response metadata.
@property (nonatomic,strong,nullable) NSDictionary *allInfo;

@end

NS_ASSUME_NONNULL_END
