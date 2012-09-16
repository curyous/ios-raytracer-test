//
//  Shader.vsh
//  RTOpenGL
//
//  Created by Brendon Duncan on 24/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

attribute vec4 aPosition;
attribute vec2 aClipSpace;

varying mediump vec2 vClipSpace;

void main()
{
    vClipSpace = aClipSpace;
    gl_Position = aPosition;
}
