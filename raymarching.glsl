#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float distFunc(vec3 p) {
	return length(p) - 0.5;
}

void main( void ) {
	vec2 pos = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);

	vec3 camPos = vec3(0.0, 0.0, 5.0 * sin(time));
	vec3 ray = normalize(vec3(pos, 0.0) - camPos);
	vec3 curPos = camPos;
	float dist = 0.0;

    for(int i = 0; i < 16; i++) {
        dist = distFunc(curPos);
		if(dist < 0.0001) {
			break;
		}
        curPos += ray * dist;
    }

	gl_FragColor = vec4(dist);
}