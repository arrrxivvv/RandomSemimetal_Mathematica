(* ::Package:: *)

(* ::Section:: *)
(*Geo3d*)


BeginPackage["Geo3d`"]


lnkDimLst;


Begin["Priavte`"]


nDim3=3;


lnkDimLst=Table[Delete[Range[nDim3],iDim],{iDim,nDim3}];


End[]


EndPackage[]
