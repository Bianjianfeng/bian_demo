//
//  EDQRCodeReaderView.m
//  EDComponentCollection
//
//  Created by bianjianfeng on 2017/6/27.
//  Copyright © 2017年 Jeff_Bian. All rights reserved.
//

#import "EDQRCodeReaderView.h"
#import "EDQRCodeMaskView.h"

@interface EDQRCodeReaderView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic, strong) EDQRCodeMaskView *maskView;

@end

@implementation EDQRCodeReaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scanRect = self.bounds;
        [self initScanService];
        [self initScanAnimationView];
        
        self.torchMode = AVCaptureTorchModeOff;
    }
    return self;
}

- (void)initScanService
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.device = device;
    
    // 2、创建设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    self.metadataOutput = metadataOutput;
    
    // 4、设置代理：在主线程里刷新
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 会话采集率: AVCaptureSessionPresetHigh
    _session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    // 6、添加设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、添加设备输入流到会话对象
    [_session addOutput:metadataOutput];
    
    // 8、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.bounds;
    
    [self.layer addSublayer:self.preview];
    
//    [self startScan];
}

- (void)initScanAnimationView
{
    EDQRCodeMaskView *maskView = [[EDQRCodeMaskView alloc]initWithFrame:self.bounds];
   
    [self addSubview:maskView];
    self.maskView = maskView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.preview.frame = self.bounds;
    self.maskView.frame = self.bounds;
    [self updateCropRect];
}

- (void)updateCropRect
{
    if (!self) {
        return;
    }
    if (CGRectEqualToRect(self.frame, CGRectZero) || CGRectEqualToRect(self.scanRect, CGRectZero)) {
        return;
    }
    CGFloat intersectX = MAX(0, self.scanRect.origin.x) / self.frame.size.width;
    CGFloat intersectY = MAX(0, self.scanRect.origin.y) / self.frame.size.height;
    CGFloat intersectW = MAX(0, self.scanRect.size.width) / self.frame.size.width;
    CGFloat intersectH = MAX(0, self.scanRect.size.height) / self.frame.size.height;
    self.metadataOutput.rectOfInterest = CGRectMake(intersectX, intersectY, intersectW, intersectH);
}

#pragma mark -
#pragma mark --------public methods--------


- (void)setScanRect:(CGRect)scanRect
{
    _scanRect = scanRect;
    self.maskView.cropRect = self.scanRect;
    [self updateCropRect];
}


- (void)setTorchMode:(AVCaptureTorchMode)torchMode
{
    _torchMode = torchMode;
    if ([self.device hasTorch]) {
        [_device lockForConfiguration:nil];
        [_device setTorchMode:torchMode];
        [_device unlockForConfiguration];
    }
}

- (void)startScan
{
    [self.session startRunning];
    [self.maskView.scanView startAnimate];
}

- (void)stopScan
{
    [self.session stopRunning];
    [self.maskView.scanView stopAnimate];
}

#pragma mark -
#pragma mark --------AVCaptureMetadataOutputObjectsDelegate--------
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%@",metadataObjects);
    
    if (metadataObjects == nil || metadataObjects.count == 0) {
        return;
    }
    
    AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(qrReaderView:didReadQRCodeResult:)]) {
        [self.delegate qrReaderView:self didReadQRCodeResult:[obj stringValue]];
    }

}

@end
