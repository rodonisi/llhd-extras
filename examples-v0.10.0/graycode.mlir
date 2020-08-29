llhd.entity @binary_to_gray.param3(%A: !llhd.sig<i20>) -> (%Z: !llhd.sig<i20> ) {
    %A.prb = llhd.prb %A : !llhd.sig<i20>
    %0 = llhd.extract_slice %A.prb, 1 : i20 -> i19
    %1 = llhd.const 0 : i20
    %2 = llhd.insert_slice %1, %0, 0 : i20, i19
    %3 = llhd.xor %A.prb, %2 : i20
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i20>
}

llhd.entity @gray_to_binary.param5(%A: !llhd.sig<i20>) -> (%Z: !llhd.sig<i20> ) {
    %0 = llhd.extract_slice %Z, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %A.prb = llhd.prb %A : !llhd.sig<i20>
    %1 = llhd.extract_slice %A.prb, 0 : i20 -> i1
    %2 = llhd.extract_slice %A.prb, 1 : i20 -> i1
    %3 = llhd.xor %1, %2 : i1
    %4 = llhd.extract_slice %A.prb, 2 : i20 -> i1
    %5 = llhd.xor %3, %4 : i1
    %6 = llhd.extract_slice %A.prb, 3 : i20 -> i1
    %7 = llhd.xor %5, %6 : i1
    %8 = llhd.extract_slice %A.prb, 4 : i20 -> i1
    %9 = llhd.xor %7, %8 : i1
    %10 = llhd.extract_slice %A.prb, 5 : i20 -> i1
    %11 = llhd.xor %9, %10 : i1
    %12 = llhd.extract_slice %A.prb, 6 : i20 -> i1
    %13 = llhd.xor %11, %12 : i1
    %14 = llhd.extract_slice %A.prb, 7 : i20 -> i1
    %15 = llhd.xor %13, %14 : i1
    %16 = llhd.extract_slice %A.prb, 8 : i20 -> i1
    %17 = llhd.xor %15, %16 : i1
    %18 = llhd.extract_slice %A.prb, 9 : i20 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.extract_slice %A.prb, 10 : i20 -> i1
    %21 = llhd.xor %19, %20 : i1
    %22 = llhd.extract_slice %A.prb, 11 : i20 -> i1
    %23 = llhd.xor %21, %22 : i1
    %24 = llhd.extract_slice %A.prb, 12 : i20 -> i1
    %25 = llhd.xor %23, %24 : i1
    %26 = llhd.extract_slice %A.prb, 13 : i20 -> i1
    %27 = llhd.xor %25, %26 : i1
    %28 = llhd.extract_slice %A.prb, 14 : i20 -> i1
    %29 = llhd.xor %27, %28 : i1
    %30 = llhd.extract_slice %A.prb, 15 : i20 -> i1
    %31 = llhd.xor %29, %30 : i1
    %32 = llhd.extract_slice %A.prb, 16 : i20 -> i1
    %33 = llhd.xor %31, %32 : i1
    %34 = llhd.extract_slice %A.prb, 17 : i20 -> i1
    %35 = llhd.xor %33, %34 : i1
    %36 = llhd.extract_slice %A.prb, 18 : i20 -> i1
    %37 = llhd.xor %35, %36 : i1
    %38 = llhd.extract_slice %A.prb, 19 : i20 -> i1
    %39 = llhd.xor %37, %38 : i1
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %39 after %40 : !llhd.sig<i1>
    %41 = llhd.const 1 : i32
    %42 = llhd.const 0 : i20
    %43 = llhd.sig "43" %42 : i20
    %44 = llhd.shr %Z, %43, %41 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %45 = llhd.extract_slice %44, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %46 = llhd.extract_slice %A.prb, 1 : i20 -> i19
    %47 = llhd.insert_slice %42, %46, 0 : i20, i19
    %48 = llhd.extract_slice %47, 0 : i20 -> i19
    %49 = llhd.extract_slice %48, 0 : i19 -> i1
    %50 = llhd.extract_slice %48, 1 : i19 -> i1
    %51 = llhd.xor %49, %50 : i1
    %52 = llhd.extract_slice %48, 2 : i19 -> i1
    %53 = llhd.xor %51, %52 : i1
    %54 = llhd.extract_slice %48, 3 : i19 -> i1
    %55 = llhd.xor %53, %54 : i1
    %56 = llhd.extract_slice %48, 4 : i19 -> i1
    %57 = llhd.xor %55, %56 : i1
    %58 = llhd.extract_slice %48, 5 : i19 -> i1
    %59 = llhd.xor %57, %58 : i1
    %60 = llhd.extract_slice %48, 6 : i19 -> i1
    %61 = llhd.xor %59, %60 : i1
    %62 = llhd.extract_slice %48, 7 : i19 -> i1
    %63 = llhd.xor %61, %62 : i1
    %64 = llhd.extract_slice %48, 8 : i19 -> i1
    %65 = llhd.xor %63, %64 : i1
    %66 = llhd.extract_slice %48, 9 : i19 -> i1
    %67 = llhd.xor %65, %66 : i1
    %68 = llhd.extract_slice %48, 10 : i19 -> i1
    %69 = llhd.xor %67, %68 : i1
    %70 = llhd.extract_slice %48, 11 : i19 -> i1
    %71 = llhd.xor %69, %70 : i1
    %72 = llhd.extract_slice %48, 12 : i19 -> i1
    %73 = llhd.xor %71, %72 : i1
    %74 = llhd.extract_slice %48, 13 : i19 -> i1
    %75 = llhd.xor %73, %74 : i1
    %76 = llhd.extract_slice %48, 14 : i19 -> i1
    %77 = llhd.xor %75, %76 : i1
    %78 = llhd.extract_slice %48, 15 : i19 -> i1
    %79 = llhd.xor %77, %78 : i1
    %80 = llhd.extract_slice %48, 16 : i19 -> i1
    %81 = llhd.xor %79, %80 : i1
    %82 = llhd.extract_slice %48, 17 : i19 -> i1
    %83 = llhd.xor %81, %82 : i1
    %84 = llhd.extract_slice %48, 18 : i19 -> i1
    %85 = llhd.xor %83, %84 : i1
    llhd.drv %45, %85 after %40 : !llhd.sig<i1>
    %86 = llhd.const 2 : i32
    %87 = llhd.sig "87" %42 : i20
    %88 = llhd.shr %Z, %87, %86 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %89 = llhd.extract_slice %88, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %90 = llhd.extract_slice %A.prb, 2 : i20 -> i18
    %91 = llhd.insert_slice %42, %90, 0 : i20, i18
    %92 = llhd.extract_slice %91, 0 : i20 -> i18
    %93 = llhd.extract_slice %92, 0 : i18 -> i1
    %94 = llhd.extract_slice %92, 1 : i18 -> i1
    %95 = llhd.xor %93, %94 : i1
    %96 = llhd.extract_slice %92, 2 : i18 -> i1
    %97 = llhd.xor %95, %96 : i1
    %98 = llhd.extract_slice %92, 3 : i18 -> i1
    %99 = llhd.xor %97, %98 : i1
    %100 = llhd.extract_slice %92, 4 : i18 -> i1
    %101 = llhd.xor %99, %100 : i1
    %102 = llhd.extract_slice %92, 5 : i18 -> i1
    %103 = llhd.xor %101, %102 : i1
    %104 = llhd.extract_slice %92, 6 : i18 -> i1
    %105 = llhd.xor %103, %104 : i1
    %106 = llhd.extract_slice %92, 7 : i18 -> i1
    %107 = llhd.xor %105, %106 : i1
    %108 = llhd.extract_slice %92, 8 : i18 -> i1
    %109 = llhd.xor %107, %108 : i1
    %110 = llhd.extract_slice %92, 9 : i18 -> i1
    %111 = llhd.xor %109, %110 : i1
    %112 = llhd.extract_slice %92, 10 : i18 -> i1
    %113 = llhd.xor %111, %112 : i1
    %114 = llhd.extract_slice %92, 11 : i18 -> i1
    %115 = llhd.xor %113, %114 : i1
    %116 = llhd.extract_slice %92, 12 : i18 -> i1
    %117 = llhd.xor %115, %116 : i1
    %118 = llhd.extract_slice %92, 13 : i18 -> i1
    %119 = llhd.xor %117, %118 : i1
    %120 = llhd.extract_slice %92, 14 : i18 -> i1
    %121 = llhd.xor %119, %120 : i1
    %122 = llhd.extract_slice %92, 15 : i18 -> i1
    %123 = llhd.xor %121, %122 : i1
    %124 = llhd.extract_slice %92, 16 : i18 -> i1
    %125 = llhd.xor %123, %124 : i1
    %126 = llhd.extract_slice %92, 17 : i18 -> i1
    %127 = llhd.xor %125, %126 : i1
    llhd.drv %89, %127 after %40 : !llhd.sig<i1>
    %128 = llhd.const 3 : i32
    %129 = llhd.sig "129" %42 : i20
    %130 = llhd.shr %Z, %129, %128 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %131 = llhd.extract_slice %130, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %132 = llhd.extract_slice %A.prb, 3 : i20 -> i17
    %133 = llhd.insert_slice %42, %132, 0 : i20, i17
    %134 = llhd.extract_slice %133, 0 : i20 -> i17
    %135 = llhd.extract_slice %134, 0 : i17 -> i1
    %136 = llhd.extract_slice %134, 1 : i17 -> i1
    %137 = llhd.xor %135, %136 : i1
    %138 = llhd.extract_slice %134, 2 : i17 -> i1
    %139 = llhd.xor %137, %138 : i1
    %140 = llhd.extract_slice %134, 3 : i17 -> i1
    %141 = llhd.xor %139, %140 : i1
    %142 = llhd.extract_slice %134, 4 : i17 -> i1
    %143 = llhd.xor %141, %142 : i1
    %144 = llhd.extract_slice %134, 5 : i17 -> i1
    %145 = llhd.xor %143, %144 : i1
    %146 = llhd.extract_slice %134, 6 : i17 -> i1
    %147 = llhd.xor %145, %146 : i1
    %148 = llhd.extract_slice %134, 7 : i17 -> i1
    %149 = llhd.xor %147, %148 : i1
    %150 = llhd.extract_slice %134, 8 : i17 -> i1
    %151 = llhd.xor %149, %150 : i1
    %152 = llhd.extract_slice %134, 9 : i17 -> i1
    %153 = llhd.xor %151, %152 : i1
    %154 = llhd.extract_slice %134, 10 : i17 -> i1
    %155 = llhd.xor %153, %154 : i1
    %156 = llhd.extract_slice %134, 11 : i17 -> i1
    %157 = llhd.xor %155, %156 : i1
    %158 = llhd.extract_slice %134, 12 : i17 -> i1
    %159 = llhd.xor %157, %158 : i1
    %160 = llhd.extract_slice %134, 13 : i17 -> i1
    %161 = llhd.xor %159, %160 : i1
    %162 = llhd.extract_slice %134, 14 : i17 -> i1
    %163 = llhd.xor %161, %162 : i1
    %164 = llhd.extract_slice %134, 15 : i17 -> i1
    %165 = llhd.xor %163, %164 : i1
    %166 = llhd.extract_slice %134, 16 : i17 -> i1
    %167 = llhd.xor %165, %166 : i1
    llhd.drv %131, %167 after %40 : !llhd.sig<i1>
    %168 = llhd.const 4 : i32
    %169 = llhd.sig "169" %42 : i20
    %170 = llhd.shr %Z, %169, %168 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %171 = llhd.extract_slice %170, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %172 = llhd.extract_slice %A.prb, 4 : i20 -> i16
    %173 = llhd.insert_slice %42, %172, 0 : i20, i16
    %174 = llhd.extract_slice %173, 0 : i20 -> i16
    %175 = llhd.extract_slice %174, 0 : i16 -> i1
    %176 = llhd.extract_slice %174, 1 : i16 -> i1
    %177 = llhd.xor %175, %176 : i1
    %178 = llhd.extract_slice %174, 2 : i16 -> i1
    %179 = llhd.xor %177, %178 : i1
    %180 = llhd.extract_slice %174, 3 : i16 -> i1
    %181 = llhd.xor %179, %180 : i1
    %182 = llhd.extract_slice %174, 4 : i16 -> i1
    %183 = llhd.xor %181, %182 : i1
    %184 = llhd.extract_slice %174, 5 : i16 -> i1
    %185 = llhd.xor %183, %184 : i1
    %186 = llhd.extract_slice %174, 6 : i16 -> i1
    %187 = llhd.xor %185, %186 : i1
    %188 = llhd.extract_slice %174, 7 : i16 -> i1
    %189 = llhd.xor %187, %188 : i1
    %190 = llhd.extract_slice %174, 8 : i16 -> i1
    %191 = llhd.xor %189, %190 : i1
    %192 = llhd.extract_slice %174, 9 : i16 -> i1
    %193 = llhd.xor %191, %192 : i1
    %194 = llhd.extract_slice %174, 10 : i16 -> i1
    %195 = llhd.xor %193, %194 : i1
    %196 = llhd.extract_slice %174, 11 : i16 -> i1
    %197 = llhd.xor %195, %196 : i1
    %198 = llhd.extract_slice %174, 12 : i16 -> i1
    %199 = llhd.xor %197, %198 : i1
    %200 = llhd.extract_slice %174, 13 : i16 -> i1
    %201 = llhd.xor %199, %200 : i1
    %202 = llhd.extract_slice %174, 14 : i16 -> i1
    %203 = llhd.xor %201, %202 : i1
    %204 = llhd.extract_slice %174, 15 : i16 -> i1
    %205 = llhd.xor %203, %204 : i1
    llhd.drv %171, %205 after %40 : !llhd.sig<i1>
    %206 = llhd.const 5 : i32
    %207 = llhd.sig "207" %42 : i20
    %208 = llhd.shr %Z, %207, %206 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %209 = llhd.extract_slice %208, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %210 = llhd.extract_slice %A.prb, 5 : i20 -> i15
    %211 = llhd.insert_slice %42, %210, 0 : i20, i15
    %212 = llhd.extract_slice %211, 0 : i20 -> i15
    %213 = llhd.extract_slice %212, 0 : i15 -> i1
    %214 = llhd.extract_slice %212, 1 : i15 -> i1
    %215 = llhd.xor %213, %214 : i1
    %216 = llhd.extract_slice %212, 2 : i15 -> i1
    %217 = llhd.xor %215, %216 : i1
    %218 = llhd.extract_slice %212, 3 : i15 -> i1
    %219 = llhd.xor %217, %218 : i1
    %220 = llhd.extract_slice %212, 4 : i15 -> i1
    %221 = llhd.xor %219, %220 : i1
    %222 = llhd.extract_slice %212, 5 : i15 -> i1
    %223 = llhd.xor %221, %222 : i1
    %224 = llhd.extract_slice %212, 6 : i15 -> i1
    %225 = llhd.xor %223, %224 : i1
    %226 = llhd.extract_slice %212, 7 : i15 -> i1
    %227 = llhd.xor %225, %226 : i1
    %228 = llhd.extract_slice %212, 8 : i15 -> i1
    %229 = llhd.xor %227, %228 : i1
    %230 = llhd.extract_slice %212, 9 : i15 -> i1
    %231 = llhd.xor %229, %230 : i1
    %232 = llhd.extract_slice %212, 10 : i15 -> i1
    %233 = llhd.xor %231, %232 : i1
    %234 = llhd.extract_slice %212, 11 : i15 -> i1
    %235 = llhd.xor %233, %234 : i1
    %236 = llhd.extract_slice %212, 12 : i15 -> i1
    %237 = llhd.xor %235, %236 : i1
    %238 = llhd.extract_slice %212, 13 : i15 -> i1
    %239 = llhd.xor %237, %238 : i1
    %240 = llhd.extract_slice %212, 14 : i15 -> i1
    %241 = llhd.xor %239, %240 : i1
    llhd.drv %209, %241 after %40 : !llhd.sig<i1>
    %242 = llhd.const 6 : i32
    %243 = llhd.sig "243" %42 : i20
    %244 = llhd.shr %Z, %243, %242 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %245 = llhd.extract_slice %244, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %246 = llhd.extract_slice %A.prb, 6 : i20 -> i14
    %247 = llhd.insert_slice %42, %246, 0 : i20, i14
    %248 = llhd.extract_slice %247, 0 : i20 -> i14
    %249 = llhd.extract_slice %248, 0 : i14 -> i1
    %250 = llhd.extract_slice %248, 1 : i14 -> i1
    %251 = llhd.xor %249, %250 : i1
    %252 = llhd.extract_slice %248, 2 : i14 -> i1
    %253 = llhd.xor %251, %252 : i1
    %254 = llhd.extract_slice %248, 3 : i14 -> i1
    %255 = llhd.xor %253, %254 : i1
    %256 = llhd.extract_slice %248, 4 : i14 -> i1
    %257 = llhd.xor %255, %256 : i1
    %258 = llhd.extract_slice %248, 5 : i14 -> i1
    %259 = llhd.xor %257, %258 : i1
    %260 = llhd.extract_slice %248, 6 : i14 -> i1
    %261 = llhd.xor %259, %260 : i1
    %262 = llhd.extract_slice %248, 7 : i14 -> i1
    %263 = llhd.xor %261, %262 : i1
    %264 = llhd.extract_slice %248, 8 : i14 -> i1
    %265 = llhd.xor %263, %264 : i1
    %266 = llhd.extract_slice %248, 9 : i14 -> i1
    %267 = llhd.xor %265, %266 : i1
    %268 = llhd.extract_slice %248, 10 : i14 -> i1
    %269 = llhd.xor %267, %268 : i1
    %270 = llhd.extract_slice %248, 11 : i14 -> i1
    %271 = llhd.xor %269, %270 : i1
    %272 = llhd.extract_slice %248, 12 : i14 -> i1
    %273 = llhd.xor %271, %272 : i1
    %274 = llhd.extract_slice %248, 13 : i14 -> i1
    %275 = llhd.xor %273, %274 : i1
    llhd.drv %245, %275 after %40 : !llhd.sig<i1>
    %276 = llhd.const 7 : i32
    %277 = llhd.sig "277" %42 : i20
    %278 = llhd.shr %Z, %277, %276 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %279 = llhd.extract_slice %278, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %280 = llhd.extract_slice %A.prb, 7 : i20 -> i13
    %281 = llhd.insert_slice %42, %280, 0 : i20, i13
    %282 = llhd.extract_slice %281, 0 : i20 -> i13
    %283 = llhd.extract_slice %282, 0 : i13 -> i1
    %284 = llhd.extract_slice %282, 1 : i13 -> i1
    %285 = llhd.xor %283, %284 : i1
    %286 = llhd.extract_slice %282, 2 : i13 -> i1
    %287 = llhd.xor %285, %286 : i1
    %288 = llhd.extract_slice %282, 3 : i13 -> i1
    %289 = llhd.xor %287, %288 : i1
    %290 = llhd.extract_slice %282, 4 : i13 -> i1
    %291 = llhd.xor %289, %290 : i1
    %292 = llhd.extract_slice %282, 5 : i13 -> i1
    %293 = llhd.xor %291, %292 : i1
    %294 = llhd.extract_slice %282, 6 : i13 -> i1
    %295 = llhd.xor %293, %294 : i1
    %296 = llhd.extract_slice %282, 7 : i13 -> i1
    %297 = llhd.xor %295, %296 : i1
    %298 = llhd.extract_slice %282, 8 : i13 -> i1
    %299 = llhd.xor %297, %298 : i1
    %300 = llhd.extract_slice %282, 9 : i13 -> i1
    %301 = llhd.xor %299, %300 : i1
    %302 = llhd.extract_slice %282, 10 : i13 -> i1
    %303 = llhd.xor %301, %302 : i1
    %304 = llhd.extract_slice %282, 11 : i13 -> i1
    %305 = llhd.xor %303, %304 : i1
    %306 = llhd.extract_slice %282, 12 : i13 -> i1
    %307 = llhd.xor %305, %306 : i1
    llhd.drv %279, %307 after %40 : !llhd.sig<i1>
    %308 = llhd.const 8 : i32
    %309 = llhd.sig "309" %42 : i20
    %310 = llhd.shr %Z, %309, %308 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %311 = llhd.extract_slice %310, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %312 = llhd.extract_slice %A.prb, 8 : i20 -> i12
    %313 = llhd.insert_slice %42, %312, 0 : i20, i12
    %314 = llhd.extract_slice %313, 0 : i20 -> i12
    %315 = llhd.extract_slice %314, 0 : i12 -> i1
    %316 = llhd.extract_slice %314, 1 : i12 -> i1
    %317 = llhd.xor %315, %316 : i1
    %318 = llhd.extract_slice %314, 2 : i12 -> i1
    %319 = llhd.xor %317, %318 : i1
    %320 = llhd.extract_slice %314, 3 : i12 -> i1
    %321 = llhd.xor %319, %320 : i1
    %322 = llhd.extract_slice %314, 4 : i12 -> i1
    %323 = llhd.xor %321, %322 : i1
    %324 = llhd.extract_slice %314, 5 : i12 -> i1
    %325 = llhd.xor %323, %324 : i1
    %326 = llhd.extract_slice %314, 6 : i12 -> i1
    %327 = llhd.xor %325, %326 : i1
    %328 = llhd.extract_slice %314, 7 : i12 -> i1
    %329 = llhd.xor %327, %328 : i1
    %330 = llhd.extract_slice %314, 8 : i12 -> i1
    %331 = llhd.xor %329, %330 : i1
    %332 = llhd.extract_slice %314, 9 : i12 -> i1
    %333 = llhd.xor %331, %332 : i1
    %334 = llhd.extract_slice %314, 10 : i12 -> i1
    %335 = llhd.xor %333, %334 : i1
    %336 = llhd.extract_slice %314, 11 : i12 -> i1
    %337 = llhd.xor %335, %336 : i1
    llhd.drv %311, %337 after %40 : !llhd.sig<i1>
    %338 = llhd.const 9 : i32
    %339 = llhd.sig "339" %42 : i20
    %340 = llhd.shr %Z, %339, %338 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %341 = llhd.extract_slice %340, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %342 = llhd.extract_slice %A.prb, 9 : i20 -> i11
    %343 = llhd.insert_slice %42, %342, 0 : i20, i11
    %344 = llhd.extract_slice %343, 0 : i20 -> i11
    %345 = llhd.extract_slice %344, 0 : i11 -> i1
    %346 = llhd.extract_slice %344, 1 : i11 -> i1
    %347 = llhd.xor %345, %346 : i1
    %348 = llhd.extract_slice %344, 2 : i11 -> i1
    %349 = llhd.xor %347, %348 : i1
    %350 = llhd.extract_slice %344, 3 : i11 -> i1
    %351 = llhd.xor %349, %350 : i1
    %352 = llhd.extract_slice %344, 4 : i11 -> i1
    %353 = llhd.xor %351, %352 : i1
    %354 = llhd.extract_slice %344, 5 : i11 -> i1
    %355 = llhd.xor %353, %354 : i1
    %356 = llhd.extract_slice %344, 6 : i11 -> i1
    %357 = llhd.xor %355, %356 : i1
    %358 = llhd.extract_slice %344, 7 : i11 -> i1
    %359 = llhd.xor %357, %358 : i1
    %360 = llhd.extract_slice %344, 8 : i11 -> i1
    %361 = llhd.xor %359, %360 : i1
    %362 = llhd.extract_slice %344, 9 : i11 -> i1
    %363 = llhd.xor %361, %362 : i1
    %364 = llhd.extract_slice %344, 10 : i11 -> i1
    %365 = llhd.xor %363, %364 : i1
    llhd.drv %341, %365 after %40 : !llhd.sig<i1>
    %366 = llhd.const 10 : i32
    %367 = llhd.sig "367" %42 : i20
    %368 = llhd.shr %Z, %367, %366 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %369 = llhd.extract_slice %368, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %370 = llhd.extract_slice %A.prb, 10 : i20 -> i10
    %371 = llhd.insert_slice %42, %370, 0 : i20, i10
    %372 = llhd.extract_slice %371, 0 : i20 -> i10
    %373 = llhd.extract_slice %372, 0 : i10 -> i1
    %374 = llhd.extract_slice %372, 1 : i10 -> i1
    %375 = llhd.xor %373, %374 : i1
    %376 = llhd.extract_slice %372, 2 : i10 -> i1
    %377 = llhd.xor %375, %376 : i1
    %378 = llhd.extract_slice %372, 3 : i10 -> i1
    %379 = llhd.xor %377, %378 : i1
    %380 = llhd.extract_slice %372, 4 : i10 -> i1
    %381 = llhd.xor %379, %380 : i1
    %382 = llhd.extract_slice %372, 5 : i10 -> i1
    %383 = llhd.xor %381, %382 : i1
    %384 = llhd.extract_slice %372, 6 : i10 -> i1
    %385 = llhd.xor %383, %384 : i1
    %386 = llhd.extract_slice %372, 7 : i10 -> i1
    %387 = llhd.xor %385, %386 : i1
    %388 = llhd.extract_slice %372, 8 : i10 -> i1
    %389 = llhd.xor %387, %388 : i1
    %390 = llhd.extract_slice %372, 9 : i10 -> i1
    %391 = llhd.xor %389, %390 : i1
    llhd.drv %369, %391 after %40 : !llhd.sig<i1>
    %392 = llhd.const 11 : i32
    %393 = llhd.sig "393" %42 : i20
    %394 = llhd.shr %Z, %393, %392 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %395 = llhd.extract_slice %394, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %396 = llhd.extract_slice %A.prb, 11 : i20 -> i9
    %397 = llhd.insert_slice %42, %396, 0 : i20, i9
    %398 = llhd.extract_slice %397, 0 : i20 -> i9
    %399 = llhd.extract_slice %398, 0 : i9 -> i1
    %400 = llhd.extract_slice %398, 1 : i9 -> i1
    %401 = llhd.xor %399, %400 : i1
    %402 = llhd.extract_slice %398, 2 : i9 -> i1
    %403 = llhd.xor %401, %402 : i1
    %404 = llhd.extract_slice %398, 3 : i9 -> i1
    %405 = llhd.xor %403, %404 : i1
    %406 = llhd.extract_slice %398, 4 : i9 -> i1
    %407 = llhd.xor %405, %406 : i1
    %408 = llhd.extract_slice %398, 5 : i9 -> i1
    %409 = llhd.xor %407, %408 : i1
    %410 = llhd.extract_slice %398, 6 : i9 -> i1
    %411 = llhd.xor %409, %410 : i1
    %412 = llhd.extract_slice %398, 7 : i9 -> i1
    %413 = llhd.xor %411, %412 : i1
    %414 = llhd.extract_slice %398, 8 : i9 -> i1
    %415 = llhd.xor %413, %414 : i1
    llhd.drv %395, %415 after %40 : !llhd.sig<i1>
    %416 = llhd.const 12 : i32
    %417 = llhd.sig "417" %42 : i20
    %418 = llhd.shr %Z, %417, %416 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %419 = llhd.extract_slice %418, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %420 = llhd.extract_slice %A.prb, 12 : i20 -> i8
    %421 = llhd.insert_slice %42, %420, 0 : i20, i8
    %422 = llhd.extract_slice %421, 0 : i20 -> i8
    %423 = llhd.extract_slice %422, 0 : i8 -> i1
    %424 = llhd.extract_slice %422, 1 : i8 -> i1
    %425 = llhd.xor %423, %424 : i1
    %426 = llhd.extract_slice %422, 2 : i8 -> i1
    %427 = llhd.xor %425, %426 : i1
    %428 = llhd.extract_slice %422, 3 : i8 -> i1
    %429 = llhd.xor %427, %428 : i1
    %430 = llhd.extract_slice %422, 4 : i8 -> i1
    %431 = llhd.xor %429, %430 : i1
    %432 = llhd.extract_slice %422, 5 : i8 -> i1
    %433 = llhd.xor %431, %432 : i1
    %434 = llhd.extract_slice %422, 6 : i8 -> i1
    %435 = llhd.xor %433, %434 : i1
    %436 = llhd.extract_slice %422, 7 : i8 -> i1
    %437 = llhd.xor %435, %436 : i1
    llhd.drv %419, %437 after %40 : !llhd.sig<i1>
    %438 = llhd.const 13 : i32
    %439 = llhd.sig "439" %42 : i20
    %440 = llhd.shr %Z, %439, %438 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %441 = llhd.extract_slice %440, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %442 = llhd.extract_slice %A.prb, 13 : i20 -> i7
    %443 = llhd.insert_slice %42, %442, 0 : i20, i7
    %444 = llhd.extract_slice %443, 0 : i20 -> i7
    %445 = llhd.extract_slice %444, 0 : i7 -> i1
    %446 = llhd.extract_slice %444, 1 : i7 -> i1
    %447 = llhd.xor %445, %446 : i1
    %448 = llhd.extract_slice %444, 2 : i7 -> i1
    %449 = llhd.xor %447, %448 : i1
    %450 = llhd.extract_slice %444, 3 : i7 -> i1
    %451 = llhd.xor %449, %450 : i1
    %452 = llhd.extract_slice %444, 4 : i7 -> i1
    %453 = llhd.xor %451, %452 : i1
    %454 = llhd.extract_slice %444, 5 : i7 -> i1
    %455 = llhd.xor %453, %454 : i1
    %456 = llhd.extract_slice %444, 6 : i7 -> i1
    %457 = llhd.xor %455, %456 : i1
    llhd.drv %441, %457 after %40 : !llhd.sig<i1>
    %458 = llhd.const 14 : i32
    %459 = llhd.sig "459" %42 : i20
    %460 = llhd.shr %Z, %459, %458 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %461 = llhd.extract_slice %460, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %462 = llhd.extract_slice %A.prb, 14 : i20 -> i6
    %463 = llhd.insert_slice %42, %462, 0 : i20, i6
    %464 = llhd.extract_slice %463, 0 : i20 -> i6
    %465 = llhd.extract_slice %464, 0 : i6 -> i1
    %466 = llhd.extract_slice %464, 1 : i6 -> i1
    %467 = llhd.xor %465, %466 : i1
    %468 = llhd.extract_slice %464, 2 : i6 -> i1
    %469 = llhd.xor %467, %468 : i1
    %470 = llhd.extract_slice %464, 3 : i6 -> i1
    %471 = llhd.xor %469, %470 : i1
    %472 = llhd.extract_slice %464, 4 : i6 -> i1
    %473 = llhd.xor %471, %472 : i1
    %474 = llhd.extract_slice %464, 5 : i6 -> i1
    %475 = llhd.xor %473, %474 : i1
    llhd.drv %461, %475 after %40 : !llhd.sig<i1>
    %476 = llhd.const 15 : i32
    %477 = llhd.sig "477" %42 : i20
    %478 = llhd.shr %Z, %477, %476 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %479 = llhd.extract_slice %478, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %480 = llhd.extract_slice %A.prb, 15 : i20 -> i5
    %481 = llhd.insert_slice %42, %480, 0 : i20, i5
    %482 = llhd.extract_slice %481, 0 : i20 -> i5
    %483 = llhd.extract_slice %482, 0 : i5 -> i1
    %484 = llhd.extract_slice %482, 1 : i5 -> i1
    %485 = llhd.xor %483, %484 : i1
    %486 = llhd.extract_slice %482, 2 : i5 -> i1
    %487 = llhd.xor %485, %486 : i1
    %488 = llhd.extract_slice %482, 3 : i5 -> i1
    %489 = llhd.xor %487, %488 : i1
    %490 = llhd.extract_slice %482, 4 : i5 -> i1
    %491 = llhd.xor %489, %490 : i1
    llhd.drv %479, %491 after %40 : !llhd.sig<i1>
    %492 = llhd.const 16 : i32
    %493 = llhd.sig "493" %42 : i20
    %494 = llhd.shr %Z, %493, %492 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %495 = llhd.extract_slice %494, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %496 = llhd.extract_slice %A.prb, 16 : i20 -> i4
    %497 = llhd.insert_slice %42, %496, 0 : i20, i4
    %498 = llhd.extract_slice %497, 0 : i20 -> i4
    %499 = llhd.extract_slice %498, 0 : i4 -> i1
    %500 = llhd.extract_slice %498, 1 : i4 -> i1
    %501 = llhd.xor %499, %500 : i1
    %502 = llhd.extract_slice %498, 2 : i4 -> i1
    %503 = llhd.xor %501, %502 : i1
    %504 = llhd.extract_slice %498, 3 : i4 -> i1
    %505 = llhd.xor %503, %504 : i1
    llhd.drv %495, %505 after %40 : !llhd.sig<i1>
    %506 = llhd.const 17 : i32
    %507 = llhd.sig "507" %42 : i20
    %508 = llhd.shr %Z, %507, %506 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %509 = llhd.extract_slice %508, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %510 = llhd.extract_slice %A.prb, 17 : i20 -> i3
    %511 = llhd.insert_slice %42, %510, 0 : i20, i3
    %512 = llhd.extract_slice %511, 0 : i20 -> i3
    %513 = llhd.extract_slice %512, 0 : i3 -> i1
    %514 = llhd.extract_slice %512, 1 : i3 -> i1
    %515 = llhd.xor %513, %514 : i1
    %516 = llhd.extract_slice %512, 2 : i3 -> i1
    %517 = llhd.xor %515, %516 : i1
    llhd.drv %509, %517 after %40 : !llhd.sig<i1>
    %518 = llhd.const 18 : i32
    %519 = llhd.sig "519" %42 : i20
    %520 = llhd.shr %Z, %519, %518 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %521 = llhd.extract_slice %520, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %522 = llhd.extract_slice %A.prb, 18 : i20 -> i2
    %523 = llhd.insert_slice %42, %522, 0 : i20, i2
    %524 = llhd.extract_slice %523, 0 : i20 -> i2
    %525 = llhd.extract_slice %524, 0 : i2 -> i1
    %526 = llhd.extract_slice %524, 1 : i2 -> i1
    %527 = llhd.xor %525, %526 : i1
    llhd.drv %521, %527 after %40 : !llhd.sig<i1>
    %528 = llhd.const 19 : i32
    %529 = llhd.sig "529" %42 : i20
    %530 = llhd.shr %Z, %529, %528 : (!llhd.sig<i20>, !llhd.sig<i20>, i32) -> !llhd.sig<i20>
    %531 = llhd.extract_slice %530, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
    %532 = llhd.insert_slice %42, %38, 0 : i20, i1
    %533 = llhd.extract_slice %532, 0 : i20 -> i1
    llhd.drv %531, %533 after %40 : !llhd.sig<i1>
    // %534 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %Z, %42 after %534 : !llhd.sig<i20>
}

