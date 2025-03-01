﻿within TransiEnt.Grid.Electrical.Base;
partial record PartialGenerationPark "Empty partial generation park"



//________________________________________________________________________________//
// Component of the TransiEnt Library, version: 2.0.2                             //
//                                                                                //
// Licensed by Hamburg University of Technology under the 3-BSD-clause.           //
// Copyright 2021, Hamburg University of Technology.                              //
//________________________________________________________________________________//
//                                                                                //
// TransiEnt.EE, ResiliEntEE, IntegraNet and IntegraNet II are research projects  //
// supported by the German Federal Ministry of Economics and Energy               //
// (FKZ 03ET4003, 03ET4048, 0324027 and 03EI1008).                                //
// The TransiEnt Library research team consists of the following project partners://
// Institute of Engineering Thermodynamics (Hamburg University of Technology),    //
// Institute of Energy Systems (Hamburg University of Technology),                //
// Institute of Electrical Power and Energy Technology                            //
// (Hamburg University of Technology)                                             //
// Fraunhofer Institute for Environmental, Safety, and Energy Technology UMSICHT, //
// Gas- und Wärme-Institut Essen						  //
// and                                                                            //
// XRG Simulation GmbH (Hamburg, Germany).                                        //
//________________________________________________________________________________//





  extends Basics.Icons.Record;

  parameter String[nPlants] index=fill("",0) "Click on edit (little book) to see indexing";
  parameter Integer nPlants "No. of plants in scenario (including e.g. RE)";
  parameter Integer nDispPlants "No. of dispatchable plants (plants that get setpoints)";
  parameter Integer nMODPlants=nDispPlants "No. of plants participating in intraday optimization";

  parameter SI.Power P_max[nDispPlants] "Maximum power production of dispatchable plants"  annotation(Dialog(tab="Summary"));
  parameter SI.Power P_min[nDispPlants] "Minimum power production of dispatchable plants"  annotation(Dialog(tab="Summary"));
  parameter SI.Frequency P_grad_max_star[nDispPlants] "Maximum power gradient with respect to nominal capacity (1/3600 s means full load in 1 hout)"  annotation(Dialog(tab="Summary"));
  parameter TransiEnt.Basics.Units.MonetaryUnitPerEnergy C_var[nDispPlants] "Variable cost vector of dispatchable plants in MTU per Energy" annotation (Dialog(tab="Summary"));

  final parameter SI.Power P_total=sum(P_max) "Sum of installed capacity in generation park"  annotation(Dialog(tab="Summary"));

  parameter Integer[nMODPlants] isMOD=1:nDispPlants "Index set of plants that get setpoints from merit order dispatcher (intraday optimization)";
  parameter Integer[:] isFRE={0} "Index set of fluctuating renewable energy plants";
  parameter Integer[:] isCHP={0} "Index set of combined heat and power plants (these have time varying power limits)";

  final parameter SI.Power[nMODPlants] P_min_MOD = P_min[isMOD];
  final parameter SI.Power[nMODPlants] P_max_MOD = P_max[isMOD];
  final parameter SI.Frequency[nMODPlants] P_grad_max_star_MOD = P_grad_max_star[isMOD];
  final parameter Real[nMODPlants] C_var_MOD = C_var[isMOD];

  annotation (Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(empty record) partial generation park</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">2. Level of detail, physical effects considered, and physical insight</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarks for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
</html>"));
end PartialGenerationPark;
