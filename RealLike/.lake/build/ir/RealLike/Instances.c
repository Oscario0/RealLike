// Lean compiler output
// Module: RealLike.Instances
// Imports: public import Init public import Mathlib.Data.Real.Basic public import Mathlib.Data.Real.Sqrt public import Mathlib.Algebra.Order.Floor.Ring public import Mathlib.Algebra.Order.Round public import Mathlib.Analysis.SpecialFunctions.Exp public import Mathlib.Analysis.SpecialFunctions.Log.Basic public import Mathlib.Analysis.SpecialFunctions.Pow.Real public import Mathlib.Analysis.Complex.Trigonometric public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse public import Mathlib.Analysis.SpecialFunctions.Complex.Arg public import RealLike.Class
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
static lean_object* lp_RealLike_instRealLikeFloat___closed__10;
lean_object* l_Float_sqrt___boxed(lean_object*);
static double lp_RealLike_instRealLikeFloat___closed__7;
LEAN_EXPORT lean_object* lp_RealLike_instRealLikeFloat;
static lean_object* lp_RealLike_instRealLikeFloat___closed__9;
lean_object* l_Float_round___boxed(lean_object*);
lean_object* l_Float_floor___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__3;
lean_object* l_Float_tanh___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1;
lean_object* l_Float_add___boxed(lean_object*, lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__22;
static lean_object* lp_RealLike_instRealLikeFloat___closed__14;
lean_object* l_Float_decLt___boxed(lean_object*, lean_object*);
lean_object* l_Float_atan2___boxed(lean_object*, lean_object*);
static double lp_RealLike_instRealLikeFloat___closed__6;
static lean_object* lp_RealLike_instRealLikeFloat___closed__1;
static lean_object* lp_RealLike_instRealLikeFloat___closed__21;
lean_object* l_Float_sinh___boxed(lean_object*);
lean_object* l_Float_cosh___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2;
lean_object* l_Float_log___boxed(lean_object*);
lean_object* l_Float_atan___boxed(lean_object*);
lean_object* l_Float_cos___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__5;
lean_object* l_Float_decLe___boxed(lean_object*, lean_object*);
lean_object* l_Float_abs___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__19;
static lean_object* lp_RealLike_instRealLikeFloat___closed__11;
static lean_object* lp_RealLike_instRealLikeFloat___closed__8;
static lean_object* lp_RealLike_instRealLikeFloat___closed__20;
static lean_object* lp_RealLike_instRealLikeFloat___closed__17;
lean_object* l_Float_neg___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__12;
static lean_object* lp_RealLike_instRealLikeFloat___closed__13;
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
lean_object* l_Float_div___boxed(lean_object*, lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__26;
lean_object* l_Float_ceil___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__25;
static lean_object* lp_RealLike_instRealLikeFloat___closed__15;
lean_object* l_Float_ofNat___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__0;
static lean_object* lp_RealLike_instRealLikeFloat___closed__23;
lean_object* l_Float_acos___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__4;
lean_object* l_Float_exp___boxed(lean_object*);
lean_object* l_Float_mul___boxed(lean_object*, lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__2;
lean_object* l_Float_asin___boxed(lean_object*);
lean_object* l_Float_pow___boxed(lean_object*, lean_object*);
lean_object* l_Float_tan___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__24;
static lean_object* lp_RealLike_instRealLikeFloat___closed__16;
static lean_object* lp_RealLike_instRealLikeFloat___closed__27;
lean_object* l_Float_sin___boxed(lean_object*);
static lean_object* lp_RealLike_instRealLikeFloat___closed__18;
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__0() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_decLe___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_decLt___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_add___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_mul___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__4() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_div___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__5() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_neg___boxed), 1, 0);
return x_1;
}
}
static double _init_lp_RealLike_instRealLikeFloat___closed__6() {
_start:
{
lean_object* x_1; uint8_t x_2; lean_object* x_3; double x_4; 
x_1 = lean_unsigned_to_nat(1u);
x_2 = 1;
x_3 = lean_unsigned_to_nat(0u);
x_4 = l_Float_ofScientific(x_3, x_2, x_1);
return x_4;
}
}
static double _init_lp_RealLike_instRealLikeFloat___closed__7() {
_start:
{
lean_object* x_1; uint8_t x_2; lean_object* x_3; double x_4; 
x_1 = lean_unsigned_to_nat(1u);
x_2 = 1;
x_3 = lean_unsigned_to_nat(10u);
x_4 = l_Float_ofScientific(x_3, x_2, x_1);
return x_4;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__8() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_ofNat___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__9() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_pow___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__10() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_sqrt___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__11() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_abs___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__12() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_floor___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__13() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_ceil___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__14() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_round___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__15() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_exp___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__16() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_log___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__17() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_sin___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__18() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_cos___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__19() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_tan___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__20() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_asin___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__21() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_acos___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__22() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_atan___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__23() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_atan2___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__24() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_sinh___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__25() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_cosh___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__26() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Float_tanh___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1() {
_start:
{
double x_1; lean_object* x_2; 
x_1 = lp_RealLike_instRealLikeFloat___closed__6;
x_2 = lean_box_float(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2() {
_start:
{
double x_1; lean_object* x_2; 
x_1 = lp_RealLike_instRealLikeFloat___closed__7;
x_2 = lean_box_float(x_1);
return x_2;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat___closed__27() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; 
x_1 = lp_RealLike_instRealLikeFloat___closed__26;
x_2 = lp_RealLike_instRealLikeFloat___closed__25;
x_3 = lp_RealLike_instRealLikeFloat___closed__24;
x_4 = lp_RealLike_instRealLikeFloat___closed__23;
x_5 = lp_RealLike_instRealLikeFloat___closed__22;
x_6 = lp_RealLike_instRealLikeFloat___closed__21;
x_7 = lp_RealLike_instRealLikeFloat___closed__20;
x_8 = lp_RealLike_instRealLikeFloat___closed__19;
x_9 = lp_RealLike_instRealLikeFloat___closed__18;
x_10 = lp_RealLike_instRealLikeFloat___closed__17;
x_11 = lp_RealLike_instRealLikeFloat___closed__16;
x_12 = lp_RealLike_instRealLikeFloat___closed__15;
x_13 = lp_RealLike_instRealLikeFloat___closed__14;
x_14 = lp_RealLike_instRealLikeFloat___closed__13;
x_15 = lp_RealLike_instRealLikeFloat___closed__12;
x_16 = lp_RealLike_instRealLikeFloat___closed__11;
x_17 = lp_RealLike_instRealLikeFloat___closed__10;
x_18 = lp_RealLike_instRealLikeFloat___closed__9;
x_19 = lp_RealLike_instRealLikeFloat___closed__8;
x_20 = lp_RealLike_instRealLikeFloat___closed__1;
x_21 = lp_RealLike_instRealLikeFloat___closed__0;
x_22 = lp_RealLike_instRealLikeFloat___closed__5;
x_23 = lp_RealLike_instRealLikeFloat___closed__4;
x_24 = lp_RealLike_instRealLikeFloat___closed__3;
x_25 = lp_RealLike_instRealLikeFloat___closed__2;
x_26 = lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1;
x_27 = lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2;
x_28 = lean_alloc_ctor(0, 27, 0);
lean_ctor_set(x_28, 0, x_25);
lean_ctor_set(x_28, 1, x_24);
lean_ctor_set(x_28, 2, x_23);
lean_ctor_set(x_28, 3, x_22);
lean_ctor_set(x_28, 4, x_21);
lean_ctor_set(x_28, 5, x_20);
lean_ctor_set(x_28, 6, x_26);
lean_ctor_set(x_28, 7, x_27);
lean_ctor_set(x_28, 8, x_19);
lean_ctor_set(x_28, 9, x_18);
lean_ctor_set(x_28, 10, x_17);
lean_ctor_set(x_28, 11, x_16);
lean_ctor_set(x_28, 12, x_15);
lean_ctor_set(x_28, 13, x_14);
lean_ctor_set(x_28, 14, x_13);
lean_ctor_set(x_28, 15, x_12);
lean_ctor_set(x_28, 16, x_11);
lean_ctor_set(x_28, 17, x_10);
lean_ctor_set(x_28, 18, x_9);
lean_ctor_set(x_28, 19, x_8);
lean_ctor_set(x_28, 20, x_7);
lean_ctor_set(x_28, 21, x_6);
lean_ctor_set(x_28, 22, x_5);
lean_ctor_set(x_28, 23, x_4);
lean_ctor_set(x_28, 24, x_3);
lean_ctor_set(x_28, 25, x_2);
lean_ctor_set(x_28, 26, x_1);
return x_28;
}
}
static lean_object* _init_lp_RealLike_instRealLikeFloat() {
_start:
{
lean_object* x_1; 
x_1 = lp_RealLike_instRealLikeFloat___closed__27;
return x_1;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Data_Real_Basic(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Data_Real_Sqrt(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Algebra_Order_Floor_Ring(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Algebra_Order_Round(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Exp(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Log_Basic(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Pow_Real(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_Complex_Trigonometric(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Trigonometric_Arctan(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Trigonometric_Inverse(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Complex_Arg(uint8_t builtin);
lean_object* initialize_RealLike_RealLike_Class(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RealLike_RealLike_Instances(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Data_Real_Basic(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Data_Real_Sqrt(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Algebra_Order_Floor_Ring(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Algebra_Order_Round(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Exp(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Log_Basic(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Pow_Real(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_Complex_Trigonometric(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Trigonometric_Arctan(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Trigonometric_Inverse(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib_Analysis_SpecialFunctions_Complex_Arg(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RealLike_RealLike_Class(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_RealLike_instRealLikeFloat___closed__0 = _init_lp_RealLike_instRealLikeFloat___closed__0();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__0);
lp_RealLike_instRealLikeFloat___closed__1 = _init_lp_RealLike_instRealLikeFloat___closed__1();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__1);
lp_RealLike_instRealLikeFloat___closed__2 = _init_lp_RealLike_instRealLikeFloat___closed__2();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__2);
lp_RealLike_instRealLikeFloat___closed__3 = _init_lp_RealLike_instRealLikeFloat___closed__3();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__3);
lp_RealLike_instRealLikeFloat___closed__4 = _init_lp_RealLike_instRealLikeFloat___closed__4();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__4);
lp_RealLike_instRealLikeFloat___closed__5 = _init_lp_RealLike_instRealLikeFloat___closed__5();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__5);
lp_RealLike_instRealLikeFloat___closed__6 = _init_lp_RealLike_instRealLikeFloat___closed__6();
lp_RealLike_instRealLikeFloat___closed__7 = _init_lp_RealLike_instRealLikeFloat___closed__7();
lp_RealLike_instRealLikeFloat___closed__8 = _init_lp_RealLike_instRealLikeFloat___closed__8();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__8);
lp_RealLike_instRealLikeFloat___closed__9 = _init_lp_RealLike_instRealLikeFloat___closed__9();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__9);
lp_RealLike_instRealLikeFloat___closed__10 = _init_lp_RealLike_instRealLikeFloat___closed__10();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__10);
lp_RealLike_instRealLikeFloat___closed__11 = _init_lp_RealLike_instRealLikeFloat___closed__11();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__11);
lp_RealLike_instRealLikeFloat___closed__12 = _init_lp_RealLike_instRealLikeFloat___closed__12();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__12);
lp_RealLike_instRealLikeFloat___closed__13 = _init_lp_RealLike_instRealLikeFloat___closed__13();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__13);
lp_RealLike_instRealLikeFloat___closed__14 = _init_lp_RealLike_instRealLikeFloat___closed__14();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__14);
lp_RealLike_instRealLikeFloat___closed__15 = _init_lp_RealLike_instRealLikeFloat___closed__15();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__15);
lp_RealLike_instRealLikeFloat___closed__16 = _init_lp_RealLike_instRealLikeFloat___closed__16();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__16);
lp_RealLike_instRealLikeFloat___closed__17 = _init_lp_RealLike_instRealLikeFloat___closed__17();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__17);
lp_RealLike_instRealLikeFloat___closed__18 = _init_lp_RealLike_instRealLikeFloat___closed__18();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__18);
lp_RealLike_instRealLikeFloat___closed__19 = _init_lp_RealLike_instRealLikeFloat___closed__19();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__19);
lp_RealLike_instRealLikeFloat___closed__20 = _init_lp_RealLike_instRealLikeFloat___closed__20();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__20);
lp_RealLike_instRealLikeFloat___closed__21 = _init_lp_RealLike_instRealLikeFloat___closed__21();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__21);
lp_RealLike_instRealLikeFloat___closed__22 = _init_lp_RealLike_instRealLikeFloat___closed__22();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__22);
lp_RealLike_instRealLikeFloat___closed__23 = _init_lp_RealLike_instRealLikeFloat___closed__23();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__23);
lp_RealLike_instRealLikeFloat___closed__24 = _init_lp_RealLike_instRealLikeFloat___closed__24();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__24);
lp_RealLike_instRealLikeFloat___closed__25 = _init_lp_RealLike_instRealLikeFloat___closed__25();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__25);
lp_RealLike_instRealLikeFloat___closed__26 = _init_lp_RealLike_instRealLikeFloat___closed__26();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__26);
lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1 = _init_lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__27___boxed__const__1);
lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2 = _init_lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__27___boxed__const__2);
lp_RealLike_instRealLikeFloat___closed__27 = _init_lp_RealLike_instRealLikeFloat___closed__27();
lean_mark_persistent(lp_RealLike_instRealLikeFloat___closed__27);
lp_RealLike_instRealLikeFloat = _init_lp_RealLike_instRealLikeFloat();
lean_mark_persistent(lp_RealLike_instRealLikeFloat);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
