//
//  MapViewController.h
//  dropLove
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@interface MapViewController : UIViewController<BMKMapViewDelegate,BMKPoiSearchDelegate>

@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKPoiSearch *poisearch;
@property (assign, nonatomic) int curPage;
@property (copy, nonatomic)NSString *citytext;
@property (copy, nonatomic)NSString *activeandadress;




@end
