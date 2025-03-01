﻿within TransiEnt.Producer.Electrical.Controllers;
model PrimaryBalancingControllerDeadband "Primary balancing controller with deadband but without limit (limit must be defined by plant)"



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

  extends TransiEnt.Producer.Electrical.Controllers.Base.PartialPrimaryBalancingController;


  // _____________________________________________
  //
  //                   Parameters
  // _____________________________________________

  parameter Real delta_pr = 0.2 "droop of primary balancing control (delta_pr = delta_f / delta_P)";

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  TransiEnt.Basics.Blocks.DeadZoneLinear deadband(uMax=delta_f_db/simCenter.f_n, uMin=-delta_f_db/simCenter.f_n) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gain(k=1/delta_pr)
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  parameter SI.Frequency delta_f_db=0.01 "Frequency deadband of primary control";
public
  Modelica.Blocks.Math.Gain delta_f_star(k=1/simCenter.f_n) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,0})));
  Modelica.Blocks.Nonlinear.Limiter P_PBP_limit_star(
    strict=true,
    uMax=1,
    uMin=-1)     annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Math.Gain P_PBP(k=P_n) annotation (Placement(transformation(extent={{67,-9},{86,9}})));
equation
  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________
  connect(deadband.y, gain.u) annotation (Line(
      points={{-9,0},{4,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delta_f, delta_f_star.u) annotation (Line(points={{-110,0},{-94,0},{-78,0}}, color={0,0,127}));
  connect(delta_f_star.y, deadband.u) annotation (Line(points={{-55,0},{-44,0},{-32,0}}, color={0,0,127}));
  connect(gain.y, P_PBP_limit_star.u) annotation (Line(points={{27,0},{30.5,0},{34,0}}, color={0,0,127}));
  connect(P_PBP_limit_star.y, P_PBP.u) annotation (Line(points={{57,0},{65.1,0}}, color={0,0,127}));
  connect(P_PBP.y, P_PBP_set) annotation (Line(points={{86.95,0},{106,0}}, color={0,0,127}));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(graphics,
                                               coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Primary balancing controller with deadband but without limit (limit must be defined by plant).</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>delta_f: input for frequency in Hz (connector of real input signal)</p>
<p>P_PBP_set: output for electric power in W (primary balancing setpoint)</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model created by Pascal Dubucq (dubucq@tuhh.de) <span style=\"font-family: MS Shell Dlg 2;\">on 01.10.2014</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Quality check (Code conventions) by Rebekka Denninger on 01.10.2016</span></p>
</html>"));
end PrimaryBalancingControllerDeadband;
