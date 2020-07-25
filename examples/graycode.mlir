llhd.entity @binary_to_gray.param2 (%A : !llhd.sig<i20>) -> (%Z : !llhd.sig<i20>) {
    %A1 = llhd.prb %A : !llhd.sig<i20>
    %A2 = llhd.prb %A : !llhd.sig<i20>
    %0 = llhd.const 1 : i32
    %1 = llhd.const 0 : i20
    %2 = llhd.shr %A2, %1, %0 : (i20, i20, i32) -> i20
    %3 = llhd.xor %A1, %2 : i20
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i20>
}

llhd.entity @gray_to_binary.param3 (%A : !llhd.sig<i20>) -> (%Z : !llhd.sig<i20>) {
    %0 = llhd.const 0 : i32
    %1 = llhd.const 0 : i20
    %2 = llhd.sig "s0" %1 : i20
    %3 = llhd.shr %Z, %2, %0 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %4 = llhd.extract_slice %3, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A1 = llhd.prb %A : !llhd.sig<i20>
    %5 = llhd.const 0 : i1
    %6 = llhd.const 0 : i20
    %7 = llhd.shr %A1, %6, %5 : (i20, i20, i1) -> i20
    %8 = llhd.extract_slice %7, 0 : i20 -> i20
    %9 = llhd.extract_slice %8, 0 : i20 -> i1
    %10 = llhd.extract_slice %8, 1 : i20 -> i1
    %11 = llhd.xor %9, %10 : i1
    %12 = llhd.extract_slice %8, 2 : i20 -> i1
    %13 = llhd.xor %11, %12 : i1
    %14 = llhd.extract_slice %8, 3 : i20 -> i1
    %15 = llhd.xor %13, %14 : i1
    %16 = llhd.extract_slice %8, 4 : i20 -> i1
    %17 = llhd.xor %15, %16 : i1
    %18 = llhd.extract_slice %8, 5 : i20 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.extract_slice %8, 6 : i20 -> i1
    %21 = llhd.xor %19, %20 : i1
    %22 = llhd.extract_slice %8, 7 : i20 -> i1
    %23 = llhd.xor %21, %22 : i1
    %24 = llhd.extract_slice %8, 8 : i20 -> i1
    %25 = llhd.xor %23, %24 : i1
    %26 = llhd.extract_slice %8, 9 : i20 -> i1
    %27 = llhd.xor %25, %26 : i1
    %28 = llhd.extract_slice %8, 10 : i20 -> i1
    %29 = llhd.xor %27, %28 : i1
    %30 = llhd.extract_slice %8, 11 : i20 -> i1
    %31 = llhd.xor %29, %30 : i1
    %32 = llhd.extract_slice %8, 12 : i20 -> i1
    %33 = llhd.xor %31, %32 : i1
    %34 = llhd.extract_slice %8, 13 : i20 -> i1
    %35 = llhd.xor %33, %34 : i1
    %36 = llhd.extract_slice %8, 14 : i20 -> i1
    %37 = llhd.xor %35, %36 : i1
    %38 = llhd.extract_slice %8, 15 : i20 -> i1
    %39 = llhd.xor %37, %38 : i1
    %40 = llhd.extract_slice %8, 16 : i20 -> i1
    %41 = llhd.xor %39, %40 : i1
    %42 = llhd.extract_slice %8, 17 : i20 -> i1
    %43 = llhd.xor %41, %42 : i1
    %44 = llhd.extract_slice %8, 18 : i20 -> i1
    %45 = llhd.xor %43, %44 : i1
    %46 = llhd.extract_slice %8, 19 : i20 -> i1
    %47 = llhd.xor %45, %46 : i1
    %48 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %4, %47 after %48 : !llhd.sig<i1>
    %49 = llhd.const 1 : i32
    %50 = llhd.const 0 : i20
    %51 = llhd.sig "s1" %50 : i20
    %52 = llhd.shr %Z, %51, %49 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %53 = llhd.extract_slice %52, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A2 = llhd.prb %A : !llhd.sig<i20>
    %54 = llhd.const 1 : i1
    %55 = llhd.const 0 : i20
    %56 = llhd.shr %A2, %55, %54 : (i20, i20, i1) -> i20
    %57 = llhd.extract_slice %56, 0 : i20 -> i19
    %58 = llhd.extract_slice %57, 0 : i19 -> i1
    %59 = llhd.extract_slice %57, 1 : i19 -> i1
    %60 = llhd.xor %58, %59 : i1
    %61 = llhd.extract_slice %57, 2 : i19 -> i1
    %62 = llhd.xor %60, %61 : i1
    %63 = llhd.extract_slice %57, 3 : i19 -> i1
    %64 = llhd.xor %62, %63 : i1
    %65 = llhd.extract_slice %57, 4 : i19 -> i1
    %66 = llhd.xor %64, %65 : i1
    %67 = llhd.extract_slice %57, 5 : i19 -> i1
    %68 = llhd.xor %66, %67 : i1
    %69 = llhd.extract_slice %57, 6 : i19 -> i1
    %70 = llhd.xor %68, %69 : i1
    %71 = llhd.extract_slice %57, 7 : i19 -> i1
    %72 = llhd.xor %70, %71 : i1
    %73 = llhd.extract_slice %57, 8 : i19 -> i1
    %74 = llhd.xor %72, %73 : i1
    %75 = llhd.extract_slice %57, 9 : i19 -> i1
    %76 = llhd.xor %74, %75 : i1
    %77 = llhd.extract_slice %57, 10 : i19 -> i1
    %78 = llhd.xor %76, %77 : i1
    %79 = llhd.extract_slice %57, 11 : i19 -> i1
    %80 = llhd.xor %78, %79 : i1
    %81 = llhd.extract_slice %57, 12 : i19 -> i1
    %82 = llhd.xor %80, %81 : i1
    %83 = llhd.extract_slice %57, 13 : i19 -> i1
    %84 = llhd.xor %82, %83 : i1
    %85 = llhd.extract_slice %57, 14 : i19 -> i1
    %86 = llhd.xor %84, %85 : i1
    %87 = llhd.extract_slice %57, 15 : i19 -> i1
    %88 = llhd.xor %86, %87 : i1
    %89 = llhd.extract_slice %57, 16 : i19 -> i1
    %90 = llhd.xor %88, %89 : i1
    %91 = llhd.extract_slice %57, 17 : i19 -> i1
    %92 = llhd.xor %90, %91 : i1
    %93 = llhd.extract_slice %57, 18 : i19 -> i1
    %94 = llhd.xor %92, %93 : i1
    %95 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %53, %94 after %95 : !llhd.sig<i1>
    %96 = llhd.const 2 : i32
    %97 = llhd.const 0 : i20
    %98 = llhd.sig "s2" %97 : i20
    %99 = llhd.shr %Z, %98, %96 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %100 = llhd.extract_slice %99, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A3 = llhd.prb %A : !llhd.sig<i20>
    %101 = llhd.const 2 : i2
    %102 = llhd.const 0 : i20
    %103 = llhd.shr %A3, %102, %101 : (i20, i20, i2) -> i20
    %104 = llhd.extract_slice %103, 0 : i20 -> i18
    %105 = llhd.extract_slice %104, 0 : i18 -> i1
    %106 = llhd.extract_slice %104, 1 : i18 -> i1
    %107 = xor %105, %106 : i1
    %108 = llhd.extract_slice %104, 2 : i18 -> i1
    %109 = xor %107, %108 : i1
    %110 = llhd.extract_slice %104, 3 : i18 -> i1
    %111 = xor %109, %110 : i1
    %112 = llhd.extract_slice %104, 4 : i18 -> i1
    %113 = xor %111, %112 : i1
    %114 = llhd.extract_slice %104, 5 : i18 -> i1
    %115 = xor %113, %114 : i1
    %116 = llhd.extract_slice %104, 6 : i18 -> i1
    %117 = xor %115, %116 : i1
    %118 = llhd.extract_slice %104, 7 : i18 -> i1
    %119 = xor %117, %118 : i1
    %120 = llhd.extract_slice %104, 8 : i18 -> i1
    %121 = xor %119, %120 : i1
    %122 = llhd.extract_slice %104, 9 : i18 -> i1
    %123 = xor %121, %122 : i1
    %124 = llhd.extract_slice %104, 10 : i18 -> i1
    %125 = xor %123, %124 : i1
    %126 = llhd.extract_slice %104, 11 : i18 -> i1
    %127 = xor %125, %126 : i1
    %128 = llhd.extract_slice %104, 12 : i18 -> i1
    %129 = xor %127, %128 : i1
    %130 = llhd.extract_slice %104, 13 : i18 -> i1
    %131 = xor %129, %130 : i1
    %132 = llhd.extract_slice %104, 14 : i18 -> i1
    %133 = xor %131, %132 : i1
    %134 = llhd.extract_slice %104, 15 : i18 -> i1
    %135 = xor %133, %134 : i1
    %136 = llhd.extract_slice %104, 16 : i18 -> i1
    %137 = xor %135, %136 : i1
    %138 = llhd.extract_slice %104, 17 : i18 -> i1
    %139 = xor %137, %138 : i1
    %140 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %100, %139 after %140 : !llhd.sig<i1>
    %141 = llhd.const 3 : i32
    %142 = llhd.const 0 : i20
    %143 = llhd.sig "s3" %142 : i20
    %144 = llhd.shr %Z, %143, %141 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %145 = llhd.extract_slice %144, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A4 = llhd.prb %A : !llhd.sig<i20>
    %146 = llhd.const 3 : i2
    %147 = llhd.const 0 : i20
    %148 = llhd.shr %A4, %147, %146 : (i20, i20, i2) -> i20
    %149 = llhd.extract_slice  %148, 0 : i20 -> i17
    %150 = llhd.extract_slice %149, 0 : i17 -> i1
    %151 = llhd.extract_slice %149, 1 : i17 -> i1
    %152 = llhd.xor %150, %151 : i1
    %153 = llhd.extract_slice %149, 2 : i17 -> i1
    %154 = llhd.xor %152, %153 : i1
    %155 = llhd.extract_slice %149, 3 : i17 -> i1
    %156 = llhd.xor %154, %155 : i1
    %157 = llhd.extract_slice %149, 4 : i17 -> i1
    %158 = llhd.xor %156, %157 : i1
    %159 = llhd.extract_slice %149, 5 : i17 -> i1
    %160 = llhd.xor %158, %159 : i1
    %161 = llhd.extract_slice %149, 6 : i17 -> i1
    %162 = llhd.xor %160, %161 : i1
    %163 = llhd.extract_slice %149, 7 : i17 -> i1
    %164 = llhd.xor %162, %163 : i1
    %165 = llhd.extract_slice %149, 8 : i17 -> i1
    %166 = llhd.xor %164, %165 : i1
    %167 = llhd.extract_slice %149, 9 : i17 -> i1
    %168 = llhd.xor %166, %167 : i1
    %169 = llhd.extract_slice %149, 10 : i17 -> i1
    %170 = llhd.xor %168, %169 : i1
    %171 = llhd.extract_slice %149, 11 : i17 -> i1
    %172 = llhd.xor %170, %171 : i1
    %173 = llhd.extract_slice %149, 12 : i17 -> i1
    %174 = llhd.xor %172, %173 : i1
    %175 = llhd.extract_slice %149, 13 : i17 -> i1
    %176 = llhd.xor %174, %175 : i1
    %177 = llhd.extract_slice %149, 14 : i17 -> i1
    %178 = llhd.xor %176, %177 : i1
    %179 = llhd.extract_slice %149, 15 : i17 -> i1
    %180 = llhd.xor %178, %179 : i1
    %181 = llhd.extract_slice %149, 16 : i17 -> i1
    %182 = llhd.xor %180, %181 : i1
    %183 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %145, %182 after %183 : !llhd.sig<i1>
    %184 = llhd.const 4 : i32
    %185 = llhd.const 0 : i20
    %186 = llhd.sig "s4" %185 : i20
    %187 = llhd.shr %Z, %186,  %184 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %188 = llhd.extract_slice %187, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A5 = llhd.prb %A : !llhd.sig<i20>
    %189 = llhd.const 4 : i3
    %190 = llhd.const 0 : i20
    %191 = llhd.shr %A5, %190, %189 : (i20, i20, i3) -> i20
    %192 = llhd.extract_slice %191, 0 : i20 -> i16
    %193 = llhd.extract_slice %192, 0 : i16 -> i1
    %194 = llhd.extract_slice %192, 1 : i16 -> i1
    %195 = llhd.xor %193, %194 : i1
    %196 = llhd.extract_slice %192, 2 : i16 -> i1
    %197 = llhd.xor %195, %196 : i1
    %198 = llhd.extract_slice %192, 3 : i16 -> i1
    %199 = llhd.xor %197, %198 : i1
    %200 = llhd.extract_slice %192, 4 : i16 -> i1
    %201 = llhd.xor %199, %200 : i1
    %202 = llhd.extract_slice %192, 5 : i16 -> i1
    %203 = llhd.xor %201, %202 : i1
    %204 = llhd.extract_slice %192, 6 : i16 -> i1
    %205 = llhd.xor %203, %204 : i1
    %206 = llhd.extract_slice %192, 7 : i16 -> i1
    %207 = llhd.xor %205, %206 : i1
    %208 = llhd.extract_slice %192, 8 : i16 -> i1
    %209 = llhd.xor %207, %208 : i1
    %210 = llhd.extract_slice %192, 9 : i16 -> i1
    %211 = llhd.xor %209, %210 : i1
    %212 = llhd.extract_slice %192, 10 : i16 -> i1
    %213 = llhd.xor %211, %212 : i1
    %214 = llhd.extract_slice %192, 11 : i16 -> i1
    %215 = llhd.xor %213, %214 : i1
    %216 = llhd.extract_slice %192, 12 : i16 -> i1
    %217 = llhd.xor %215, %216 : i1
    %218 = llhd.extract_slice %192, 13 : i16 -> i1
    %219 = llhd.xor %217, %218 : i1
    %220 = llhd.extract_slice %192, 14 : i16 -> i1
    %221 = llhd.xor %219, %220 : i1
    %222 = llhd.extract_slice %192, 15 : i16 -> i1
    %223 = llhd.xor %221, %222 : i1
    %224 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %188, %223 after %224 : !llhd.sig<i1>
    %225 = llhd.const 5 : i32
    %226 = llhd.const 0 : i20
    %227 = llhd.sig "s5" %226 : i20
    %228 = llhd.shr %Z, %227, %225 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %229 = llhd.extract_slice %228, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A6 = llhd.prb %A : !llhd.sig<i20>
    %230 = llhd.const 5 : i32
    %231 = llhd.const 0 : i20
    %232 = llhd.shr %A6, %231, %230 : (i20, i20, i32) -> i20
    %233 = llhd.extract_slice %232, 0 : i20 -> i15
    %234 = llhd.extract_slice %233, 0 : i15 -> i1
    %235 = llhd.extract_slice %233, 1 : i15 -> i1
    %236 = llhd.xor %234, %235 : i1
    %237 = llhd.extract_slice %233, 2 : i15 -> i1
    %238 = llhd.xor %236, %237 : i1
    %239 = llhd.extract_slice %233, 3 : i15 -> i1
    %240 = llhd.xor %238, %239 : i1
    %241 = llhd.extract_slice %233, 4 : i15 -> i1
    %242 = llhd.xor %240, %241 : i1
    %243 = llhd.extract_slice %233, 5 : i15 -> i1
    %244 = llhd.xor %242, %243 : i1
    %245 = llhd.extract_slice %233, 6 : i15 -> i1
    %246 = llhd.xor %244, %245 : i1
    %247 = llhd.extract_slice %233, 7 : i15 -> i1
    %248 = llhd.xor %246, %247 : i1
    %249 = llhd.extract_slice %233, 8 : i15 -> i1
    %250 = llhd.xor %248, %249 : i1
    %251 = llhd.extract_slice %233, 9 : i15 -> i1
    %252 = llhd.xor %250, %251 : i1
    %253 = llhd.extract_slice %233, 10 : i15 -> i1
    %254 = llhd.xor %252, %253 : i1
    %255 = llhd.extract_slice %233, 11 : i15 -> i1
    %256 = llhd.xor %254, %255 : i1
    %257 = llhd.extract_slice %233, 12 : i15 -> i1
    %258 = llhd.xor %256, %257 : i1
    %259 = llhd.extract_slice %233, 13 : i15 -> i1
    %260 = llhd.xor %258, %259 : i1
    %261 = llhd.extract_slice %233, 14 : i15 -> i1
    %262 = llhd.xor %260, %261 : i1
    %263 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %229, %262 after %263 : !llhd.sig<i1>
    %264 = llhd.const 6 : i32
    %265 = llhd.const 0 : i20
    %266 = llhd.sig "s6" %265 : i20
    %267 = llhd.shr %Z, %266, %264 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %268 = llhd.extract_slice %267, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A7 = llhd.prb %A : !llhd.sig<i20>
    %269 = llhd.const 6 : i3
    %270 = llhd.const 0 : i20
    %271 = llhd.shr %A7, %270, %269 : (i20, i20, i3) -> i20
    %272 = llhd.extract_slice %271, 0 : i20 -> i14
    %273 = llhd.extract_slice %272, 0 : i14 -> i1
    %274 = llhd.extract_slice %272, 1 : i14 -> i1
    %275 = llhd.xor %273, %274 : i1
    %276 = llhd.extract_slice %272, 2 : i14 -> i1
    %277 = llhd.xor %275, %276 : i1
    %278 = llhd.extract_slice %272, 3 : i14 -> i1
    %279 = llhd.xor %277, %278 : i1
    %280 = llhd.extract_slice %272, 4 : i14 -> i1
    %281 = llhd.xor %279, %280 : i1
    %282 = llhd.extract_slice %272, 5 : i14 -> i1
    %283 = llhd.xor %281, %282 : i1
    %284 = llhd.extract_slice %272, 6 : i14 -> i1
    %285 = llhd.xor %283, %284 : i1
    %286 = llhd.extract_slice %272, 7 : i14 -> i1
    %287 = llhd.xor %285, %286 : i1
    %288 = llhd.extract_slice %272, 8 : i14 -> i1
    %289 = llhd.xor %287, %288 : i1
    %290 = llhd.extract_slice %272, 9 : i14 -> i1
    %291 = llhd.xor %289, %290 : i1
    %292 = llhd.extract_slice %272, 10 : i14 -> i1
    %293 = llhd.xor %291, %292 : i1
    %294 = llhd.extract_slice %272, 11 : i14 -> i1
    %295 = llhd.xor %293, %294 : i1
    %296 = llhd.extract_slice %272, 12 : i14 -> i1
    %297 = llhd.xor %295, %296 : i1
    %298 = llhd.extract_slice %272, 13 : i14 -> i1
    %299 = llhd.xor %297, %298 : i1
    %300 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %268, %299 after %300 : !llhd.sig<i1>
    %301 = llhd.const 7 : i32
    %302 = llhd.const 0 : i20
    %303 = llhd.sig "s7" %302 : i20
    %304 = llhd.shr %Z, %303, %301 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %305 = llhd.extract_slice %304, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A8 = llhd.prb %A : !llhd.sig<i20>
    %306 = llhd.const 7 : i3
    %307 = llhd.const 0 : i20
    %308 = llhd.shr %A8, %307, %306 : (i20, i20, i3) -> i20
    %309 = llhd.extract_slice %308, 0 : i20 -> i13
    %310 = llhd.extract_slice %309, 0 : i13 -> i1
    %311 = llhd.extract_slice %309, 1 : i13 -> i1
    %312 = llhd.xor %310, %311 : i1
    %313 = llhd.extract_slice %309, 2 : i13 -> i1
    %314 = llhd.xor %312, %313 : i1
    %315 = llhd.extract_slice %309, 3 : i13 -> i1
    %316 = llhd.xor %314, %315 : i1
    %317 = llhd.extract_slice %309, 4 : i13 -> i1
    %318 = llhd.xor %316, %317 : i1
    %319 = llhd.extract_slice %309, 5 : i13 -> i1
    %320 = llhd.xor %318, %319 : i1
    %321 = llhd.extract_slice %309, 6 : i13 -> i1
    %322 = llhd.xor %320, %321 : i1
    %323 = llhd.extract_slice %309, 7 : i13 -> i1
    %324 = llhd.xor %322, %323 : i1
    %325 = llhd.extract_slice %309, 8 : i13 -> i1
    %326 = llhd.xor %324, %325 : i1
    %327 = llhd.extract_slice %309, 9 : i13 -> i1
    %328 = llhd.xor %326, %327 : i1
    %329 = llhd.extract_slice %309, 10 : i13 -> i1
    %330 = llhd.xor %328, %329 : i1
    %331 = llhd.extract_slice %309, 11 : i13 -> i1
    %332 = llhd.xor %330, %331 : i1
    %333 = llhd.extract_slice %309, 12 : i13 -> i1
    %334 = llhd.xor %332, %333 : i1
    %335 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %305, %334 after %335 : !llhd.sig<i1>
    %336 = llhd.const 8 : i32
    %337 = llhd.const 0 : i20
    %338 = llhd.sig "s8" %337 : i20
    %339 = llhd.shr %Z, %338, %336 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %340 = llhd.extract_slice %339, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A9 = llhd.prb %A : !llhd.sig<i20>
    %341 = llhd.const 8 : i4
    %342 = llhd.const 0 : i20
    %343 = llhd.shr %A9, %342, %341 : (i20, i20, i4) -> i20
    %344 = llhd.extract_slice %343, 0 : i20 -> i12
    %345 = llhd.extract_slice %344, 0 : i12 -> i1
    %346 = llhd.extract_slice %344, 1 : i12 -> i1
    %347 = llhd.xor %345, %346 : i1
    %348 = llhd.extract_slice %344, 2 : i12 -> i1
    %349 = llhd.xor %347, %348 : i1
    %350 = llhd.extract_slice %344, 3 : i12 -> i1
    %351 = llhd.xor %349, %350 : i1
    %352 = llhd.extract_slice %344, 4 : i12 -> i1
    %353 = llhd.xor %351, %352 : i1
    %354 = llhd.extract_slice %344, 5 : i12 -> i1
    %355 = llhd.xor %353, %354 : i1
    %356 = llhd.extract_slice %344, 6 : i12 -> i1
    %357 = llhd.xor %355, %356 : i1
    %358 = llhd.extract_slice %344, 7 : i12 -> i1
    %359 = llhd.xor %357, %358 : i1
    %360 = llhd.extract_slice %344, 8 : i12 -> i1
    %361 = llhd.xor %359, %360 : i1
    %362 = llhd.extract_slice %344, 9 : i12 -> i1
    %363 = llhd.xor %361, %362 : i1
    %364 = llhd.extract_slice %344, 10 : i12 -> i1
    %365 = llhd.xor %363, %364 : i1
    %366 = llhd.extract_slice %344, 11 : i12 -> i1
    %367 = llhd.xor %365, %366 : i1
    %368 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %340, %367 after %368 : !llhd.sig<i1>
    %369 = llhd.const 9 : i32
    %370 = llhd.const 0 : i20
    %371 = llhd.sig "s9" %370 : i20
    %372 = llhd.shr %Z, %371, %369 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %373 = llhd.extract_slice %372, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A10 = llhd.prb %A : !llhd.sig<i20>
    %374 = llhd.const 9 : i4
    %375 = llhd.const 0 : i20
    %376 = llhd.shr %A10, %375, %374 : (i20, i20, i4) -> i20
    %377 = llhd.extract_slice %376, 0 : i20 -> i11
    %378 = llhd.extract_slice %377, 0 : i11 -> i1
    %379 = llhd.extract_slice %377, 1 : i11 -> i1
    %380 = llhd.xor %378, %379 : i1
    %381 = llhd.extract_slice %377, 2 : i11 -> i1
    %382 = llhd.xor %380, %381 : i1
    %383 = llhd.extract_slice %377, 3 : i11 -> i1
    %384 = llhd.xor %382, %383 : i1
    %385 = llhd.extract_slice %377, 4 : i11 -> i1
    %386 = llhd.xor %384, %385 : i1
    %387 = llhd.extract_slice %377, 5 : i11 -> i1
    %388 = llhd.xor %386, %387 : i1
    %389 = llhd.extract_slice %377, 6 : i11 -> i1
    %390 = llhd.xor %388, %389 : i1
    %391 = llhd.extract_slice %377, 7 : i11 -> i1
    %392 = llhd.xor %390, %391 : i1
    %393 = llhd.extract_slice %377, 8 : i11 -> i1
    %394 = llhd.xor %392, %393 : i1
    %395 = llhd.extract_slice %377, 9 : i11 -> i1
    %396 = llhd.xor %394, %395 : i1
    %397 = llhd.extract_slice %377, 10 : i11 -> i1
    %398 = llhd.xor %396, %397 : i1
    %399 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %373, %398 after %399 : !llhd.sig<i1>
    %400 = llhd.const 10 : i32
    %401 = llhd.const 0 : i20
    %402 = llhd.sig "s10" %401 : i20
    %403 = llhd.shr %Z, %402, %400 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %404 = llhd.extract_slice %403, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A11 = llhd.prb %A : !llhd.sig<i20>
    %405 = llhd.const 10 : i4
    %406 = llhd.const 0 : i20
    %407 = llhd.shr %A11, %406, %405 : (i20, i20, i4) -> i20
    %408 = llhd.extract_slice %407, 0 : i20 -> i10
    %409 = llhd.extract_slice %408, 0 : i10 -> i1
    %410 = llhd.extract_slice %408, 1 : i10 -> i1
    %411 = llhd.xor %409, %410 : i1
    %412 = llhd.extract_slice %408, 2 : i10 -> i1
    %413 = llhd.xor %411, %412 : i1
    %414 = llhd.extract_slice %408, 3 : i10 -> i1
    %415 = llhd.xor %413, %414 : i1
    %416 = llhd.extract_slice %408, 4 : i10 -> i1
    %417 = llhd.xor %415, %416 : i1
    %418 = llhd.extract_slice %408, 5 : i10 -> i1
    %419 = llhd.xor %417, %418 : i1
    %420 = llhd.extract_slice %408, 6 : i10 -> i1
    %421 = llhd.xor %419, %420 : i1
    %422 = llhd.extract_slice %408, 7 : i10 -> i1
    %423 = llhd.xor %421, %422 : i1
    %424 = llhd.extract_slice %408, 8 : i10 -> i1
    %425 = llhd.xor %423, %424 : i1
    %426 = llhd.extract_slice %408, 9 : i10 -> i1
    %427 = llhd.xor %425, %426 : i1
    %428 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %404, %427 after %428 : !llhd.sig<i1>
    %429 = llhd.const 11 : i32
    %430 = llhd.const 0 : i20
    %431 = llhd.sig "s11" %430 : i20
    %432 = llhd.shr %Z, %431, %429 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %433 = llhd.extract_slice %432, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A12 = llhd.prb %A : !llhd.sig<i20>
    %434 = llhd.const 11 : i4
    %435 = llhd.const 0 : i20
    %436 = llhd.shr %A12, %435, %434 : (i20, i20, i4) -> i20
    %437 = llhd.extract_slice %436, 0 : i20 -> i9
    %438 = llhd.extract_slice %437, 0 : i9 -> i1
    %439 = llhd.extract_slice %437, 1 : i9 -> i1
    %440 = llhd.xor %438, %439 : i1
    %441 = llhd.extract_slice %437, 2 : i9 -> i1
    %442 = llhd.xor %440, %441 : i1
    %443 = llhd.extract_slice %437, 3 : i9 -> i1
    %444 = llhd.xor %442, %443 : i1
    %445 = llhd.extract_slice %437, 4 : i9 -> i1
    %446 = llhd.xor %444, %445 : i1
    %447 = llhd.extract_slice %437, 5 : i9 -> i1
    %448 = llhd.xor %446, %447 : i1
    %449 = llhd.extract_slice %437, 6 : i9 -> i1
    %450 = llhd.xor %448, %449 : i1
    %451 = llhd.extract_slice %437, 7 : i9 -> i1
    %452 = llhd.xor %450, %451 : i1
    %453 = llhd.extract_slice %437, 8 : i9 -> i1
    %454 = llhd.xor %452, %453 : i1
    %455 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %433, %454 after %455 : !llhd.sig<i1>
    %456 = llhd.const 12 : i32
    %457 = llhd.const 0 : i20
    %458 = llhd.sig "s12" %457 : i20
    %459 = llhd.shr %Z, %458, %456 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %460 = llhd.extract_slice %459, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A13 = llhd.prb %A : !llhd.sig<i20>
    %461 = llhd.const 12 : i4
    %462 = llhd.const 0 : i20
    %463 = llhd.shr %A13, %462, %461 : (i20, i20, i4) -> i20
    %464 = llhd.extract_slice %463, 0 : i20 -> i8
    %465 = llhd.extract_slice %464, 0 : i8 -> i1
    %466 = llhd.extract_slice %464, 1 : i8 -> i1
    %467 = llhd.xor %465, %466 : i1
    %468 = llhd.extract_slice %464, 2 : i8 -> i1
    %469 = llhd.xor %467, %468 : i1
    %470 = llhd.extract_slice %464, 3 : i8 -> i1
    %471 = llhd.xor %469, %470 : i1
    %472 = llhd.extract_slice %464, 4 : i8 -> i1
    %473 = llhd.xor %471, %472 : i1
    %474 = llhd.extract_slice %464, 5 : i8 -> i1
    %475 = llhd.xor %473, %474 : i1
    %476 = llhd.extract_slice %464, 6 : i8 -> i1
    %477 = llhd.xor %475, %476 : i1
    %478 = llhd.extract_slice %464, 7 : i8 -> i1
    %479 = llhd.xor %477, %478 : i1
    %480 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %460, %479 after %480 : !llhd.sig<i1>
    %481 = llhd.const 13 : i32
    %482 = llhd.const 0 : i20
    %483 = llhd.sig "s13" %482 : i20
    %484 = llhd.shr %Z, %483, %481 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %485 = llhd.extract_slice %484, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A14 = llhd.prb %A : !llhd.sig<i20>
    %486 = llhd.const 13 : i4
    %487 = llhd.const 0 : i20
    %488 = llhd.shr %A14, %487, %486 : (i20, i20, i4) -> i20
    %489 = llhd.extract_slice %488, 0 : i20 -> i7
    %490 = llhd.extract_slice %489, 0 : i7 -> i1
    %491 = llhd.extract_slice %489, 1 : i7 -> i1
    %492 = llhd.xor %490, %491 : i1
    %493 = llhd.extract_slice %489, 2 : i7 -> i1
    %494 = llhd.xor %492, %493 : i1
    %495 = llhd.extract_slice %489, 3 : i7 -> i1
    %496 = llhd.xor %494, %495 : i1
    %497 = llhd.extract_slice %489, 4 : i7 -> i1
    %498 = llhd.xor %496, %497 : i1
    %499 = llhd.extract_slice %489, 5 : i7 -> i1
    %500 = llhd.xor %498, %499 : i1
    %501 = llhd.extract_slice %489, 6 : i7 -> i1
    %502 = llhd.xor %500, %501 : i1
    %503 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %485, %502 after %503 : !llhd.sig<i1>
    %504 = llhd.const 14 : i32
    %505 = llhd.const 0 :i20
    %506 = llhd.sig "s14" %505 : i20
    %507 = llhd.shr %Z, %506, %504 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %508 = llhd.extract_slice %507, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A15 = llhd.prb %A : !llhd.sig<i20>
    %509 = llhd.const 14 : i4
    %510 = llhd.const 0 : i20
    %511 = llhd.shr %A15, %510, %509 : (i20, i20, i4) -> i20
    %512 = llhd.extract_slice %511, 0 : i20 -> i6
    %513 = llhd.extract_slice %512, 0 : i6 -> i1
    %514 = llhd.extract_slice %512, 1 : i6 -> i1
    %515 = llhd.xor %513, %514 : i1
    %516 = llhd.extract_slice %512, 2 : i6 -> i1
    %517 = llhd.xor %515, %516 : i1
    %518 = llhd.extract_slice %512, 3 : i6 -> i1
    %519 = llhd.xor %517, %518 : i1
    %520 = llhd.extract_slice %512, 4 : i6 -> i1
    %521 = llhd.xor %519, %520 : i1
    %522 = llhd.extract_slice %512, 5 : i6 -> i1
    %523 = llhd.xor %521, %522 : i1
    %524 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %508, %523 after %524 : !llhd.sig<i1>
    %525 = llhd.const 15 : i32
    %526 = llhd.const 0 : i20
    %527 = llhd.sig "s15" %526 : i20
    %528 = llhd.shr %Z, %527, %525 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %529 = llhd.extract_slice %528, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A16 = llhd.prb %A : !llhd.sig<i20>
    %530 = llhd.const 15 : i4
    %531 = llhd.const 0 : i20
    %532 = llhd.shr %A16, %531, %530 : (i20, i20, i4) -> i20
    %533 = llhd.extract_slice %532, 0 : i20 -> i5
    %534 = llhd.extract_slice %533, 0 : i5 -> i1
    %535 = llhd.extract_slice %533, 1 : i5 -> i1
    %536 = llhd.xor %534, %535 : i1
    %537 = llhd.extract_slice %533, 2 : i5 -> i1
    %538 = llhd.xor %536, %537 : i1
    %539 = llhd.extract_slice %533, 3 : i5 -> i1
    %540 = llhd.xor %538, %539 : i1
    %541 = llhd.extract_slice %533, 4 : i5 -> i1
    %542 = llhd.xor %540, %541 : i1
    %543 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %529, %542 after %543 : !llhd.sig<i1>
    %544 = llhd.const 16 : i32
    %545 = llhd.const 0 : i20
    %546 = llhd.sig "s16" %545 : i20
    %547 = llhd.shr %Z, %546, %544 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %548 = llhd.extract_slice %547, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A17 = llhd.prb %A : !llhd.sig<i20>
    %549 = llhd.const 16 : i5
    %550 = llhd.const 0 : i20
    %551 = llhd.shr %A17, %550, %549 : (i20, i20, i5) -> i20
    %552 = llhd.extract_slice %551, 0 : i20 -> i4
    %553 = llhd.extract_slice %552, 0 : i4 -> i1
    %554 = llhd.extract_slice %552, 1 : i4 -> i1
    %555 = llhd.xor %553, %554 : i1
    %556 = llhd.extract_slice %552, 2 : i4 -> i1
    %557 = llhd.xor %555, %556 : i1
    %558 = llhd.extract_slice %552, 3 : i4 -> i1
    %559 = llhd.xor %557, %558 : i1
    %560 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %548, %559 after %560 : !llhd.sig<i1>
    %561 = llhd.const 17 : i32
    %562 = llhd.const 0 : i20
    %563 = llhd.sig "s17" %562 : i20
    %564 = llhd.shr %Z, %563, %561 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %565 = llhd.extract_slice %564, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A18 = llhd.prb %A : !llhd.sig<i20>
    %566 = llhd.const 17 : i5
    %567 = llhd.const 0 : i20
    %568 = llhd.shr %A18, %567, %566 : (i20, i20, i5) -> i20
    %569 = llhd.extract_slice %568, 0 : i20 -> i3
    %570 = llhd.extract_slice %569, 0 : i3 -> i1
    %571 = llhd.extract_slice %569, 1 : i3 -> i1
    %572 = llhd.xor %570, %571 : i1
    %573 = llhd.extract_slice %569, 2 : i3 -> i1
    %574 = llhd.xor %572, %573 : i1
    %575 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %565, %574 after %575 : !llhd.sig<i1>
    %576 = llhd.const 18 : i32
    %577 = llhd.const 0 : i20
    %578 = llhd.sig "s18" %577 : i20
    %579 = llhd.shr %Z, %578, %576 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %580 = llhd.extract_slice %579, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A19 = llhd.prb %A : !llhd.sig<i20>
    %581 = llhd.const 18 : i5
    %582 = llhd.const 0 : i20
    %583 = llhd.shr %A19, %582, %581 : (i20, i20, i5) -> i20
    %584 = llhd.extract_slice %583, 0 : i20 -> i2
    %585 = llhd.extract_slice %584, 0 : i2 -> i1
    %586 = llhd.extract_slice %584, 1 : i2 -> i1
    %587 = llhd.xor %585, %586 : i1
    %588 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %580, %587 after %588 : !llhd.sig<i1>
    %589 = llhd.const 19 : i32
    %590 = llhd.const 0 : i20
    %591 = llhd.sig "s19" %590 : i20
    %592 = llhd.shr %Z, %591, %589 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %593 = llhd.extract_slice %592, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A20 = llhd.prb %A : !llhd.sig<i20>
    %594 = llhd.const 19 : i5
    %595 = llhd.const 0 : i20
    %596 = llhd.shr %A20, %595, %594 : (i20, i20, i5) -> i20
    %597 = llhd.extract_slice %596, 0 : i20 -> i1
    %598 = llhd.extract_slice %597, 0 : i1 -> i1
    %599 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %593, %598 after %599 : !llhd.sig<i1>
    // %600 = llhd.const 0 : i20
    // %601 = llhd.const #llhd.time<0ns, 1d, 0e> : !llhd.time
    // llhd.drv %Z, %600 after %601 : !llhd.sig<i20>
}