llhd.entity @graycode.param1(%A: !llhd.sig<i20>) -> (%G: !llhd.sig<i20> , %Z: !llhd.sig<i20> ) {
    %A.prb = llhd.prb %A : !llhd.sig<i20>
    %0 = llhd.const 0 : i20
    %1 = llhd.sig "1" %0 : i20
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1, %A.prb after %2 : !llhd.sig<i20>
    llhd.inst "inst" @binary_to_gray.param3(%1) -> (%G) : (!llhd.sig<i20>) -> (!llhd.sig<i20>)
    %G.prb = llhd.prb %G : !llhd.sig<i20>
    %3 = llhd.sig "3" %0 : i20
    llhd.drv %3, %G.prb after %2 : !llhd.sig<i20>
    llhd.inst "inst1" @gray_to_binary.param5(%3) -> (%Z) : (!llhd.sig<i20>) -> (!llhd.sig<i20>)
}

llhd.proc @graycode_tb.initial.509.0(%b: !llhd.sig<i20>) -> (%a: !llhd.sig<i20> , %bp: !llhd.sig<i20> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i20
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %bp, %1 after %2 : !llhd.sig<i20>
    %3 = llhd.const 2 : i32
    br ^loop_body(%3 : i32)
^loop_body(%4: i32):
    %5 = llhd.const 0 : i32
    %6 = llhd.neq %4, %5 : i32
    %7 = llhd.const 0 : i21
    cond_br %6, ^loop_continue, ^loop_exit1
^loop_exit:
    br ^loop_body(%4 : i32)
^loop_exit1:
    br ^loop_body1(%7 : i21)
^loop_continue:
    br ^loop_body2(%7 : i21)
^loop_body1(%8: i21):
    %9 = llhd.const 0 : i32
    %zext1 = llhd.insert_slice %9, %8, 0 : i32, i21
    %10 = llhd.const 1048576 : i32
    %11 = cmpi "ult", %zext1, %10 : i32
    cond_br %11, ^loop_continue2, ^loop_exit2
^loop_body2(%i.ld: i21):
    %12 = llhd.const 0 : i32
    %zext = llhd.insert_slice %12, %i.ld, 0 : i32, i21
    %13 = llhd.const 1048576 : i32
    %14 = cmpi "ult", %zext, %13 : i32
    cond_br %14, ^loop_continue1, ^loop_exit
^15:
    %b.prb = llhd.prb %b : !llhd.sig<i20>
    llhd.drv %bp, %b.prb after %16 : !llhd.sig<i20>
    %17 = llhd.const 1 : i21
    %18 = addi %i.ld, %17 : i21
    br ^loop_body2(%18 : i21)
^loop_continue1:
    %19 = llhd.extract_slice %i.ld, 0 : i21 -> i20
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %a, %19 after %16 : !llhd.sig<i20>
    %20 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %20, ^15
^21:
    %b.prb1 = llhd.prb %b : !llhd.sig<i20>
    llhd.drv %bp, %b.prb1 after %22 : !llhd.sig<i20>
    %23 = llhd.const 1 : i21
    %24 = addi %8, %23 : i21
    br ^loop_body1(%24 : i21)
^loop_exit2:
    llhd.halt
^loop_continue2:
    %25 = subi %10, %zext1 : i32
    %26 = llhd.const 1 : i32
    %27 = subi %25, %26 : i32
    %28 = llhd.extract_slice %27, 0 : i32 -> i20
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %a, %28 after %22 : !llhd.sig<i20>
    %29 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %29, ^21
}

llhd.entity @graycode_tb() -> () {
    %0 = llhd.const 0 : i20
    %a = llhd.sig "a" %0 : i20
    %b = llhd.sig "b" %0 : i20
    %c = llhd.sig "c" %0 : i20
    %bp = llhd.sig "bp" %0 : i20
    %a.prb = llhd.prb %a : !llhd.sig<i20>
    %1 = llhd.sig "1" %0 : i20
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1, %a.prb after %2 : !llhd.sig<i20>
    llhd.inst "inst" @graycode.param1(%1) -> (%b, %c) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
    llhd.inst "inst1" @graycode_tb.initial.509.0(%b) -> (%a, %bp) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
}
