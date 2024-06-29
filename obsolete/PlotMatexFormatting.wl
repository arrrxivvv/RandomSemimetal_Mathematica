(* ::Package:: *)

(* ::Title:: *)
(*PlotMatexFormatting*)


(* ::Text:: *)
(*Plot formatting functions, including Latex labels*)


BeginPackage["PlotMatexFormatting`",{"MaTeX`"}];


(* ::Section:: *)
(*Public*)


(* ::Subsection:: *)
(*Format parameters*)


texStyle;


titleMag;
labMag;
labMagSmall;
tickMag;
dataThick;
legMkSz;
fenceW;
darkRed;
markerPtSz;
cm;


colorLst;


(* ::Subsection:: *)
(*Captions*)


capTex;


(* ::Subsection:: *)
(*Plotting utilities*)


getMaxPadding;


(* ::Subsection:: *)
(*MaTeX utilities*)


matexLstFunc;
lineStyleLstFunc;


(* ::Subsection:: *)
(*data functions*)


makeDataErr;
makeInset;
histLstToDat;


(* ::Section:: *)
(*Private*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Format parameters*)


(* ::Input::Initialization:: *)
texStyle={FontFamily->"Times New Roman",FontSize->8,FontWeight-> "Plain"};


(* ::Input::Initialization:: *)
titleMag=1.1;
labMag=1.0;
labMagSmall=0.8;
tickMag=0.8;
dataThick=AbsoluteThickness[1];
legMkSz=22;
fenceW=0.02;
darkRed=RGBColor[0.8,0,0];
markerPtSz=AbsolutePointSize[3.5];
cm=72/2.54;


(* ::Input::Initialization:: *)
colorLst={Black}~Join~Table[ColorData[112,ii],{ii,1,100}];


(* ::Input::Initialization:: *)
SetOptions[MaTeX,"Preamble"->{"\\usepackage{color,txfonts}"}];
SetOptions[MaTeX,"FontSize"->10];


(* ::Input::Initialization:: *)
SetOptions[$FrontEndSession,PrintingStyleEnvironment->"Working"];


(* ::Subsection:: *)
(*Captions*)


(* ::Input::Initialization:: *)
capTex=MaTeX[#,Magnification->titleMag]&/@{"\\mathrm{(a)}","\\mathrm{(b)}","\\mathrm{(c)}","\\mathrm{(d)}"};


(* ::Subsection:: *)
(*Plotting utilities*)


(* ::Input::Initialization:: *)
getMaxPadding[p_List]:=Map[Max,(BorderDimensions@Image[Show[#,LabelStyle->White,Background->White]]&/@p)~Flatten~{{3},{2}},{2}]+1;


(* ::Input::Initialization:: *)
lineStyleLstFunc[colors_,thick_]:=Table[{colors[[iC]],thick},{iC,1,Length[colors]}];


(* ::Subsection:: *)
(*MaTeX utilities*)


(* ::Input::Initialization:: *)
Options[matexLstFunc]={"prefix"->""};
matexLstFunc[strLst_,mag_,OptionsPattern[]]:=MaTeX[OptionValue["prefix"]<>#,Magnification->mag]&/@strLst;


(* ::Subsection:: *)
(*Data functions*)


(* ::Input::Initialization:: *)
makeDataErr[dataLst_,varLst_]:=Module[{ln},
ln=Length[dataLst];
Table[Around[dataLst[[it]],varLst[[it]]],{it,1,ln}]];


(* ::Input::Initialization:: *)
makeInset[plot_Legended]:=Show[{plot[[1]],Graphics[Inset[plot[[2,1]],Scaled[plot[[2,2]]]]]}]


(* ::Input::Initialization:: *)
histLstToDat[histLst_]:=Table[{(histLst[[1,ii]]+histLst[[1,ii+1]])/2,histLst[[2,ii]]},{ii,1,Length[histLst[[2]]]}];


End[];


EndPackage[];
