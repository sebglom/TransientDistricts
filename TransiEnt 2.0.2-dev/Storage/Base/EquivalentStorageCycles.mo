﻿within TransiEnt.Storage.Base;
model EquivalentStorageCycles "Equivalent cycles calculator"



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

  extends TransiEnt.Basics.Icons.Block;

  // _____________________________________________
  //
  //                Parameter
  // _____________________________________________

  parameter SI.Energy E_max "Maximum storage capacity";

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  //outer Consumer.DemandSideManagement.PVBatteryPoolControl.Base.PoolParameter param;

  Modelica.Blocks.Interfaces.RealOutput cycles "Equivalent cycles"
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
          rotation=0)));
  Basics.Interfaces.Electrical.ElectricPowerIn
                                       P_stor_is "Storage power (in W)" annotation (Placement(transformation(extent={{-116,-10},{-96,10}}, rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=0.5/E_max)
    annotation (Placement(transformation(extent={{-28,-10},{-6,10}},
          rotation=0)));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  Modelica.Blocks.Continuous.Integrator integrator(y_start=0)
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  // _____________________________________________
  //
  //       Final and protected parameters
  // _____________________________________________

equation
  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(P_stor_is, abs1.u) annotation (Line(
      points={{-106,0},{-60,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(abs1.y, gain.u) annotation (Line(
      points={{-37,0},{-30.2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integrator.y, cycles) annotation (Line(
      points={{49,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, integrator.u) annotation (Line(points={{-4.9,0},{26,0}}, color={0,0,127}));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
                       Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}),
                            graphics={
        Text(
          extent={{-22,16},{84,-22}},
          lineColor={0,0,130},
          textString="cycles")}),
                Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Equivalent cycles calculator</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>cycles: RealOutput</p>
<p>P_stor_is: input for electric storage power in [W]</p>
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
end EquivalentStorageCycles;
