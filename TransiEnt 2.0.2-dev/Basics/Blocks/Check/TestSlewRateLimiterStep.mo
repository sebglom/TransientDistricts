﻿within TransiEnt.Basics.Blocks.Check;
model TestSlewRateLimiterStep "Model for testing the SlewRateLimiterStep model"



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





  extends TransiEnt.Basics.Icons.Checkmodel;
  Modelica.Blocks.Sources.Step ramp(
    startTime=5,
    height=0.5,
    offset=0.5)
    annotation (Placement(transformation(extent={{-94,6},{-66,34}})));
  Modelica.Blocks.Sources.Constant
                               ramp1(k=0)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Nonlinear.Limiter P_max_star_limiter(uMax=1, uMin=0.2)
    "Upper limit is nominal power"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  TransiEnt.Basics.Blocks.VariableSlewRateLimiter slewRateLimiter(
    Td=0.01,
    useThresh=true,
    thres=1e-9,
    maxGrad_const=0.5/4) annotation (Placement(transformation(extent={{-4,-10},{-24,10}})));
equation
  connect(ramp.y, P_max_star_limiter.u) annotation (Line(points={{-64.6,20},{72,20},{72,0},{62,0}}, color={0,0,127}));
  connect(slewRateLimiter.u, P_max_star_limiter.y) annotation (Line(points={{-2,0},{39,0}}, color={0,0,127}));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                          experiment(StopTime=15),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Test environment for SlewRateLimiterStep</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
</html>"));
end TestSlewRateLimiterStep;
