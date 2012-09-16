//
//  Shader.fsh
//  RTOpenGL
//
//  Created by Brendon Duncan on 24/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

precision mediump float;

//varying lowp vec4 colorVarying;
varying mediump vec2 vClipSpace;

void main()
{
    float red = vClipSpace.x * 0.5 + 0.5;
    float blue = vClipSpace.y * 0.5 + 0.5;
    gl_FragColor = vec4(red, 0.0, blue, 1.0);
}
