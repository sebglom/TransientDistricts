﻿within TransiEnt.Basics.Records;
model IdealGasBulk "Model for generating a summary for an ideal gas bulk"



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

    extends TransiEnt.Basics.Icons.Record;

  // _____________________________________________
  //
  //        Constants and Hidden Parameters
  // _____________________________________________

    replaceable parameter TransiEnt.Basics.Media.Gases.Gas_VDIWA_SG6_var mediumModel "Used medium model";

  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

    input SI.Mass mass "Mass" annotation(Dialog);
    input SI.Temperature T "Temperature" annotation(Dialog);
    input SI.Pressure p "Pressure" annotation(Dialog);
    input SI.SpecificEnthalpy h "Specific enthalpy" annotation(Dialog);
    input SI.MassFraction xi[mediumModel.nc - 1] "Component mass fractions"  annotation(Dialog);
    input SI.MassFraction x[mediumModel.nc - 1] "Component molar fractions"  annotation(Dialog);
    input SI.Density rho "Density" annotation(Dialog);

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>This model can be used to generate a summary of an ideal gas bulk</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>input for mass, temperature, specific enthalpy, pressure, component mass fraction, component molar fraction and density</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(none)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(none)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model created by Carsten Bode (c.bode@tuhh.de), Apr 2017</p>
</html>"));
end IdealGasBulk;
