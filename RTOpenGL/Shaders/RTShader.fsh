//
//  Shader.fsh
//  RTOpenGL
//
//  Created by Brendon Duncan on 24/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define EPSILON 0.00001

precision mediump float;

varying mediump vec2 vClipSpace;

uniform vec3 uEyePosition;
uniform vec3 uScreenPosition;
uniform vec3 uRight;
uniform vec3 uUp;

uniform sampler2D uTriangleTexture;

vec3 getVertex(float index) {
    
    float u = (index + 0.5) / 256.0;
    
    float v = 0.5 / 256.0;
    
    return texture2D(uTriangleTexture, vec2(u, v)).rgb;
    
}

bool intersectTriangle(vec3 origin, vec3 dir, vec3 p0, vec3 p1, vec3 p2) {
    vec3 edge1, edge2, tvec, pvec, qvec;
    
    float t, u, v, det, inv_det;
    
    // Find vectors for two edges sharing p0
    edge1 = p1 - p0;
    edge2 = p2 - p0;
    
    // Begin calculating determinant - also use to calculate U parameter
    pvec = cross(dir, edge2);
    
    // If determinant is near zero, ray lies in plane of triangle
    det = dot(edge1, pvec);
    
    // Using culling
    
    if (det < EPSILON) return false;
    
    // Calculate distance from vert0 to ray origin
    tvec = origin - p0;
    
    // Calculate U parameter and test bounds
    u = dot(tvec, pvec);
    if (u < 0.0 || u > det) return false;
    
    // Prepare to test V parameter
    qvec = cross(tvec, edge1);
    
    // Calculate V parameter and test bounds
    v = dot(dir, qvec);
    if (v < 0.0 || u + v > det) return false;
    
    // Calculate t, scale parameters, ray intersects triangle
    t = dot(edge2, qvec);
    inv_det = 1.0 / det;
    t *= inv_det;
    u *= inv_det;
    v *= inv_det;
    
    return true;
}


bool intersectTriangleFromTexture(vec3 origin, vec3 dir, float i) {
    vec3 v0, v1, v2;
    
    float baseIndex = i * 3.0;
    
    v0 = getVertex(baseIndex);
    v1 = getVertex(baseIndex + 1.0);
    v2 = getVertex(baseIndex + 2.0);
    
    return intersectTriangle(origin, dir, v0, v1, v2);
}

void main()
{
    mediump vec3 pixelPos = uScreenPosition + vClipSpace.x * uRight + vClipSpace.y * uUp;
    mediump vec3 dir = normalize(pixelPos - uEyePosition);
    
    gl_FragColor = vec4(dir, 1.0);
    
    for (float i = 0.0; i < 2.0; i++) {
        if (intersectTriangleFromTexture(uEyePosition, dir, i) ) {
            gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
    }
}
