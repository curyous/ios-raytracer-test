//
//  RayTracer.h
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "RTShaderProgram.h"

@interface RayTracer : NSObject
{
    RTShaderProgram* _rtShaderProgram;
    
    GLuint _rtVertexArray;
    GLuint _rtVertexBuffer;
    
    GLKVector3 _eyePosition;
    GLKVector3 _screenPosition;
    GLKVector3 _right;
    GLKVector3 _up;
}

-(void)render;
@end
