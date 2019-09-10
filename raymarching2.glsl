#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float distSphere(vec3 p) {
	return length(p) - 0.5;
}

float sdBox( vec3 p, vec3 b )
{
  vec3 d = abs(p) - b;
  return length(max(d,0.0));
}

vec3 distRept(vec3 p) {
	return mod(p, 4.0) - 2.0;
}

float distFunc(vec3 p) {
	return sdBox(distRept(p),vec3(1.0));
}


void main( void ) {
	vec2 pos = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
	vec2 mousePos = (mouse.xy * 2.0 - 1.0);

	vec3 camPos = vec3(mousePos.x, mousePos.y, 0.5 * sin(time/2.0));
	vec3 ray = normalize(vec3(pos, 0.0) - camPos);
	vec3 curPos = camPos;
	float dist = 0.0;

    for(int i = 0; i < 24; i++) {
        dist = distFunc(curPos);
		if(dist < 0.0001) {
			break;
		}
        curPos += ray * dist;
    }

	gl_FragColor = vec4(dist);
}