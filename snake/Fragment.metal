//
//  Shader.metal
//  snake
//
//  Created by Willis Plummer on 8/8/23.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut {
  float4 position [[position]];
  float4 color;
};

fragment float4 fragment_main(
                              VertexOut in [[stage_in]]
                              ) {
  return in.color;
}
