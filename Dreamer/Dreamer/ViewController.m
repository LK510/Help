//
//  ViewController.m
//  Dreamer
//
//  Created by 路飞 on 2017/5/22.
//  Copyright © 2017年 路飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSString *urlStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [AFHTTPSessionManager manager];
    self.urlStr = @"http://123.57.39.181/fyq/answer/web/index.php?r=site/index";
    
}

- (IBAction)payDidClick:(id)sender {
    
}

- (IBAction)upDateClick:(id)sender {
    
//    第一种方式：文件流方式进行上传
    //接收类型不一致请替换一致text/html或别的
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.urlStr = @"http://lufei/postRequest.php";
    
//    NSURLSessionDataTask *task =
    
    [self.manager POST:self.urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        UIImage *image = [UIImage imageNamed:@"cover_acquiesce"];
        NSData *imageData =UIImageJPEGRepresentation(image,1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"responseObject:%@",uploadProgress);

    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        
        NSLog(@"上传成功");
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
    }];
    
}

//    第二种方式：将image转成NSData，在进行base64加密，此处代码是借鉴朋友博客中写的，就是一个加密过程，不一定非要这么写，只要将image对象传承NSData类型，然后在进行base64加密就可以了。将此处得到的返回值NSString，作为入参传入请求地址就可以了
+ (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}


- (IBAction)downLoadClick:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
