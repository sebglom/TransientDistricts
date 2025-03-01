﻿within TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler.Check;
model TestPtH_limiter "\"Test model for the component: PtH_limiter\""
  import TransiEnt;



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
  TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler.Controller.PtH_limiter ptH_limiter(Q_flow_PtH_max=PtH.Q_flow_n) annotation (Placement(transformation(extent={{-10,16},{10,36}})));
  TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler.ElectricBoiler PtH(Q_flow_n=5e6, usePowerPort=true) annotation (Placement(transformation(extent={{-13,-44},{7,-24}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{3.5,-3.5},{-3.5,3.5}},
        rotation=90,
        origin={0.5,-6.5})));
  TransiEnt.Components.Boundaries.FluidFlow.BoundaryVLE_phxi massflowSink(boundaryConditions(p_const(displayUnit="bar") = 100000)) annotation (Placement(transformation(extent={{50,-44},{30,-24}})));
  TransiEnt.Components.Visualization.Quadruple quadruple1 annotation (Placement(transformation(extent={{26,-70},{46,-60}})));
  TransiEnt.Components.Boundaries.FluidFlow.BoundaryVLE_Txim_flow massflow_Tm_flow(variable_m_flow=true, variable_T=true) annotation (Placement(transformation(extent={{-52,-44},{-32,-24}})));
  Modelica.Blocks.Sources.RealExpression P_RE_Exceed(y=10e6*sin(time/86400))                      annotation (Placement(transformation(extent={{-88,19},{-62,33}})));
  Modelica.Blocks.Sources.RealExpression heatDemand(y=180e6) annotation (Placement(transformation(extent={{-60,55},{-34,69}})));
  Modelica.Blocks.Sources.RealExpression Temperature(y=45 + 273.15) annotation (Placement(transformation(extent={{-94,-45},{-68,-31}})));
  Modelica.Blocks.Sources.RealExpression massFlow(y=1000) annotation (Placement(transformation(extent={{-94,-31},{-68,-17}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{2,-70},{22,-50}})));
  inner TransiEnt.SimCenter simCenter annotation (Placement(transformation(extent={{70,80},{90,100}})));
equation
  connect(ptH_limiter.Q_flow_set_PtH, gain.u) annotation (Line(
      points={{0,15},{0,-2.3},{0.5,-2.3}},
      color={162,29,33},
      pattern=LinePattern.Dash));
  connect(ptH_limiter.P_RE_curtail, P_RE_Exceed.y) annotation (Line(
      points={{-11,26},{-60.7,26}},
      color={0,135,135},
      thickness=0.5));
  connect(ptH_limiter.Q_flow_set_demand, heatDemand.y) annotation (Line(
      points={{0,38},{0,38},{0,62},{-32.7,62}},
      color={162,29,33},
      pattern=LinePattern.Dash));
  connect(massFlow.y, massflow_Tm_flow.m_flow) annotation (Line(points={{-66.7,-24},{-66,-24},{-66,-28},{-54,-28}}, color={0,0,127}));
  connect(Temperature.y, massflow_Tm_flow.T) annotation (Line(points={{-66.7,-38},{-66,-38},{-66,-34},{-54,-34}}, color={0,0,127}));
  connect(massflowSink.eye, quadruple1.eye) annotation (Line(points={{30,-42},{26,-42},{22,-42},{22,-65},{26,-65}}, color={190,190,190}));
  connect(massflow_Tm_flow.fluidPortOut, PtH.fluidPortIn) annotation (Line(
      points={{-32,-34},{-12.8,-34},{-12.8,-34}},
      color={175,0,0},
      thickness=0.5));
  connect(PtH.fluidPortOut, massflowSink.fluidPortIn) annotation (Line(
      points={{7,-34},{30,-34},{30,-34}},
      color={175,0,0},
      thickness=0.5));
  connect(PtH.Q_flow_set, gain.y) annotation (Line(points={{-3,-24},{-3,-16},{0.5,-16},{0.5,-10.35}}, color={0,0,127}));
  connect(ElectricGrid.epp, PtH.epp) annotation (Line(
      points={{2,-60},{-3,-60},{-3,-44}},
      color={0,135,135},
      thickness=0.5));
  annotation (experiment(StopTime=864000, Interval=60), Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Test environment for PtH_limiter</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4.Interfaces</span></h4>
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
end TestPtH_limiter;
