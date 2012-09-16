//
//  RayTracer.h
//  RTOpenGL
//
//  Created by Brendon Duncan on 16/09/12.
//
//

#import <Foundation/Foundation.h>
#import "RTShaderProgram.h"

@interface RayTracer : NSObject
{
    RTShaderProgram* _rtShaderProgram;
    
    GLuint _rtVertexArray;
    GLuint _rtVertexBuffer;
}

-(void)render;
@end
