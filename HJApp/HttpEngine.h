//
//  HttpEngine.h
//  HJApp
//
//  Created by Bruce He on 15/10/30.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "GetPic.h"
#import "AllFlower.h"
#import "FlowerCatalogue.h"
#import "ConsumerDetail.h"
#import "orderDetail.h"
#import "FlowerDetail.h"
#import "ShopingCar.h"
#import "ShopingCarDetail.h"
#import "AllAdress.h"
#import "HJNotifiton.h"
#import "ComplainServe.h"
#import "MBProgressHUD.h"
#import "BWCommon.h"
#import "WSProgressHUD.h"



@interface HttpEngine : NSObject

+(void)convertCityName:(NSString*)lat withLng:(NSString *)lng complete:(void(^)(NSDictionary*dataDic))complete failure:(void (^)(NSError *error))failure;

//获取城市
+(void)getCityNameBackcompletion:(void(^)(NSArray*dataArray))complete;

//广告图
+(void)getPictureWithTime:(NSString*)time with:(void(^)(NSArray*dataArray))complete;

+(void)getAdvertisement:(void(^)(NSArray*dataArray))complete;

//花集公告
+(void)getNotifition:(void(^)(NSArray*dataArray))complete;

//猜你喜欢 page_limit
+ (void)goodsFeaturedWithLocation:(NSString *)location withPageLimit:(NSString *)pageLimit with:(void(^)(NSArray*dataArray))complete;
//搜索
+ (void)goodsSearchWithLocation:(NSString *)location withGoodsName:(NSString *)goodsName with:(void(^)(NSArray*dataArray))complete;
//意见反馈
+(void)ideaFeedBackName:(NSString*)name withMoblie:(NSString*)moblie withContent:(NSString*)content complete:(void(^)(NSString *error))complete;

//商务合作
+(void)cooperateName:(NSString*)name withMoblie:(NSString*)moblie withEmail:(NSString*)email withDanWei:(NSString*)danWei withOther:(NSString*)other withIp:(NSString*)ip complete:(void(^)(NSString *error))complete;

+(void)addOrderComplain:(NSDictionary *)dict complete:(void(^)(NSDictionary *dict))complete failure:(void(^)(NSString *error)) failure;

//发送短信
+(void)sendMessageMoblie:(NSString*)mobliePhone withKind:(int)tag;

//查询手机号是否存在
+(void)checkUserPhone:(NSString*)phone with:(void(^)(NSString*existe))complete;

//查询用户
+(void)queryUser:(NSString*)username with:(void(^)(NSDictionary *))complete failure:(void(^)(NSString *error))failure;

//用户注册
+(void)registerRequestPassword:(NSString*)password withMobile:(NSString*)mobile withRegIp:(NSString*)regIp withFlorist:(NSString*)isFlorist complete:(void(^)(NSString*fail))complete;

//登陆请求
+(void)loginRequest:(NSString*)name with:(NSString*)pas complete:(void(^)(NSString*fail))complete;

//修改密码
+(void)momodifyPasswordUser:(NSString*)user withPassword:(NSString*)password complete:(void(^)(NSString*fail))complete;


+(void)getHomeNav:(void(^)(NSArray*dataArray))complete;

//产品分类
+(void)getAllFlower:(void(^)(NSArray*dataArray))complete;

//获取分类属性
+(void)getProduct:(NSString*)idStr completion:(void(^)(NSArray*dataArray))complete;

//获取产品
+(void)getProductDetail:(NSString*)idStr withLocation:(NSString*)location withProps:(NSArray*)props withPage:(NSString*)page withPageSize:(NSString*)pageSize completion:(void(^)(NSArray*dataArray))complete;


//购物车详细列表
+(void)getCart:(void(^)(NSDictionary*allDic,NSArray*dataArray,NSString*totalPrice,NSString*shippingFee,NSString*paymentPrice,NSString*error))complete;

+(void)checkout:(void(^)(NSDictionary*dict))complete failure:(void (^)(NSError *error))failure;

//购物车列表
+(void)getSimpleCart:(void(^)(NSArray*array))complete;

//增加商品
+(void)addGoodsLocation:(NSString*)location withSku:(NSString*)sku withSupplier:(NSString*)supplier withNumber:(NSString*)number complete:(void(^)(NSString *error,NSString *errorStr))complete;


//获取用户详细信息
+(void)getConsumerData:(void(^)(NSDictionary*dataDic))complete;

//获取用户资料
+(void)getConsumerDetailData:(NSString*)idStr completion:(void(^)(NSArray*dataArray))complete;

//编辑个人资料
+(void)updataConsumerDetailData:(NSString*)realNameStr with:(NSString*)genderStr with:(NSString*)birthdayStr completion:(void(^)(NSString *str))completion;

