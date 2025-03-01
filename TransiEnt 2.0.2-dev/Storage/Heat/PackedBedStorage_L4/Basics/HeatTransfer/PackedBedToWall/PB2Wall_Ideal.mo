﻿within TransiEnt.Storage.Heat.PackedBedStorage_L4.Basics.HeatTransfer.PackedBedToWall;
model PB2Wall_Ideal "PB2Wall - Ideal Heat Transfer"




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

  import SI = ClaRa.Basics.Units;

  extends TransiEnt.Storage.Heat.PackedBedStorage_L4.Basics.HeatTransfer.PackedBedToWall.HeatTransferBasePB2Wall;

  // _____________________________________________
  //
  //              Visible Parameters
  // _____________________________________________

  parameter SI.Area[iCom.N_cv] A_heat=geo.A_heat "Area of heat transfer" annotation (Dialog(enable=false, tab = "Internals"));

  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

  SI.MassFlowRate m_flow[iCom.N_cv + 1] "Mass flow rate";
  SI.Temperature T_mean[iCom.N_cv];

equation

  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________

  alpha = ones(iCom.N_cv);
  T_mean = iCom.T;
  heat.T = T_mean;

  annotation (Icon(graphics),
              Diagram(graphics),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Ideal heat transfer from packed bed to wall</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>(none)</p>
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
<p>Model created by Michael von der Heyde (heyde@tuhh.de) for the FES research project, March 2021</p>
</html>"));
end PB2Wall_Ideal;
