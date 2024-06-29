(* ::Package:: *)

(* ::Title:: *)
(*DegFileNaming*)


(* ::Text:: *)
(*file naming utilities for DegLocator package*)


BeginPackage["DegFileNaming`"];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*file name formatting utilities*)


fAttrValFunc;
fNameFun;
resFun;
valDecForm;


(* ::Subsection:: *)
(*file extension consts*)


jldType;
jld2Type;
npyType;
epsType;
jpgType;
pdfType;


(* ::Section:: *)
(*Private*)


Begin["`Private`"];


(* ::Subsection:: *)
(*file attribute list utilities*)


(* ::Input::Initialization:: *)
attrLstBase = {"N", "param_divide", "instanceNum", "seed"};
attrLstBaseDim = {"dim"}~Join~attrLstBase;
attrLstDimLev = {"dim"}~Join~attrLstBase~Join~{"lev"};


(* ::Input::Initialization:: *)
valLstToStr[val_] := If[ArrayQ[val], StringReplace[ToString[val], {"{" -> "[", "}" -> "]"}], ToString[val]];


(* ::Input::Initialization:: *)
Options[fAttrValFunc] = {"alpha" -> 0, "attrMoreLst" -> {}, "valMoreLst" -> {}};
fAttrValFunc[mSz_, divLst_, itNum_, seed_, dim_, OptionsPattern[]] := Module[{attrLstTmp, valLstTmp, attrLstDimTmp, valLstDimTmp, alpha},
  attrLstTmp = attrLstBase;
  valLstTmp = {mSz, divLst, itNum, seed};
  alpha = OptionValue["alpha"];
  If[alpha != 0,
   attrLstTmp = attrLstTmp~Join~{"alpha"};
   valLstTmp = valLstTmp~Join~{NumberForm[alpha, {2, 1}]};];
  attrLstDimTmp = {"dim"}~Join~attrLstTmp;
  valLstDimTmp = {dim}~Join~valLstTmp;
  If[Length[OptionValue["attrMoreLst"]] > 0,
   attrLstDimTmp = attrLstDimTmp~Join~OptionValue["attrMoreLst"];
   attrLstTmp = attrLstTmp~Join~OptionValue["attrMoreLst"];
   valLstDimTmp = valLstDimTmp~Join~OptionValue["valMoreLst"];
   valLstTmp = valLstTmp~Join~OptionValue["valMoreLst"]];
  {attrLstDimTmp, valLstDimTmp, attrLstTmp, valLstTmp}
  ]


(* ::Input::Initialization:: *)
fNameFun[main_, attrLst_, valLst_, mod_, fExt_, isNoSpace_ : False] := Module[{fTmp = main, it},
   For[it = 1, it <= Length[attrLst], it++,
    fTmp = fTmp <> "_" <> attrLst[[it]] <> "_" <> valLstToStr[valLst[[it]]]];
   If[mod != "", fTmp = fTmp <> "_" <> mod];
   	fTmp = fTmp <> "." <> fExt;
   If[isNoSpace, fTmp = StringReplace[StringDelete[fTmp, {" ", "[", "]"}], "," -> "_"]];
   fTmp];


(* ::Input::Initialization:: *)
resFun[mSz_,mSzMin_:10,mSzMax_:50,resMin_:16,resMax_:32]:=Module[{dRes,dMsz},
dRes=resMax-resMin;
dMsz=mSzMax-mSzMin;
Floor[(mSz-mSzMin)/dMsz dRes+resMin]];


(* ::Input::Initialization:: *)
valDecForm[val_,numDec_]:=NumberForm[val,{\[Infinity],numDec}];


(* ::Subsection:: *)
(*file extension consts*)


jldType="jld";
jld2Type="jld2";
npyType="npy";
epsType="eps";
jpgType="jpg";
pdfType="pdf";


End[];


EndPackage[];