//上传图片
+(void)uploadPicData:(UIImage*)image;

+(void)publicUploadImage:(UIImage *) image complete:(void(^)(NSDictionary*dict))complete failure : (void(^)(void))failure;

//我的订单
+(void)myOrder:(NSString*)full with:(NSString*)page with:(NSString*)pageSize with:(NSString*)status completion:(void(^)(NSArray*dataArray))complete;
//订单详细
+(void)detailOrder:(NSString*)idStr completion:(void(^)(NSDictionary*dataDic))complete;
//再次购买
+(void)anginBuy:(NSString*)order complete:(void(^)(void))complete;

+(void)cancelOrder:(NSString*)order uniqueid:(NSString*)uniqueid complete:(void(^)(NSArray*array))complete failure:(void (^)(NSError *error))failure;

+(void)queryOrderExpress:(NSString *)order_no complete:(void(^)(NSArray*array))complete failure:(void (^)(NSError *error))failure;


//订单提交
+(void)submitOrderMethod:(NSString*)method withSpaypassword:(NSString*)spaypassword withDeadline:(NSString *)deadline withCouponNo:(NSString*)couponNo withCustMessage:(NSString *)CustMessage withSelfPickup:(NSString *)selfPickup withAddressId:(NSString*)addressId withConsignee:(NSString *)consignee withProvince:(NSString *)province withCity:(NSString *)city withTown:(NSString *)town withPhoneMob:(NSString *)phoneMob withAddress:(NSString *)address completion:(void(^)(NSDictionary*dict))complete;

+(void)createOrder:(NSDictionary*)params complete:(void(^)(NSDictionary*dict))complete failure:(void (^)(NSError *error))failure;

//获取订单号
//+(void)getOutOrderNoNum:(NSString*)num Completion:(void(^)(NSString*orderNo))complete;

//订单支付
+(void)payOrderNum:(NSString*)num withSpaypassword:(NSString*)spaypassword withMethod:(NSString*)method withCoupon:(NSString*)couponNo Completion:(void(^)(NSString*orderNo,NSString*price))complete;


//地址列表
+(void)getAddress:(void(^)(NSArray*dataArray))complete;
//地址编辑
+(void)changeAddress:(NSString*)addressId Consignee:(NSString*)consignee withPhoneMob:(NSString*)phoneMob withProvince:(NSString*)province withCity:(NSString*)city withTown:(NSString*)town withAddress:(NSString*)address;
//增加地址
+(void)addAdressConsignee:(NSString*)consignee withPhoneMob:(NSString*)phoneMob withProvince:(NSString*)province withCity:(NSString*)city withTown:(NSString*)town withAddress:(NSString*)address completion:(void(^)(NSString *str))completion;
//地址删除
+(void)deleteAddress:(NSString*)addrId;
//设置默认收货地址
+(void)setDefaultAddress:(NSString*)addrId;
//获取默认收货地址
+(void)getDefaultAddress:(void(^)(NSDictionary*dataDic))complete;


//我的红包
+(void)getRedBagStatus:(NSString*)status completion:(void(^)(NSArray*dataArray))complete;
+(void) getOrderRedBagUniqueid:(NSString *)uniqueid To_uid:(NSString *)to_uid order_price:(NSString *)order_price completion:(void(^)(NSArray*dataArray))complete;

//花集余额
+(void)getBalance:(void(^)(NSDictionary*dic))complete;

//amount,method
//花集余额充值
+(void)topUpAmount:(NSString*)amount withMethod:(NSString*)method completion:(void(^)(NSDictionary *dict))complete;

//微信prepay_id接口
+(void)wxPayRequest:(NSString *)out_trade_no completion:(void(^)(NSDictionary *dict)) complete;
//消息中心
//+(void)

//我的售后
+(void)complainServerPage:(NSString*)page withPageSize:(NSString*)pageSize completion:(void(^)(NSArray*dataArray))complete;

//消息中心
+(void)messageCentercompletion:(void(^)(NSArray*dataArray))complete;

//错误数据
//+(NSString*)errorData:(NSDictionary*)userInfo;

//产地来源
+ (void)getAreaDataLocation:(NSString *)location completion:(void(^)(NSArray*dataArray))complete;
//用户积分花籽数等
+(void)getUserSeeds_Integralcompletion:(void(^)(NSArray*dataArray))complete;
//账户30天收支明细
+(void)getUserPaymentcompletion:(void(^)(NSArray*dataArray))complete;
//花籽可兑换列表
+(void)getUserSeedsGoodscompletion:(void(^)(NSArray*dataArray))complete;
//花籽兑换商品
+(void)SeedsGoods:(NSDictionary *)dic withcompletion:(void(^)(NSString*str))complete;
//广告图
+(void)getAdvertisingFigurecompletion:(void(^)(NSArray*dataArray))complete;
@end
