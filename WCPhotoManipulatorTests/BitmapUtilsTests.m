//
//  BitmapUtilsTests.m
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 26/4/2562 BE.
//  Copyright © 2562 Woraphot Chokratanasombat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BitmapUtils.h"
#import "Helpers/UIImage+Testing.h"

@interface BitmapUtilsTests : XCTestCase

@end

@implementation BitmapUtilsTests {
    UIImage *image;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    image = nil;
}

////////////////////////////
/// ceil
///////////////////////////
- (void)testCeil_ShouldReturnValueCorrectly {
    XCTAssertEqual([BitmapUtils ceil:5 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.8 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.5 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:4.1 scale:1], 5);
    XCTAssertEqual([BitmapUtils ceil:5 scale:2], 5);
    XCTAssertEqual([BitmapUtils ceil:4.8 scale:2], 5);
    XCTAssertEqual([BitmapUtils ceil:4.5 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils ceil:4.1 scale:2], 4.5);
}

////////////////////////////
/// floor
///////////////////////////
- (void)testFloor_ShouldReturnValueCorrectly {
    XCTAssertEqual([BitmapUtils floor:5 scale:1], 5);
    XCTAssertEqual([BitmapUtils floor:4.8 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:4.5 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:4.1 scale:1], 4);
    XCTAssertEqual([BitmapUtils floor:5 scale:2], 5);
    XCTAssertEqual([BitmapUtils floor:4.8 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils floor:4.5 scale:2], 4.5);
    XCTAssertEqual([BitmapUtils floor:4.1 scale:2], 4);
}

////////////////////////////
/// ceilSize
///////////////////////////
- (void)testCeilSize_ShouldReturnValueCorrectly {
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(5, 6) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.8, 5.8) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.5, 5.5) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.1, 5.1) scale:1], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(5, 6) scale:2], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.8, 5.8) scale:2], CGSizeMake(5, 6)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.5, 5.5) scale:2], CGSizeMake(4.5, 5.5)));
    XCTAssertTrue(CGSizeEqualToSize([BitmapUtils ceilSize:CGSizeMake(4.1, 5.1) scale:2], CGSizeMake(4.5, 5.5)));
}

////////////////////////////
/// transformFromTargetRect
///////////////////////////
- (void)testTransformFromTargetRect_ShouldReturnValueCorrectly {
    CGSize sourceSize = CGSizeMake(40, 90);
    CGRect targetRect = CGRectMake(30, 50, 92, 35);
    CGAffineTransform transform = [BitmapUtils transformFromTargetRect:sourceSize targetRect:targetRect];
    
    XCTAssertEqual(transform.tx, 30);
    XCTAssertEqual(transform.ty, 50);
    XCTAssertEqual(transform.a, (CGFloat)92 / 40);
    XCTAssertEqual(transform.b, 0);
    XCTAssertEqual(transform.c, 0);
    XCTAssertEqual(transform.d, (CGFloat)35 / 90);
}

////////////////////////////
/// transform
///////////////////////////
- (void)testTransform_WhenNoSizeOrScale_ShouldReturnNil {
    image = [UIImage new];
    
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(0, 0) scale:0 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(0, 6) scale:7 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(6, 0) scale:7 transform:CGAffineTransformIdentity]);
    XCTAssertNil([BitmapUtils transform:image size:CGSizeMake(6, 8) scale:0 transform:CGAffineTransformIdentity]);
}

- (void)testTransform_WhenValid_ShouldReturnNewImage {
    image = [UIImage imageNamedTest:@"overlay.png"];
    
    XCTAssertEqual(image.size.width, 200);
    XCTAssertEqual(image.size.height, 141);
    XCTAssertEqual(image.scale, 1);
    
    image = [BitmapUtils transform:image size:CGSizeMake(79, 55) scale:1 transform:CGAffineTransformIdentity];
    XCTAssertEqual(image.size.width, 79);
    XCTAssertEqual(image.size.height, 55);
    XCTAssertEqual(image.scale, 1);
}

@end
