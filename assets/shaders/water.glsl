{
  "sksl": "// This SkSL shader is autogenerated by spirv-cross.\n\nfloat4 flutter_FragCoord;\n\nuniform vec2 iResolution;\nuniform float iTime;\nuniform float SEA_HEIGHT;\n\nvec4 fragColor;\n\nvec2 iMouse;\n\nmat3 FLT_flutter_local_fromEuler(vec3 ang)\n{\n    vec2 a1 = vec2(sin(ang.x), cos(ang.x));\n    vec2 a2 = vec2(sin(ang.y), cos(ang.y));\n    vec2 a3 = vec2(sin(ang.z), cos(ang.z));\n    mat3 m;\n    m[0] = vec3((a1.y * a3.y) + ((a1.x * a2.x) * a3.x), ((a1.y * a2.x) * a3.x) + (a3.y * a1.x), (-a2.y) * a3.x);\n    m[1] = vec3((-a2.y) * a1.x, a1.y * a2.y, a2.x);\n    m[2] = vec3(((a3.y * a1.x) * a2.x) + (a1.y * a3.x), (a1.x * a3.x) - ((a1.y * a3.y) * a2.x), a2.y * a3.y);\n    return m;\n}\n\nfloat FLT_flutter_local_hash(vec2 p)\n{\n    float h = dot(p, vec2(127.09999847412109375, 311.70001220703125));\n    return fract(sin(h) * 43758.546875);\n}\n\nfloat FLT_flutter_local_noise(vec2 p)\n{\n    vec2 i = floor(p);\n    vec2 f = fract(p);\n    vec2 u = (f * f) * (vec2(3.0) - (f * 2.0));\n    vec2 param = i + vec2(0.0);\n    vec2 param_1 = i + vec2(1.0, 0.0);\n    vec2 param_2 = i + vec2(0.0, 1.0);\n    vec2 param_3 = i + vec2(1.0);\n    return (-1.0) + (2.0 * mix(mix(FLT_flutter_local_hash(param), FLT_flutter_local_hash(param_1), u.x), mix(FLT_flutter_local_hash(param_2), FLT_flutter_local_hash(param_3), u.x), u.y));\n}\n\nfloat FLT_flutter_local_sea_octave(inout vec2 uv, float choppy)\n{\n    vec2 param = uv;\n    uv += vec2(FLT_flutter_local_noise(param));\n    vec2 wv = vec2(1.0) - abs(sin(uv));\n    vec2 swv = abs(cos(uv));\n    wv = mix(wv, swv, wv);\n    return pow(1.0 - pow(wv.x * wv.y, 0.64999997615814208984375), choppy);\n}\n\nfloat FLT_flutter_local_map(vec3 p)\n{\n    float freq = 0.1599999964237213134765625;\n    float amp = SEA_HEIGHT;\n    float choppy = 4.0;\n    vec2 uv = p.xz;\n    uv.x *= 0.75;\n    float h = 0.0;\n    for (int i = 0; i < 3; i++)\n    {\n        vec2 param = (uv + vec2(1.0 + (iTime * 0.800000011920928955078125))) * freq;\n        float param_1 = choppy;\n        float _397 = FLT_flutter_local_sea_octave(param, param_1);\n        float d = _397;\n        vec2 param_2 = (uv - vec2(1.0 + (iTime * 0.800000011920928955078125))) * freq;\n        float param_3 = choppy;\n        float _409 = FLT_flutter_local_sea_octave(param_2, param_3);\n        d += _409;\n        h += (d * amp);\n        uv *= mat2(vec2(1.60000002384185791015625, 1.2000000476837158203125), vec2(-1.2000000476837158203125, 1.60000002384185791015625));\n        freq *= 1.89999997615814208984375;\n        amp *= 0.2199999988079071044921875;\n        choppy = mix(choppy, 1.0, 0.20000000298023223876953125);\n    }\n    return p.y - h;\n}\n\nfloat FLT_flutter_local_heightMapTracing(vec3 ori, vec3 dir, inout vec3 p)\n{\n    float tm = 0.0;\n    float tx = 1000.0;\n    vec3 param = ori + (dir * tx);\n    float hx = FLT_flutter_local_map(param);\n    if (hx > 0.0)\n    {\n        p = ori + (dir * tx);\n        return tx;\n    }\n    vec3 param_1 = ori + (dir * tm);\n    float hm = FLT_flutter_local_map(param_1);\n    float tmid = 0.0;\n    for (int i = 0; i < 8; i++)\n    {\n        tmid = mix(tm, tx, hm / (hm - hx));\n        p = ori + (dir * tmid);\n        vec3 param_2 = p;\n        float hmid = FLT_flutter_local_map(param_2);\n        if (hmid < 0.0)\n        {\n            tx = tmid;\n            hx = hmid;\n        }\n        else\n        {\n            tm = tmid;\n            hm = hmid;\n        }\n    }\n    return tmid;\n}\n\nfloat FLT_flutter_local_map_detailed(vec3 p)\n{\n    float freq = 0.1599999964237213134765625;\n    float amp = SEA_HEIGHT;\n    float choppy = 4.0;\n    vec2 uv = p.xz;\n    uv.x *= 0.75;\n    float h = 0.0;\n    for (int i = 0; i < 5; i++)\n    {\n        vec2 param = (uv + vec2(1.0 + (iTime * 0.800000011920928955078125))) * freq;\n        float param_1 = choppy;\n        float _475 = FLT_flutter_local_sea_octave(param, param_1);\n        float d = _475;\n        vec2 param_2 = (uv - vec2(1.0 + (iTime * 0.800000011920928955078125))) * freq;\n        float param_3 = choppy;\n        float _487 = FLT_flutter_local_sea_octave(param_2, param_3);\n        d += _487;\n        h += (d * amp);\n        uv *= mat2(vec2(1.60000002384185791015625, 1.2000000476837158203125), vec2(-1.2000000476837158203125, 1.60000002384185791015625));\n        freq *= 1.89999997615814208984375;\n        amp *= 0.2199999988079071044921875;\n        choppy = mix(choppy, 1.0, 0.20000000298023223876953125);\n    }\n    return p.y - h;\n}\n\nvec3 FLT_flutter_local_getNormal(vec3 p, float eps)\n{\n    vec3 param = p;\n    vec3 n;\n    n.y = FLT_flutter_local_map_detailed(param);\n    vec3 param_1 = vec3(p.x + eps, p.y, p.z);\n    n.x = FLT_flutter_local_map_detailed(param_1) - n.y;\n    vec3 param_2 = vec3(p.x, p.y, p.z + eps);\n    n.z = FLT_flutter_local_map_detailed(param_2) - n.y;\n    n.y = eps;\n    return normalize(n);\n}\n\nvec3 FLT_flutter_local_getSkyColor(inout vec3 e)\n{\n    e.y = ((max(e.y, 0.0) * 0.800000011920928955078125) + 0.20000000298023223876953125) * 0.800000011920928955078125;\n    return vec3(pow(1.0 - e.y, 2.0), 1.0 - e.y, 0.60000002384185791015625 + ((1.0 - e.y) * 0.4000000059604644775390625)) * 1.10000002384185791015625;\n}\n\nfloat FLT_flutter_local_diffuse(vec3 n, vec3 l, float p)\n{\n    return pow((dot(n, l) * 0.4000000059604644775390625) + 0.60000002384185791015625, p);\n}\n\nfloat FLT_flutter_local_specular(vec3 n, vec3 l, vec3 e, float s)\n{\n    float nrm = (s + 8.0) / 25.1327362060546875;\n    return pow(max(dot(reflect(e, n), l), 0.0), s) * nrm;\n}\n\nvec3 FLT_flutter_local_getSeaColor(vec3 p, vec3 n, vec3 l, vec3 eye, vec3 dist)\n{\n    float fresnel = clamp(1.0 - dot(n, -eye), 0.0, 1.0);\n    fresnel = pow(fresnel, 3.0) * 0.5;\n    vec3 param = reflect(eye, n);\n    vec3 _527 = FLT_flutter_local_getSkyColor(param);\n    vec3 reflected = _527;\n    vec3 param_1 = n;\n    vec3 param_2 = l;\n    float param_3 = 80.0;\n    vec3 refracted = vec3(0.0, 0.0900000035762786865234375, 0.180000007152557373046875) + ((vec3(0.4799999892711639404296875, 0.540000021457672119140625, 0.36000001430511474609375) * FLT_flutter_local_diffuse(param_1, param_2, param_3)) * 0.119999997317790985107421875);\n    vec3 color = mix(refracted, reflected, vec3(fresnel));\n    float atten = max(1.0 - (dot(dist, dist) * 0.001000000047497451305389404296875), 0.0);\n    color += (((vec3(0.4799999892711639404296875, 0.540000021457672119140625, 0.36000001430511474609375) * (p.y - SEA_HEIGHT)) * 0.180000007152557373046875) * atten);\n    vec3 param_4 = n;\n    vec3 param_5 = l;\n    vec3 param_6 = eye;\n    float param_7 = 60.0;\n    color += vec3(FLT_flutter_local_specular(param_4, param_5, param_6, param_7));\n    return color;\n}\n\nvec3 FLT_flutter_local_getPixel(vec2 coord, float time)\n{\n    vec2 uv = coord / iResolution;\n    uv = (uv * 2.0) - vec2(1.0);\n    uv.x *= (iResolution.x / iResolution.y);\n    vec3 ang = vec3(sin(time * 3.0) * 0.100000001490116119384765625, (sin(time) * 0.20000000298023223876953125) + 0.300000011920928955078125, time);\n    vec3 ori = vec3(0.0, 3.5, time * 5.0);\n    vec3 dir = normalize(vec3(uv, -2.0));\n    dir.z += (length(uv) * 0.14000000059604644775390625);\n    vec3 param = ang;\n    dir = normalize(dir) * FLT_flutter_local_fromEuler(param);\n    vec3 param_1 = ori;\n    vec3 param_2 = dir;\n    vec3 param_3;\n    float _763 = FLT_flutter_local_heightMapTracing(param_1, param_2, param_3);\n    vec3 p = param_3;\n    vec3 dist = p - ori;\n    vec3 param_4 = p;\n    float param_5 = dot(dist, dist) * (0.100000001490116119384765625 / iResolution.x);\n    vec3 n = FLT_flutter_local_getNormal(param_4, param_5);\n    vec3 light = vec3(0.0, 0.780868828296661376953125, 0.6246950626373291015625);\n    vec3 param_6 = dir;\n    vec3 _787 = FLT_flutter_local_getSkyColor(param_6);\n    vec3 param_7 = p;\n    vec3 param_8 = n;\n    vec3 param_9 = light;\n    vec3 param_10 = dir;\n    vec3 param_11 = dist;\n    return mix(_787, FLT_flutter_local_getSeaColor(param_7, param_8, param_9, param_10, param_11), vec3(pow(smoothstep(0.0, -0.0199999995529651641845703125, dir.y), 0.20000000298023223876953125)));\n}\n\nvoid FLT_main()\n{\n    iMouse = vec2(0.0);\n    float time_1 = (iTime * 0.300000011920928955078125) + (iMouse.x * 0.00999999977648258209228515625);\n    vec2 param_12 = flutter_FragCoord.xy;\n    float param_13 = time_1;\n    vec3 color = FLT_flutter_local_getPixel(param_12, param_13);\n    fragColor = vec4(pow(color, vec3(0.64999997615814208984375)), 1.0);\n}\n\nhalf4 main(float2 iFragCoord)\n{\n      flutter_FragCoord = float4(iFragCoord, 0, 0);\n      FLT_main();\n      return fragColor;\n}\n",
  "stage": 1,
  "target_platform": 2,
  "uniforms": [
    {
      "array_elements": 0,
      "bit_width": 32,
      "columns": 1,
      "location": 0,
      "name": "iResolution",
      "rows": 2,
      "type": 10
    },
    {
      "array_elements": 0,
      "bit_width": 32,
      "columns": 1,
      "location": 1,
      "name": "iTime",
      "rows": 1,
      "type": 10
    },
    {
      "array_elements": 0,
      "bit_width": 32,
      "columns": 1,
      "location": 2,
      "name": "SEA_HEIGHT",
      "rows": 1,
      "type": 10
    }
  ]
}