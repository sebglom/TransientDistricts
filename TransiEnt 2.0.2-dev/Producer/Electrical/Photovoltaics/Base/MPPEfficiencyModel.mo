﻿within TransiEnt.Producer.Electrical.Photovoltaics.Base;
block MPPEfficiencyModel "This efficiency model is taken from [4] Beyer, H.G., Heilscher, G., Bofinger, S. (2004): A robust model for the MPP performance 
      of different types of PV-modules applied for the performance check of grid connected 
      systems. In: Proc. Eurosun 2004, Freiburg "




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






  // _____________________________________________
  //
  //          Imports and Class Hierarchy
  // _____________________________________________

  extends Modelica.Blocks.Interfaces.MISO(nin=2);

  // _____________________________________________
  //
  //                   Parameters
  // _____________________________________________

  parameter Real a1=0.01;
  parameter Real a2=-2e-5;
  parameter Real a3=0.02;
  parameter Real alpha=0.0045;

  // _____________________________________________
  //
  //                    Variables
  // _____________________________________________

  Real G = max(1, u[1]);
  Real T = u[2];
  // _____________________________________________
  //
  //                    Equations
  // _____________________________________________

algorithm
  y:=(a1+a2*G+a3*log(G))*(1+alpha*(T-25));
annotation (
Icon(coordinateSystem(
    preserveAspectRatio=false,
    extent={{-100,-100},{100,100}},
    grid={2,2}), graphics={
    Text(
      extent={{-152,24},{138,-16}},
      lineColor={0,0,0},
        textString="eta= f(G,T)")}), Diagram(coordinateSystem(
        preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p>Efficiency model based on MPP performance.</p>
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
<p>This efficiency model is taken from [4] Beyer, H.G., Heilscher, G., Bofinger, S. (2004): A robust model for the MPP performance of different types of PV-modules applied for the performance check of grid connected systems. In: Proc. Eurosun 2004, Freiburg</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de) on 01.10.2014</span></p>
</html>"));
end MPPEfficiencyModel;