llhd.entity @graycode.param1 (%A : !llhd.sig<i20>) -> (%G : !llhd.sig<i20>, %Z : !llhd.sig<i20>) {
    %A1 = llhd.prb %A : !llhd.sig<i20>
    %0 = llhd.const 0 : i20
    %1 = llhd.sig "sig_0" %0 : i20
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1, %A1 after %2  : !llhd.sig<i20>
    llhd.inst "binary_to_gray" @binary_to_gray.param2 (%1) -> (%G) : (!llhd.sig<i20>) -> (!llhd.sig<i20>)
    %G1 = llhd.prb %G : !llhd.sig<i20>
    %3 = llhd.const 0 : i20
    %4 = llhd.sig "sig_1" %3 : i20
    %5 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %4, %G1 after %5 : !llhd.sig<i20>
    llhd.inst "gray_to_binary" @gray_to_binary.param3 (%4) -> (%Z) : (!llhd.sig<i20>) -> (!llhd.sig<i20>)
}

llhd.proc @graycode_tb.initial.232.0 (%b : !llhd.sig<i20>) -> (%a : !llhd.sig<i20>, %bp : !llhd.sig<i20>) {
    br ^0
^0:
    %1 = llhd.const 0 : i21
    %i = llhd.var %1 : i21
    %2 = llhd.const 0 : i20
    %3 = llhd.const 0 : i1
    %4 = llhd.insert_slice %2, %3, 0 : i20, i1
    %5 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %bp, %4 after %5 : !llhd.sig<i20>
    %6 = llhd.const 2 : i32
    %loop_count = llhd.var %6 : i32
    br ^loop_body
^loop_body:
    %7 = llhd.load %loop_count : !llhd.ptr<i32>
    %8 = llhd.const 0 : i32
    %9 = cmpi "ne", %7, %8 : i32
    cond_br %9, ^loop_continue, ^loop_exit
^loop_exit:
    %10 = llhd.const 0 : i32
    %11 = llhd.extract_slice %10, 0 : i32 -> i21
    llhd.store %i, %11 : !llhd.ptr<i21>
    br ^loop_body1
^loop_continue:
    %12 = llhd.const 0 : i32
    %13 = llhd.extract_slice %12, 0 : i32 -> i21
    llhd.store %i, %13 : !llhd.ptr<i21>
    br ^loop_body2
^loop_body2:
    %14 = llhd.const 0 : i32
    %i1 = llhd.load %i : !llhd.ptr<i21>
    %15 = llhd.insert_slice %14, %i1, 0 : i32, i21
    %16 = llhd.const 1 : i32
    %17 = llhd.const 20 : i32
    %18 = llhd.const 0 : i32
    %19 = llhd.shl %16, %18, %17 : (i32, i32, i32) -> i32
    %20 = cmpi "ult", %15, %19 : i32
    cond_br %20, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %21 = llhd.load %loop_count : !llhd.ptr<i32>
    %22 = llhd.const 1 : i32
    %23 = subi %21, %22 : i32
    llhd.store %loop_count, %23 : !llhd.ptr<i32>
    br ^loop_body
^loop_continue1:
    %i2 = llhd.load %i : !llhd.ptr<i21>
    %24 = llhd.extract_slice %i2, 0 : i21 -> i20
    %25 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %a, %24 after %25 : !llhd.sig<i20>
    %26 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait for %26, ^27
^27:
    %b1 = llhd.prb %b : !llhd.sig<i20>
    %28 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %bp, %b1 after %28 : !llhd.sig<i20>
    %i3 = llhd.load %i : !llhd.ptr<i21>
    %29 = llhd.const 1 : i21
    %30 = addi %i3, %29 : i21
    llhd.store %i, %30 : !llhd.ptr<i21>
    %i4 = llhd.load %i : !llhd.ptr<i21>
    %31 = llhd.const 0 : i21
    %32 = cmpi "ne", %i4, %31 : i21
    br ^loop_body2
^loop_body1:
    %33 = llhd.const 0 : i32
    %i5 = llhd.load %i : !llhd.ptr<i21>
    %34 = llhd.insert_slice %33, %i5, 0 : i32, i21
    %35 = llhd.const 1 : i32
    %36 = llhd.const 20 : i32
    %37 = llhd.const 0 : i32
    %38 = llhd.shl %35, %37, %36 : (i32, i32, i32) -> i32
    %39 = cmpi "ult", %34, %38 : i32
    cond_br %39, ^loop_continue2, ^loop_exit2
^loop_exit2:
    llhd.halt
^loop_continue2:
    %40 = llhd.const 1 : i32
    %41 = llhd.const 20 : i32
    %42 = llhd.const 0 : i32
    %43 = llhd.shl %40, %42, %41 : (i32, i32, i32) -> i32
    %44 = llhd.const 0 : i32
    %i6 = llhd.load %i : !llhd.ptr<i21>
    %45 = llhd.insert_slice %44, %i6, 0 : i32, i21
    %46 = subi %43, %45 : i32
    %47 = llhd.const 1 : i32
    %48 = subi %46, %47 : i32
    %49 = llhd.extract_slice %48, 0 : i32 -> i20
    %50 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %a, %49 after %50 : !llhd.sig<i20>
    %51 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait for %51, ^52
^52:
    %b2 = llhd.prb %b : !llhd.sig<i20>
    %53 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %bp, %b2 after %53 : !llhd.sig<i20>
    %i7 = llhd.load %i : !llhd.ptr<i21>
    %54 = llhd.const 1 : i21
    %55 = addi %i7, %54 : i21
    llhd.store %i, %55 : !llhd.ptr<i21>
    %i8 = llhd.load %i : !llhd.ptr<i21>
    %56 = llhd.const 0 : i21
    %57 = cmpi "ne", %i8, %56 : i21
    br ^loop_body1
}

llhd.entity @root () -> () {
    %0 = llhd.const 0 : i20
    %a = llhd.sig "a" %0 : i20
    %1 = llhd.const 0 : i20
    %b = llhd.sig "b" %1 : i20
    %2 = llhd.const 0 : i20
    %c = llhd.sig "c" %2 : i20
    %3 = llhd.const 0 : i20
    %bp = llhd.sig "bp" %3 : i20
    %a1 = llhd.prb %a : !llhd.sig<i20>
    %4 = llhd.const 0 : i20
    %5 = llhd.sig "5" %4 : i20
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %5, %a1 after %6 : !llhd.sig<i20>
    llhd.inst "graycode" @graycode.param1 (%5) -> (%b, %c) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
    llhd.inst "graycode_tb" @graycode_tb.initial.232.0 (%b) -> (%a, %bp) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
}
