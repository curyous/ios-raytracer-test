//
//  BaseShaderProgram.h
//  VT2DShading
//
//  Created by Brendon Duncan on 7/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))



@interface BaseShaderProgram : NSObject
{
    GLuint _program;
}

@property (readonly) GLuint program;

- (id)init;

- (void)bindAttributeLocations;
- (BOOL)loadShadersWithName:(NSString*) shaderName;
- (void)logGLErrorWithMessage:(NSString*) message;
@end
