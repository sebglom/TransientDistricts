﻿within TransiEnt.Components.Electrical.Grid.Components;
model Capacitor "Modell for a specific Capacitor. Capacitance will be calculated from length and specific capacitance"




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

  extends Base.PartialSpecificElement1Pin;

  // _____________________________________________
  //
  //        Constants and Hidden Parameters
  // _____________________________________________

protected
  final parameter SI.Capacitance C = c * l "Capacitance of SpecificCapacitor";

  // _____________________________________________
  //
  //             Visible Parameters
  // _____________________________________________

public
  parameter TransiEnt.Basics.Units.SpecificCapacitance c=1 "specific capacitance";

  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

  //public
  //protected

  // _____________________________________________
  //
  //           Characteristic equations
  // _____________________________________________

equation
    Z.re = 0;
    Z.im = -1 / (2 * Modelica.Constants.pi * epp_p.f * C);

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-60,19},{60,-19}}, lineColor = {0,0,0}, fillColor = {255,255,255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "c=%c
l=%l", origin = {74,1}, rotation = 90),Text(extent = {{-59,19},{59,-19}}, lineColor = {0,0,0}, fillColor = {255,255,255},
            fillPattern =                                                                                                   FillPattern.Solid, origin = {-65,9}, rotation = 90),Line(points = {{-40,0},{40,0}}, color = {0,0,0}, smooth = Smooth.None, origin = {0,60}, rotation = 90),Line(points = {{0,40},{0,-40}}, color = {0,0,255}, smooth = Smooth.None, origin = {0,20}, rotation = 90),Line(points = {{0,40},{0,-40}}, color = {0,0,255}, smooth = Smooth.None, origin = {0,0}, rotation = 90),Line(points={{
              20,1.69959e-015},{80,6.09842e-015}},                                                                                                    color = {0,0,0}, smooth = Smooth.None, origin={0,
              -80},                                                                                                    rotation = 90),Line(points={{
              -30,-60},{30,-60}},                                                                                                    color = {0,0,0}, smooth = Smooth.None),Line(points={{
              -20,-70},{20,-70}},                                                                                                    color = {0,0,0}, smooth = Smooth.None),Line(points={{
              -8,-80},{10,-80}},                                                                                                    color = {0,0,0}, smooth = Smooth.None)}),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Partial model of a capacitor using TransiEnt complex single phase interface (L2)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">2. Level of detail, physical effects considered, and physical insight</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p>Apparent power port epp_p</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no elements)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no equations)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarks for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pattrick Göttsch and revised by Pascal Dubucq (dubucq@tuhh.de) on 01.10.2014</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Adjusted from three phase to single phase by Rebekka Denninger (rebekka.denninger@tuhh.de) on 01.03.2016</span></p>
</html>"));
end Capacitor;
