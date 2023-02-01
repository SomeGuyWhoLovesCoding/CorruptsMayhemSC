/* Useless shit

package;

import openfl.display.FPS;
import flixel.FlxG;
import flixel.FlxState;
import openfl.filters.ShaderFilter;

class N1FuckState extends FlxShaderToyShader
{
	public function new()
	{
        // First Phase 1

		super('
		// OG SHADER FOUND HERE: https://www.shadertoy.com/view/4tScWm

		void mainImage( out vec4 fragColor, in vec2 fragCoord )
		{
			vec2 uv = fragCoord.xy / iResolution.xy;
  		  vec4 t = texture(iChannel0, uv);
			fragColor = smoothstep(vec4(0.1), vec4(0.9),fract(t*(sin(iTime)*0.5 + 0.5)*40.0));
		}
		');

        // First Phase 2

		super('
		// OG SHADER FOUND HERE: https://www.shadertoy.com/view/wdVSR1

		#define ENABLE_MODE 0
        #define MODE 5

        float hash(in float v) { return fract(sin(v)*43768.5453); }
        float hash(in vec2 v) { return fract(sin(dot(v, vec2(12.9898, 78.233)))*43768.5453); }
        vec2 hash2(in float v) { return vec2(hash(v+vec2(77.77)), hash(v+vec2(999.999))); }
        vec2 hash2(in vec2 v) { return vec2(hash(v+vec2(77.77)), hash(v+vec2(999.999))); }

        #define GLITCH_THR 0.06
        #define GLITCH_RECT_DIVISION 6.
        #define GLITCH_RECT_ITR 3
        vec3 glitch(in vec2 p, in float seed) {
            vec2 q = fract(p);
            float g = -1.;
            for(int i=0;i<GLITCH_RECT_ITR;i++) {
                float fi = float(i)+1.;
                float h = hash(fi + seed);
                vec2 h2 = hash2(fi + seed);

                q = p *  GLITCH_RECT_DIVISION * fi + h2;
                q *= hash2(fi + seed)*2.-1.;
                vec2 iq = floor(q);
                vec2 fq = fract(q);
                float hq = hash(iq);
                if(hq<GLITCH_THR) {
                    p += hash2(iq)*2.-1.;
                    g = h;
                }
            }
            return vec3(fract(p), g);
        }


        vec4 tex(in vec2 uv) { return texture(iChannel0, uv); }

        vec3 pattern0(in vec2 uv, in vec3 g) { return tex(uv).rgb; }
        vec3 pattern1(in vec2 uv, in vec3 g) { return g.z<0. ? tex(uv).rgb : g.z * tex(uv).rgb; }
        vec3 pattern2(in vec2 uv, in vec3 g) { return g.z<0. ? tex(uv).rgb : tex(uv+vec2(0.1*(g.z*2.-1.), 0.)).rgb; }
        vec3 pattern3(in vec2 uv, in vec3 g) { return g.z<0. ? tex(uv).rgb : 1.-tex(uv).rgb; }
        vec3 pattern4(in vec2 uv, in vec3 g) { return g.z<0. ? tex(uv).rgb : tex(g.xy).rgb; }
        #define RGB_SHIFT (g.z*vec3(0.16, 0.04, -0.8))
        vec3 pattern5(in vec2 uv, in vec3 g) { return g.z<0. ? tex(uv).rgb : vec3(tex(uv+vec2(RGB_SHIFT.r, 0.)).r, tex(uv+vec2(RGB_SHIFT.g, 0.)).g, tex(uv+vec2(RGB_SHIFT.b, 0.)).b); }

        void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
            vec2 uv = fragCoord/iResolution.xy;
            
            float gps = 15.;// glitch per seconds
            vec3 g = glitch(uv, floor(iTime*gps)/gps);
            
            vec3 col = vec3(0.);
            if (ENABLE_MODE==0) {
                float m = mod(iTime, 6.);
                col = 
                    m<1. ? pattern0(uv, g) : 
                    m<2. ? pattern1(uv, g) : 
                    m<3. ? pattern2(uv, g) : 
                    m<4. ? pattern3(uv, g) : 
                    m<5. ? pattern4(uv, g) : 
                                pattern5(uv, g) ;
            } else {
                col =
                    MODE==0 ? pattern0(uv, g) : 
                    MODE==1 ? pattern1(uv, g) : 
                    MODE==2 ? pattern2(uv, g) : 
                    MODE==3 ? pattern3(uv, g) : 
                    MODE==4 ? pattern4(uv, g) : 
                    MODE==5 ? pattern5(uv, g) : 
                    vec3(0.);
            }

            // Output to screen
            fragColor = vec4(col,1.0);
        }
		');

        // Second Phase

		super('
		// OG SHADER FOUND HERE: https://www.shadertoy.com/view/tlXSR8

		void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
            vec3 c = texture(iChannel0, fragCoord.xy / iResolution.xy).rgb;
        
            fragColor = vec4(c,1.);
        }
		');

        // Third Phase 1

		super('
		// OG SHADER FOUND HERE: https://www.shadertoy.com/view/wtKyDm

		// inspiration code: https://thebookofshaders.com/edit.php#10/ikeda-03.frag
        // learned changeblae resolution size, fract, atan, patterns, and randoms ; used clamp, mouse

        float random (in float x) {
            return fract(sin(x)*1e4);
        }

        float random (in vec2 st) {
            return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
        }

        float pattern(vec2 st, vec2 v, float t) {
            vec2 p = floor(st+v);
            return step(t, random(100.+p*.000001)+random(p.x)*0.8 );
        }

        void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
        //   vec2 st = fragCoord.xy/iResolution.xy;
        vec2 st = (1.0 * fragCoord.xy - iResolution.xy) / min(iResolution.y, iResolution.x);
        st.x *= iResolution.x/iResolution.y;

            vec2 grid = vec2(100.0,50.);
            st *= grid;

            vec2 ipos = floor(st);  // integer
            vec2 fpos = fract(st);  // fraction

            vec2 vel = vec2(iTime*2.*min(grid.x,grid.y)); // time
            vel *= vec2(1.)*sin(iTime)/1e4 * random(0.+max(ipos.x,ipos.y)); // direction

            // Assign a random value base on the integer coord
            vec2 offset = vec2(random(st),random(st*1e3)) ;
            offset+=iTime/1e3;
        
            vec3 color = vec3(0.880,0.354,0.201);
            color.r = pattern(st+offset,vel,0.5+iMouse.x/iResolution.x);
            color.g = pattern(st,vel,0.5+iMouse.x/iResolution.x);
            color.b = pattern(st-offset,vel,0.5+iMouse.x/iResolution.x);

            // Margins
            color /= step(sin(iTime*1.5),max(fpos.x,fpos.y));

            fragColor = vec4(1.0-color*random(st)*1e3,clamp(abs(sin(iTime)), 0.8,1.0));
        }
		');

        // Third Phase 2

		super('
		// OG SHADER FOUND HERE: https://www.shadertoy.com/view/wlSXWR

		const vec2 z = vec2(4,8);
        const float complexity =14.;
        const float density = .7; // 0-1
        const float disturbance = .2;
        const float speed = .2;

        vec4 hash42(vec2 p)
        {
            vec4 p4 = fract(vec4(p.xyxy) * vec4(.1031, .1030, .0973, .1099));
            p4 += dot(p4, p4.wzxy+33.33);
            return fract((p4.xxyz+p4.yzzw)*p4.zywx);
        }

        #define q(x,p) (floor((x)/(p))*(p))

        void mainImage( out vec4 o, vec2 C)
        {
            vec2 R = iResolution.xy;
            vec2 uv = C/R.xy;
            vec2 N = uv;
            float t = iTime*.05;
            t+=1e2;
            uv.x *= R.x/R.y;
            uv *= z;
            uv.y+=iTime*.5;
            o = vec4(1);
            uv.x += floor(iTime*speed)*z.x;
            float s = 1.;

            for (float i = 1.;i <= complexity; ++ i) {
                vec2 c = floor(uv+i);
                vec4 h = hash42(c);
                vec2 p = fract(uv+i)-s;
                uv+= p*h.z*vec2(fract(q(t*3.,h.x))*disturbance,h.y);
                s = -s*2.;
                if (h.w > density) {
                    o *= h;
                }
            }
            o=step(.5,o) * mod(C.x,3.)/2.5;
        }
		');

        // Fourth Phase 1

		super('
        // OG SHADER FOUND HERE: // OG SHADER FOUND HERE: https://www.shadertoy.com/view/wsfcW2

		#define PI 3.1410 
        #define theta 5.8 

        vec3 r1(vec3 v)
        {
            return 0.3*cos(v);
        }

        vec3 r2(vec3 v)
        {
            return iTime*v.xyz;
        }

        float morphx(float x)
        {
            return x;
        }


        float morphy(float y)
        {
            if(0. > cos(y) && cos(y) < PI/2.0)
            {
                return tan(y);
            }
            
            return -y;
        }

        float morphz(float z)
        {
            if(0. > sin(z) && sin(z) < PI/2.0)
            {
                return -z;
            }
            
            return tan(z);
        }

        vec3 morph_coord(vec3 v)
        {
            vec3 outv = v;
            outv.x = morphx(v.x);
            outv.y = morphy(v.y);
            outv.z = morphz(v.z);
            
            return outv;
        }

        vec3 r3(vec3 v)
        {
        morph_coord(v);
        return v;
        }

        vec3 noise(vec3 coord)
        {
            coord = r1(coord);
            coord = r2(coord);
            coord = r3(coord);
            return coord;
        }

        void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
            vec3 col;
            if(fragCoord.x < iResolution.x/4.)
            {
                col = 0.2+sin(theta)*sin(iTime+noise(fragCoord.xyx));
            }
            
            else if(fragCoord.x > iResolution.x/4. && (fragCoord.x < iResolution.x/2.))
            {
                col = 0.25+sin(theta)*sin(iTime+noise(fragCoord.xyx));
            }
            
                else
            {
                col = 0.3+sin(theta)*sin(iTime+noise(fragCoord.xyx));
            }

            // Output to screen
            fragColor = vec4(col,1.0);
        }
		');

        // Fourth Phase 2

		super('
        https://www.shadertoy.com/view/MdSfRK

		float rnd2( in vec2 sd )
        {
            return fract(cos(dot(sd*floor(iTime*15.0),vec2(145.34,142.55)))*2745.84);
        }
        float rnd( in float sd )
        {
            return rnd2(vec2(sd,1.0));
        }

        const float str = 0.05;
        const float str2 = 7.0;
        const float thr1 = 6.4;
        const float thr2 = 8.6;
        const float thr3 = 19.3;

        void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
            vec2 uv = fragCoord.xy/iResolution.xy;
            vec2 uv_c[3] = vec2[3](uv,uv,uv);
            vec2 blka = floor(uv*vec2(22.0,12.0));
            vec2 blkb = floor(uv*vec2(6.0,9.0));
            float noiz = pow(rnd2(blka),thr1)*pow(rnd2(blkb),thr2)-pow(rnd(4.53),thr3)*str2;
            uv_c[0].y += str*noiz*rnd(4.55);
            uv_c[2].y -= str*noiz*rnd(3.67);
            vec4 res;
            res.r = texture(iChannel0,uv_c[0]).r;
            res.g = texture(iChannel0,uv_c[1]).g;
            res.b = texture(iChannel0,uv_c[2]).b;
            res.a = 1.0;
            fragColor = res;
        }
		');
	}
}*/