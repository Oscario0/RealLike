// Lean compiler output
// Module: RealLike.Specialize
// Imports: public import Init public import RealLike.Lowering
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* l_Lean_Expr_const___override(lean_object*, lean_object*);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
lean_object* l_Lean_mkAppN(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RealLike_RealLike_specializeToFloat(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__4;
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__9;
lean_object* lean_array_push(lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__2;
lean_object* lp_RealLike_RealLike_floatName(lean_object*);
lean_object* l_Lean_compileDecl(lean_object*, uint8_t, lean_object*, lean_object*);
lean_object* l_Lean_Environment_find_x3f(lean_object*, lean_object*, uint8_t);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__0;
lean_object* l_Lean_stringToMessageData(lean_object*);
lean_object* lp_RealLike_RealLike_genericName(lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__10;
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__14;
lean_object* lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(lean_object*, lean_object*);
lean_object* lean_st_ref_get(lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__6;
lean_object* l_Lean_Meta_synthInstance(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__7;
lean_object* lp_mathlib_Lean_throwError___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__1___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__8;
lean_object* l_Lean_Expr_app___override(lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__5;
lean_object* lp_mathlib_List_mapTR_loop___at___00Mathlib_Deriving_Fintype_mkFintypeEnum_spec__0(lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__11;
LEAN_EXPORT lean_object* lp_RealLike_RealLike_specializeToFloat___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__1;
lean_object* l_Lean_Name_mkStr1(lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__3;
lean_object* lean_infer_type(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__13;
static lean_object* lp_RealLike_RealLike_specializeToFloat___closed__12;
lean_object* l_Lean_MessageData_ofName(lean_object*);
lean_object* l_Lean_addDecl(lean_object*, uint8_t, lean_object*, lean_object*);
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__0() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Float", 5, 5);
return x_1;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__0;
x_2 = l_Lean_Name_mkStr1(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lean_box(0);
x_2 = lp_RealLike_RealLike_specializeToFloat___closed__1;
x_3 = l_Lean_Expr_const___override(x_2, x_1);
return x_3;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("RealLike", 8, 8);
return x_1;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__3;
x_2 = l_Lean_Name_mkStr1(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__5() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lean_box(0);
x_2 = lp_RealLike_RealLike_specializeToFloat___closed__4;
x_3 = l_Lean_Expr_const___override(x_2, x_1);
return x_3;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__6() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__2;
x_2 = lp_RealLike_RealLike_specializeToFloat___closed__5;
x_3 = l_Lean_Expr_app___override(x_2, x_1);
return x_3;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__7() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(2u);
x_2 = lean_mk_empty_array_with_capacity(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__8() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__2;
x_2 = lp_RealLike_RealLike_specializeToFloat___closed__7;
x_3 = lean_array_push(x_2, x_1);
return x_3;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__9() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("specializeToFloat: generic '", 28, 28);
return x_1;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__10() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__9;
x_2 = l_Lean_stringToMessageData(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__11() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("' not found; run realToGeneric first", 36, 36);
return x_1;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__12() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__11;
x_2 = l_Lean_stringToMessageData(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__13() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("' must be a definition", 22, 22);
return x_1;
}
}
static lean_object* _init_lp_RealLike_RealLike_specializeToFloat___closed__14() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lp_RealLike_RealLike_specializeToFloat___closed__13;
x_2 = l_Lean_stringToMessageData(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* lp_RealLike_RealLike_specializeToFloat(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; uint8_t x_10; lean_object* x_11; 
x_7 = lean_st_ref_get(x_5);
x_8 = lean_ctor_get(x_7, 0);
lean_inc_ref(x_8);
lean_dec(x_7);
lean_inc(x_1);
x_9 = lp_RealLike_RealLike_floatName(x_1);
x_10 = 0;
lean_inc(x_9);
x_11 = l_Lean_Environment_find_x3f(x_8, x_9, x_10);
if (lean_obj_tag(x_11) == 0)
{
lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_153; 
x_12 = lean_st_ref_get(x_5);
x_13 = lean_ctor_get(x_12, 0);
lean_inc_ref(x_13);
lean_dec(x_12);
x_14 = lp_RealLike_RealLike_genericName(x_1);
lean_inc(x_14);
x_153 = l_Lean_Environment_find_x3f(x_13, x_14, x_10);
if (lean_obj_tag(x_153) == 0)
{
lean_object* x_154; lean_object* x_155; lean_object* x_156; lean_object* x_157; lean_object* x_158; lean_object* x_159; uint8_t x_160; 
lean_dec(x_9);
x_154 = lp_RealLike_RealLike_specializeToFloat___closed__10;
x_155 = l_Lean_MessageData_ofName(x_14);
x_156 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_156, 0, x_154);
lean_ctor_set(x_156, 1, x_155);
x_157 = lp_RealLike_RealLike_specializeToFloat___closed__12;
x_158 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_158, 0, x_156);
lean_ctor_set(x_158, 1, x_157);
x_159 = lp_mathlib_Lean_throwError___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__1___redArg(x_158, x_2, x_3, x_4, x_5);
lean_dec(x_5);
lean_dec_ref(x_4);
lean_dec(x_3);
lean_dec_ref(x_2);
x_160 = !lean_is_exclusive(x_159);
if (x_160 == 0)
{
return x_159;
}
else
{
lean_object* x_161; lean_object* x_162; 
x_161 = lean_ctor_get(x_159, 0);
lean_inc(x_161);
lean_dec(x_159);
x_162 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_162, 0, x_161);
return x_162;
}
}
else
{
lean_object* x_163; 
x_163 = lean_ctor_get(x_153, 0);
lean_inc(x_163);
lean_dec_ref(x_153);
if (lean_obj_tag(x_163) == 1)
{
lean_object* x_164; 
x_164 = lean_ctor_get(x_163, 0);
lean_inc_ref(x_164);
lean_dec_ref(x_163);
x_15 = x_164;
x_16 = x_2;
x_17 = x_3;
x_18 = x_4;
x_19 = x_5;
x_20 = lean_box(0);
goto block_152;
}
else
{
lean_object* x_165; lean_object* x_166; lean_object* x_167; lean_object* x_168; lean_object* x_169; lean_object* x_170; uint8_t x_171; 
lean_dec(x_163);
lean_dec(x_9);
x_165 = lp_RealLike_RealLike_specializeToFloat___closed__10;
x_166 = l_Lean_MessageData_ofName(x_14);
x_167 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_167, 0, x_165);
lean_ctor_set(x_167, 1, x_166);
x_168 = lp_RealLike_RealLike_specializeToFloat___closed__14;
x_169 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_169, 0, x_167);
lean_ctor_set(x_169, 1, x_168);
x_170 = lp_mathlib_Lean_throwError___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__1___redArg(x_169, x_2, x_3, x_4, x_5);
lean_dec(x_5);
lean_dec_ref(x_4);
lean_dec(x_3);
lean_dec_ref(x_2);
x_171 = !lean_is_exclusive(x_170);
if (x_171 == 0)
{
return x_170;
}
else
{
lean_object* x_172; lean_object* x_173; 
x_172 = lean_ctor_get(x_170, 0);
lean_inc(x_172);
lean_dec(x_170);
x_173 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_173, 0, x_172);
return x_173;
}
}
}
block_152:
{
lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; 
x_21 = lean_box(0);
x_22 = lp_RealLike_RealLike_specializeToFloat___closed__6;
x_23 = lean_box(0);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc(x_17);
lean_inc_ref(x_16);
x_24 = l_Lean_Meta_synthInstance(x_22, x_23, x_16, x_17, x_18, x_19);
if (lean_obj_tag(x_24) == 0)
{
uint8_t x_25; 
x_25 = !lean_is_exclusive(x_15);
if (x_25 == 0)
{
lean_object* x_26; lean_object* x_27; lean_object* x_28; lean_object* x_29; lean_object* x_30; uint8_t x_31; 
x_26 = lean_ctor_get(x_15, 0);
x_27 = lean_ctor_get(x_15, 3);
lean_dec(x_27);
x_28 = lean_ctor_get(x_15, 2);
lean_dec(x_28);
x_29 = lean_ctor_get(x_15, 1);
lean_dec(x_29);
x_30 = lean_ctor_get(x_24, 0);
lean_inc(x_30);
lean_dec_ref(x_24);
x_31 = !lean_is_exclusive(x_26);
if (x_31 == 0)
{
lean_object* x_32; lean_object* x_33; lean_object* x_34; lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; lean_object* x_39; lean_object* x_40; lean_object* x_41; lean_object* x_42; 
x_32 = lean_ctor_get(x_26, 1);
x_33 = lean_ctor_get(x_26, 2);
lean_dec(x_33);
x_34 = lean_ctor_get(x_26, 0);
lean_dec(x_34);
x_35 = lp_mathlib_List_mapTR_loop___at___00Mathlib_Deriving_Fintype_mkFintypeEnum_spec__0(x_32, x_21);
x_36 = l_Lean_Expr_const___override(x_14, x_35);
x_37 = lp_RealLike_RealLike_specializeToFloat___closed__8;
x_38 = lean_array_push(x_37, x_30);
x_39 = l_Lean_mkAppN(x_36, x_38);
lean_dec_ref(x_38);
x_40 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_39, x_17);
x_41 = lean_ctor_get(x_40, 0);
lean_inc(x_41);
lean_dec_ref(x_40);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc(x_17);
lean_inc(x_41);
x_42 = lean_infer_type(x_41, x_16, x_17, x_18, x_19);
if (lean_obj_tag(x_42) == 0)
{
lean_object* x_43; lean_object* x_44; uint8_t x_45; 
x_43 = lean_ctor_get(x_42, 0);
lean_inc(x_43);
lean_dec_ref(x_42);
x_44 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_43, x_17);
lean_dec(x_17);
x_45 = !lean_is_exclusive(x_44);
if (x_45 == 0)
{
lean_object* x_46; lean_object* x_47; uint8_t x_48; lean_object* x_49; lean_object* x_50; 
x_46 = lean_ctor_get(x_44, 0);
lean_inc(x_9);
lean_ctor_set(x_26, 2, x_46);
lean_ctor_set(x_26, 1, x_21);
lean_ctor_set(x_26, 0, x_9);
x_47 = lean_box(1);
x_48 = 1;
lean_inc(x_9);
x_49 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_49, 0, x_9);
lean_ctor_set(x_49, 1, x_21);
lean_ctor_set(x_15, 3, x_49);
lean_ctor_set(x_15, 2, x_47);
lean_ctor_set(x_15, 1, x_41);
lean_ctor_set_uint8(x_15, sizeof(void*)*4, x_48);
lean_ctor_set_tag(x_44, 1);
lean_ctor_set(x_44, 0, x_15);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc_ref(x_44);
x_50 = l_Lean_addDecl(x_44, x_10, x_18, x_19);
if (lean_obj_tag(x_50) == 0)
{
uint8_t x_51; lean_object* x_52; 
lean_dec_ref(x_50);
x_51 = 1;
x_52 = l_Lean_compileDecl(x_44, x_51, x_18, x_19);
if (lean_obj_tag(x_52) == 0)
{
uint8_t x_53; 
x_53 = !lean_is_exclusive(x_52);
if (x_53 == 0)
{
lean_object* x_54; 
x_54 = lean_ctor_get(x_52, 0);
lean_dec(x_54);
lean_ctor_set(x_52, 0, x_9);
return x_52;
}
else
{
lean_object* x_55; 
lean_dec(x_52);
x_55 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_55, 0, x_9);
return x_55;
}
}
else
{
uint8_t x_56; 
lean_dec(x_9);
x_56 = !lean_is_exclusive(x_52);
if (x_56 == 0)
{
return x_52;
}
else
{
lean_object* x_57; lean_object* x_58; 
x_57 = lean_ctor_get(x_52, 0);
lean_inc(x_57);
lean_dec(x_52);
x_58 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_58, 0, x_57);
return x_58;
}
}
}
else
{
uint8_t x_59; 
lean_dec_ref(x_44);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_9);
x_59 = !lean_is_exclusive(x_50);
if (x_59 == 0)
{
return x_50;
}
else
{
lean_object* x_60; lean_object* x_61; 
x_60 = lean_ctor_get(x_50, 0);
lean_inc(x_60);
lean_dec(x_50);
x_61 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_61, 0, x_60);
return x_61;
}
}
}
else
{
lean_object* x_62; lean_object* x_63; uint8_t x_64; lean_object* x_65; lean_object* x_66; lean_object* x_67; 
x_62 = lean_ctor_get(x_44, 0);
lean_inc(x_62);
lean_dec(x_44);
lean_inc(x_9);
lean_ctor_set(x_26, 2, x_62);
lean_ctor_set(x_26, 1, x_21);
lean_ctor_set(x_26, 0, x_9);
x_63 = lean_box(1);
x_64 = 1;
lean_inc(x_9);
x_65 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_65, 0, x_9);
lean_ctor_set(x_65, 1, x_21);
lean_ctor_set(x_15, 3, x_65);
lean_ctor_set(x_15, 2, x_63);
lean_ctor_set(x_15, 1, x_41);
lean_ctor_set_uint8(x_15, sizeof(void*)*4, x_64);
x_66 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_66, 0, x_15);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc_ref(x_66);
x_67 = l_Lean_addDecl(x_66, x_10, x_18, x_19);
if (lean_obj_tag(x_67) == 0)
{
uint8_t x_68; lean_object* x_69; 
lean_dec_ref(x_67);
x_68 = 1;
x_69 = l_Lean_compileDecl(x_66, x_68, x_18, x_19);
if (lean_obj_tag(x_69) == 0)
{
lean_object* x_70; lean_object* x_71; 
if (lean_is_exclusive(x_69)) {
 lean_ctor_release(x_69, 0);
 x_70 = x_69;
} else {
 lean_dec_ref(x_69);
 x_70 = lean_box(0);
}
if (lean_is_scalar(x_70)) {
 x_71 = lean_alloc_ctor(0, 1, 0);
} else {
 x_71 = x_70;
}
lean_ctor_set(x_71, 0, x_9);
return x_71;
}
else
{
lean_object* x_72; lean_object* x_73; lean_object* x_74; 
lean_dec(x_9);
x_72 = lean_ctor_get(x_69, 0);
lean_inc(x_72);
if (lean_is_exclusive(x_69)) {
 lean_ctor_release(x_69, 0);
 x_73 = x_69;
} else {
 lean_dec_ref(x_69);
 x_73 = lean_box(0);
}
if (lean_is_scalar(x_73)) {
 x_74 = lean_alloc_ctor(1, 1, 0);
} else {
 x_74 = x_73;
}
lean_ctor_set(x_74, 0, x_72);
return x_74;
}
}
else
{
lean_object* x_75; lean_object* x_76; lean_object* x_77; 
lean_dec_ref(x_66);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_9);
x_75 = lean_ctor_get(x_67, 0);
lean_inc(x_75);
if (lean_is_exclusive(x_67)) {
 lean_ctor_release(x_67, 0);
 x_76 = x_67;
} else {
 lean_dec_ref(x_67);
 x_76 = lean_box(0);
}
if (lean_is_scalar(x_76)) {
 x_77 = lean_alloc_ctor(1, 1, 0);
} else {
 x_77 = x_76;
}
lean_ctor_set(x_77, 0, x_75);
return x_77;
}
}
}
else
{
uint8_t x_78; 
lean_dec(x_41);
lean_free_object(x_26);
lean_free_object(x_15);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_17);
lean_dec(x_9);
x_78 = !lean_is_exclusive(x_42);
if (x_78 == 0)
{
return x_42;
}
else
{
lean_object* x_79; lean_object* x_80; 
x_79 = lean_ctor_get(x_42, 0);
lean_inc(x_79);
lean_dec(x_42);
x_80 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_80, 0, x_79);
return x_80;
}
}
}
else
{
lean_object* x_81; lean_object* x_82; lean_object* x_83; lean_object* x_84; lean_object* x_85; lean_object* x_86; lean_object* x_87; lean_object* x_88; lean_object* x_89; 
x_81 = lean_ctor_get(x_26, 1);
lean_inc(x_81);
lean_dec(x_26);
x_82 = lp_mathlib_List_mapTR_loop___at___00Mathlib_Deriving_Fintype_mkFintypeEnum_spec__0(x_81, x_21);
x_83 = l_Lean_Expr_const___override(x_14, x_82);
x_84 = lp_RealLike_RealLike_specializeToFloat___closed__8;
x_85 = lean_array_push(x_84, x_30);
x_86 = l_Lean_mkAppN(x_83, x_85);
lean_dec_ref(x_85);
x_87 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_86, x_17);
x_88 = lean_ctor_get(x_87, 0);
lean_inc(x_88);
lean_dec_ref(x_87);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc(x_17);
lean_inc(x_88);
x_89 = lean_infer_type(x_88, x_16, x_17, x_18, x_19);
if (lean_obj_tag(x_89) == 0)
{
lean_object* x_90; lean_object* x_91; lean_object* x_92; lean_object* x_93; lean_object* x_94; lean_object* x_95; uint8_t x_96; lean_object* x_97; lean_object* x_98; lean_object* x_99; 
x_90 = lean_ctor_get(x_89, 0);
lean_inc(x_90);
lean_dec_ref(x_89);
x_91 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_90, x_17);
lean_dec(x_17);
x_92 = lean_ctor_get(x_91, 0);
lean_inc(x_92);
if (lean_is_exclusive(x_91)) {
 lean_ctor_release(x_91, 0);
 x_93 = x_91;
} else {
 lean_dec_ref(x_91);
 x_93 = lean_box(0);
}
lean_inc(x_9);
x_94 = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(x_94, 0, x_9);
lean_ctor_set(x_94, 1, x_21);
lean_ctor_set(x_94, 2, x_92);
x_95 = lean_box(1);
x_96 = 1;
lean_inc(x_9);
x_97 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_97, 0, x_9);
lean_ctor_set(x_97, 1, x_21);
lean_ctor_set(x_15, 3, x_97);
lean_ctor_set(x_15, 2, x_95);
lean_ctor_set(x_15, 1, x_88);
lean_ctor_set(x_15, 0, x_94);
lean_ctor_set_uint8(x_15, sizeof(void*)*4, x_96);
if (lean_is_scalar(x_93)) {
 x_98 = lean_alloc_ctor(1, 1, 0);
} else {
 x_98 = x_93;
 lean_ctor_set_tag(x_98, 1);
}
lean_ctor_set(x_98, 0, x_15);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc_ref(x_98);
x_99 = l_Lean_addDecl(x_98, x_10, x_18, x_19);
if (lean_obj_tag(x_99) == 0)
{
uint8_t x_100; lean_object* x_101; 
lean_dec_ref(x_99);
x_100 = 1;
x_101 = l_Lean_compileDecl(x_98, x_100, x_18, x_19);
if (lean_obj_tag(x_101) == 0)
{
lean_object* x_102; lean_object* x_103; 
if (lean_is_exclusive(x_101)) {
 lean_ctor_release(x_101, 0);
 x_102 = x_101;
} else {
 lean_dec_ref(x_101);
 x_102 = lean_box(0);
}
if (lean_is_scalar(x_102)) {
 x_103 = lean_alloc_ctor(0, 1, 0);
} else {
 x_103 = x_102;
}
lean_ctor_set(x_103, 0, x_9);
return x_103;
}
else
{
lean_object* x_104; lean_object* x_105; lean_object* x_106; 
lean_dec(x_9);
x_104 = lean_ctor_get(x_101, 0);
lean_inc(x_104);
if (lean_is_exclusive(x_101)) {
 lean_ctor_release(x_101, 0);
 x_105 = x_101;
} else {
 lean_dec_ref(x_101);
 x_105 = lean_box(0);
}
if (lean_is_scalar(x_105)) {
 x_106 = lean_alloc_ctor(1, 1, 0);
} else {
 x_106 = x_105;
}
lean_ctor_set(x_106, 0, x_104);
return x_106;
}
}
else
{
lean_object* x_107; lean_object* x_108; lean_object* x_109; 
lean_dec_ref(x_98);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_9);
x_107 = lean_ctor_get(x_99, 0);
lean_inc(x_107);
if (lean_is_exclusive(x_99)) {
 lean_ctor_release(x_99, 0);
 x_108 = x_99;
} else {
 lean_dec_ref(x_99);
 x_108 = lean_box(0);
}
if (lean_is_scalar(x_108)) {
 x_109 = lean_alloc_ctor(1, 1, 0);
} else {
 x_109 = x_108;
}
lean_ctor_set(x_109, 0, x_107);
return x_109;
}
}
else
{
lean_object* x_110; lean_object* x_111; lean_object* x_112; 
lean_dec(x_88);
lean_free_object(x_15);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_17);
lean_dec(x_9);
x_110 = lean_ctor_get(x_89, 0);
lean_inc(x_110);
if (lean_is_exclusive(x_89)) {
 lean_ctor_release(x_89, 0);
 x_111 = x_89;
} else {
 lean_dec_ref(x_89);
 x_111 = lean_box(0);
}
if (lean_is_scalar(x_111)) {
 x_112 = lean_alloc_ctor(1, 1, 0);
} else {
 x_112 = x_111;
}
lean_ctor_set(x_112, 0, x_110);
return x_112;
}
}
}
else
{
lean_object* x_113; lean_object* x_114; lean_object* x_115; lean_object* x_116; lean_object* x_117; lean_object* x_118; lean_object* x_119; lean_object* x_120; lean_object* x_121; lean_object* x_122; lean_object* x_123; lean_object* x_124; 
x_113 = lean_ctor_get(x_15, 0);
lean_inc(x_113);
lean_dec(x_15);
x_114 = lean_ctor_get(x_24, 0);
lean_inc(x_114);
lean_dec_ref(x_24);
x_115 = lean_ctor_get(x_113, 1);
lean_inc(x_115);
if (lean_is_exclusive(x_113)) {
 lean_ctor_release(x_113, 0);
 lean_ctor_release(x_113, 1);
 lean_ctor_release(x_113, 2);
 x_116 = x_113;
} else {
 lean_dec_ref(x_113);
 x_116 = lean_box(0);
}
x_117 = lp_mathlib_List_mapTR_loop___at___00Mathlib_Deriving_Fintype_mkFintypeEnum_spec__0(x_115, x_21);
x_118 = l_Lean_Expr_const___override(x_14, x_117);
x_119 = lp_RealLike_RealLike_specializeToFloat___closed__8;
x_120 = lean_array_push(x_119, x_114);
x_121 = l_Lean_mkAppN(x_118, x_120);
lean_dec_ref(x_120);
x_122 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_121, x_17);
x_123 = lean_ctor_get(x_122, 0);
lean_inc(x_123);
lean_dec_ref(x_122);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc(x_17);
lean_inc(x_123);
x_124 = lean_infer_type(x_123, x_16, x_17, x_18, x_19);
if (lean_obj_tag(x_124) == 0)
{
lean_object* x_125; lean_object* x_126; lean_object* x_127; lean_object* x_128; lean_object* x_129; lean_object* x_130; uint8_t x_131; lean_object* x_132; lean_object* x_133; lean_object* x_134; lean_object* x_135; 
x_125 = lean_ctor_get(x_124, 0);
lean_inc(x_125);
lean_dec_ref(x_124);
x_126 = lp_mathlib_Lean_instantiateMVars___at___00Mathlib_Meta_Positivity_evalRealArctan_spec__2___redArg(x_125, x_17);
lean_dec(x_17);
x_127 = lean_ctor_get(x_126, 0);
lean_inc(x_127);
if (lean_is_exclusive(x_126)) {
 lean_ctor_release(x_126, 0);
 x_128 = x_126;
} else {
 lean_dec_ref(x_126);
 x_128 = lean_box(0);
}
lean_inc(x_9);
if (lean_is_scalar(x_116)) {
 x_129 = lean_alloc_ctor(0, 3, 0);
} else {
 x_129 = x_116;
}
lean_ctor_set(x_129, 0, x_9);
lean_ctor_set(x_129, 1, x_21);
lean_ctor_set(x_129, 2, x_127);
x_130 = lean_box(1);
x_131 = 1;
lean_inc(x_9);
x_132 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_132, 0, x_9);
lean_ctor_set(x_132, 1, x_21);
x_133 = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(x_133, 0, x_129);
lean_ctor_set(x_133, 1, x_123);
lean_ctor_set(x_133, 2, x_130);
lean_ctor_set(x_133, 3, x_132);
lean_ctor_set_uint8(x_133, sizeof(void*)*4, x_131);
if (lean_is_scalar(x_128)) {
 x_134 = lean_alloc_ctor(1, 1, 0);
} else {
 x_134 = x_128;
 lean_ctor_set_tag(x_134, 1);
}
lean_ctor_set(x_134, 0, x_133);
lean_inc(x_19);
lean_inc_ref(x_18);
lean_inc_ref(x_134);
x_135 = l_Lean_addDecl(x_134, x_10, x_18, x_19);
if (lean_obj_tag(x_135) == 0)
{
uint8_t x_136; lean_object* x_137; 
lean_dec_ref(x_135);
x_136 = 1;
x_137 = l_Lean_compileDecl(x_134, x_136, x_18, x_19);
if (lean_obj_tag(x_137) == 0)
{
lean_object* x_138; lean_object* x_139; 
if (lean_is_exclusive(x_137)) {
 lean_ctor_release(x_137, 0);
 x_138 = x_137;
} else {
 lean_dec_ref(x_137);
 x_138 = lean_box(0);
}
if (lean_is_scalar(x_138)) {
 x_139 = lean_alloc_ctor(0, 1, 0);
} else {
 x_139 = x_138;
}
lean_ctor_set(x_139, 0, x_9);
return x_139;
}
else
{
lean_object* x_140; lean_object* x_141; lean_object* x_142; 
lean_dec(x_9);
x_140 = lean_ctor_get(x_137, 0);
lean_inc(x_140);
if (lean_is_exclusive(x_137)) {
 lean_ctor_release(x_137, 0);
 x_141 = x_137;
} else {
 lean_dec_ref(x_137);
 x_141 = lean_box(0);
}
if (lean_is_scalar(x_141)) {
 x_142 = lean_alloc_ctor(1, 1, 0);
} else {
 x_142 = x_141;
}
lean_ctor_set(x_142, 0, x_140);
return x_142;
}
}
else
{
lean_object* x_143; lean_object* x_144; lean_object* x_145; 
lean_dec_ref(x_134);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_9);
x_143 = lean_ctor_get(x_135, 0);
lean_inc(x_143);
if (lean_is_exclusive(x_135)) {
 lean_ctor_release(x_135, 0);
 x_144 = x_135;
} else {
 lean_dec_ref(x_135);
 x_144 = lean_box(0);
}
if (lean_is_scalar(x_144)) {
 x_145 = lean_alloc_ctor(1, 1, 0);
} else {
 x_145 = x_144;
}
lean_ctor_set(x_145, 0, x_143);
return x_145;
}
}
else
{
lean_object* x_146; lean_object* x_147; lean_object* x_148; 
lean_dec(x_123);
lean_dec(x_116);
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_17);
lean_dec(x_9);
x_146 = lean_ctor_get(x_124, 0);
lean_inc(x_146);
if (lean_is_exclusive(x_124)) {
 lean_ctor_release(x_124, 0);
 x_147 = x_124;
} else {
 lean_dec_ref(x_124);
 x_147 = lean_box(0);
}
if (lean_is_scalar(x_147)) {
 x_148 = lean_alloc_ctor(1, 1, 0);
} else {
 x_148 = x_147;
}
lean_ctor_set(x_148, 0, x_146);
return x_148;
}
}
}
else
{
uint8_t x_149; 
lean_dec(x_19);
lean_dec_ref(x_18);
lean_dec(x_17);
lean_dec_ref(x_16);
lean_dec_ref(x_15);
lean_dec(x_14);
lean_dec(x_9);
x_149 = !lean_is_exclusive(x_24);
if (x_149 == 0)
{
return x_24;
}
else
{
lean_object* x_150; lean_object* x_151; 
x_150 = lean_ctor_get(x_24, 0);
lean_inc(x_150);
lean_dec(x_24);
x_151 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_151, 0, x_150);
return x_151;
}
}
}
}
else
{
uint8_t x_174; 
lean_dec(x_5);
lean_dec_ref(x_4);
lean_dec(x_3);
lean_dec_ref(x_2);
lean_dec(x_1);
x_174 = !lean_is_exclusive(x_11);
if (x_174 == 0)
{
lean_object* x_175; 
x_175 = lean_ctor_get(x_11, 0);
lean_dec(x_175);
lean_ctor_set_tag(x_11, 0);
lean_ctor_set(x_11, 0, x_9);
return x_11;
}
else
{
lean_object* x_176; 
lean_dec(x_11);
x_176 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_176, 0, x_9);
return x_176;
}
}
}
}
LEAN_EXPORT lean_object* lp_RealLike_RealLike_specializeToFloat___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; 
x_7 = lp_RealLike_RealLike_specializeToFloat(x_1, x_2, x_3, x_4, x_5);
return x_7;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_RealLike_RealLike_Lowering(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RealLike_RealLike_Specialize(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RealLike_RealLike_Lowering(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_RealLike_RealLike_specializeToFloat___closed__0 = _init_lp_RealLike_RealLike_specializeToFloat___closed__0();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__0);
lp_RealLike_RealLike_specializeToFloat___closed__1 = _init_lp_RealLike_RealLike_specializeToFloat___closed__1();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__1);
lp_RealLike_RealLike_specializeToFloat___closed__2 = _init_lp_RealLike_RealLike_specializeToFloat___closed__2();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__2);
lp_RealLike_RealLike_specializeToFloat___closed__3 = _init_lp_RealLike_RealLike_specializeToFloat___closed__3();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__3);
lp_RealLike_RealLike_specializeToFloat___closed__4 = _init_lp_RealLike_RealLike_specializeToFloat___closed__4();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__4);
lp_RealLike_RealLike_specializeToFloat___closed__5 = _init_lp_RealLike_RealLike_specializeToFloat___closed__5();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__5);
lp_RealLike_RealLike_specializeToFloat___closed__6 = _init_lp_RealLike_RealLike_specializeToFloat___closed__6();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__6);
lp_RealLike_RealLike_specializeToFloat___closed__7 = _init_lp_RealLike_RealLike_specializeToFloat___closed__7();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__7);
lp_RealLike_RealLike_specializeToFloat___closed__8 = _init_lp_RealLike_RealLike_specializeToFloat___closed__8();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__8);
lp_RealLike_RealLike_specializeToFloat___closed__9 = _init_lp_RealLike_RealLike_specializeToFloat___closed__9();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__9);
lp_RealLike_RealLike_specializeToFloat___closed__10 = _init_lp_RealLike_RealLike_specializeToFloat___closed__10();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__10);
lp_RealLike_RealLike_specializeToFloat___closed__11 = _init_lp_RealLike_RealLike_specializeToFloat___closed__11();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__11);
lp_RealLike_RealLike_specializeToFloat___closed__12 = _init_lp_RealLike_RealLike_specializeToFloat___closed__12();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__12);
lp_RealLike_RealLike_specializeToFloat___closed__13 = _init_lp_RealLike_RealLike_specializeToFloat___closed__13();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__13);
lp_RealLike_RealLike_specializeToFloat___closed__14 = _init_lp_RealLike_RealLike_specializeToFloat___closed__14();
lean_mark_persistent(lp_RealLike_RealLike_specializeToFloat___closed__14);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
