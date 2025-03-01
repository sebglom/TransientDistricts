﻿within TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler;
model ElectricBoiler "Electric Boiler with constant efficiency, spatial resolution can be chosen to be 0d or 1d"




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
  extends TransiEnt.Basics.Icons.Model;

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  outer TransiEnt.SimCenter simCenter;
  outer TransiEnt.ModelStatistics modelStatistics;
  // _____________________________________________
  //
  //                Parameters
  // _____________________________________________

  parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium=simCenter.fluid1 "Medium to be used" annotation(choicesAllMatching, Dialog(group="Fundamental Definitions"));

  parameter Boolean change_sign=false "If false, setpoint value needs to be negative" annotation (Dialog(group="Fundamental Definitions"),
                                                                                                                                 choices(checkBox=true));


  parameter Boolean usePelset=false "If true, P_el_set is used, if false, Q_flow_set is used" annotation(choices(checkBox=true), Dialog(group="Fundamental Definitions"));
  final parameter Modelica.Units.SI.Power P_el_n=Q_flow_n/eta "Nominal electric power";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_n=100e3 "Nominal thermal power" annotation (Dialog(group="Technical Specification"));
  parameter Modelica.Units.SI.Efficiency eta=0.95 annotation (Dialog(group="Technical Specification"));
  parameter Boolean useFluidPorts=true annotation(choices(checkBox=true),Dialog(group="Fundamental Definitions"));
  parameter Boolean usePowerPort=false  annotation(choices(checkBox=true),Dialog(group="Fundamental Definitions"));
  parameter Boolean useHeatPort=false annotation(choices(checkBox=true),Dialog(group="Fundamental Definitions", enable=not useFluidPorts));
  replaceable model ProducerCosts =
      TransiEnt.Components.Statistics.ConfigurationData.PowerProducerCostSpecs.P2H
    constrainedby TransiEnt.Components.Statistics.ConfigurationData.PowerProducerCostSpecs.PartialPowerPlantCostSpecs annotation (Dialog(group="Statistics"), __Dymola_choicesAllMatching=true);

  // _____________________________________________
  //
  //                Interfaces
  // _____________________________________________

  replaceable connector PowerPortModel = Basics.Interfaces.Electrical.ActivePowerPort  constrainedby Basics.Interfaces.Electrical.ActivePowerPort  "Choice of power port" annotation (
    choicesAllMatching=true,
    Dialog(group="Replaceable Components"));

   PowerPortModel epp if usePowerPort annotation (
    Placement(transformation(extent={{-10,88},{10,108}}), iconTransformation(extent={{-10,-112},{10,-92}})));

  TransiEnt.Basics.Interfaces.Thermal.FluidPortIn fluidPortIn(Medium=medium) if
                                                                          useFluidPorts annotation (Placement(transformation(extent={{90,-50},{110,-30}}), iconTransformation(extent={{-114,-10},{-94,10}})));
  TransiEnt.Basics.Interfaces.Thermal.FluidPortOut fluidPortOut(Medium=medium) if
                                                                            useFluidPorts annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{92,-10},{112,10}})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateIn Q_flow_set if not usePelset "Setpoint for thermal heat, should be negative" annotation (Placement(transformation(extent={{-114,0},{-94,20}})));

  Basics.Interfaces.Electrical.ElectricPowerIn P_el_set if usePelset "Setpoint for electric power, should be negative" annotation (Placement(transformation(extent={{-106,-34},{-86,-14}}), iconTransformation(extent={{-106,-34},{-86,-14}})));

  Basics.Interfaces.Thermal.HeatFlowRateOut Q_flow_gen annotation (Placement(transformation(extent={{96,72},{116,92}}), iconTransformation(extent={{96,72},{116,92}})));

  // _____________________________________________
  //
  //                Complex Components
  // _____________________________________________

public
  replaceable model PowerBoundaryModel = TransiEnt.Components.Boundaries.Electrical.ActivePower.Power constrainedby TransiEnt.Components.Boundaries.Electrical.Base.PartialModelPowerBoundary  "Choice of power boundary model. The power boundary model must match the power port."     annotation (
    choicesAllMatching=true,
    Dialog(group="Replaceable Components"));

  PowerBoundaryModel powerBoundary if usePowerPort "Choice of power boundary model. The power boundary model must match the power port."     annotation (
    Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,30})));


  replaceable TransiEnt.Components.Boundaries.Heat.Heatflow_L1 heatFlowBoundary(change_sign=true) if useFluidPorts constrainedby TransiEnt.Components.Boundaries.Heat.Base.PartialHeatBoundary "Choice of heat boundary model" annotation (Dialog(group="Replaceable Components"),choicesAllMatching=true, Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={54,6})));

  Modelica.Blocks.Math.Gain efficiency(k=1/eta) if not usePelset annotation (Placement(transformation(extent={{-28,56},{-10,74}})));
  Modelica.Blocks.Math.Gain sign(k=if heatFlowBoundary.change_sign == true then 1 else -1) if useFluidPorts annotation (Placement(transformation(extent={{18,-9},{36,9}})));
  ClaRa.Components.Sensors.SensorVLE_L1_T temperatureSensor_hex_coolant_in(medium=medium) if useFluidPorts annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={68,-43})));
  ClaRa.Components.Sensors.SensorVLE_L1_T temperatureSensor_hex_coolant_out(medium=medium) if useFluidPorts annotation (Placement(transformation(extent={{73,39},{59,53}})));
  Modelica.Blocks.Nonlinear.Limiter Q_flow_set_limit(uMax=Q_flow_n, uMin=0) if not usePelset annotation (Placement(transformation(extent={{-56,0},{-36,20}})));

  Modelica.Units.SI.HeatFlowRate Q_flow_is=Q_flow_gen;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if useHeatPort annotation (Placement(transformation(extent={{52,-80},{72,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat if useHeatPort annotation (Placement(transformation(extent={{94,28},{114,48}}),  iconTransformation(extent={{94,28},{114,48}})));

  Modelica.Blocks.Nonlinear.Limiter P_el_set_limit(uMax=P_el_n, uMin=0) if
                                                                         usePelset annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
  Modelica.Blocks.Math.Gain signQ(k=if change_sign then 1 else -1) if not usePelset  annotation (Placement(transformation(extent={{-82,1},{-64,19}})));
  Modelica.Blocks.Math.Gain signP(k=if change_sign then 1 else -1) if usePelset  annotation (Placement(transformation(extent={{-84,-41},{-66,-23}})));
  Modelica.Blocks.Math.Gain efficiency1(k=eta) if   usePelset annotation (Placement(transformation(extent={{-20,-80},{-2,-62}})));

  TransiEnt.Components.Statistics.Collectors.LocalCollectors.HeatingPlantCost collectCosts_HeatProducer(
    redeclare model HeatingPlantCostModel = ProducerCosts,
    Q_flow_fuel_is=0,
    m_flow_CDE_is=0,
    Q_flow_n=Q_flow_n,
    Q_flow_is=-Q_flow_is,
    consumes_H_flow=false,
    produces_m_flow_CDE=false) annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.CollectHeatingPower collectHeatingPower(typeOfResource=TransiEnt.Basics.Types.TypeOfResource.Conventional) annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));


protected
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.CollectElectricPower collectElectricPower(typeOfResource=TransiEnt.Basics.Types.TypeOfResource.Consumer)
                                                                                                                                      annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________




  Basics.Interfaces.Electrical.ElectricPowerOut
                                            P_el_gen annotation (Placement(transformation(extent={{96,50},{116,70}})));
equation


  collectElectricPower.powerCollector.P=P_el_gen;
  collectHeatingPower.heatFlowCollector.Q_flow = -Q_flow_is;

  // _____________________________________________
  //
  //                Connect Equations
  // _____________________________________________

  connect(modelStatistics.powerCollector[collectElectricPower.typeOfResource],collectElectricPower.powerCollector);
  connect(modelStatistics.heatFlowCollector[collectHeatingPower.typeOfResource],collectHeatingPower.heatFlowCollector);
  connect(modelStatistics.costsCollector, collectCosts_HeatProducer.costsCollector);

  if useFluidPorts then
    connect(fluidPortIn, heatFlowBoundary.fluidPortIn) annotation (Line(points={{100,-40},{78,-40},{78,-8.88178e-16},{64,-8.88178e-16}},
                                                                                                                   color={175,0,0}));
    connect(heatFlowBoundary.fluidPortOut, fluidPortOut) annotation (Line(points={{64,12},{78,12},{78,40},{100,40}},                 color={175,0,0}));
    connect(sign.y, heatFlowBoundary.Q_flow_prescribed) annotation (Line(
      points={{36.9,0},{46,2.22045e-16}},
      color={0,0,127}));
    connect(heatFlowBoundary.fluidPortOut, temperatureSensor_hex_coolant_out.port)
      annotation (Line(
        points={{64,12},{78,12},{78,34},{66,34},{66,39}},
        color={175,0,0},
        thickness=0.5));
    connect(heatFlowBoundary.fluidPortIn, temperatureSensor_hex_coolant_in.port)
      annotation (Line(
        points={{64,-8.88178e-16},{78,-8.88178e-16},{78,-28},{68,-28},{68,-36}},
        color={175,0,0},
        thickness=0.5));
    connect(Q_flow_set_limit.y, sign.u) annotation (Line(points={{-35,10},{10,10},{10,0},{16.2,0}},
                                                                                     color={0,0,127}));
  else
    connect(prescribedHeatFlow.port, heat) annotation (Line(points={{72,-70},{86,-70},{86,38},{104,38}},
                                                                                                       color={191,0,0}));
  end if;
  if usePowerPort then
    connect(powerBoundary.epp, epp) annotation (Line(
      points={{0,30},{0,98}},
      color={0,0,0}));
    connect(efficiency.y, powerBoundary.P_el_set) annotation (Line(
      points={{-9.1,65},{-4,65},{-4,42}},
      color={0,0,127}));
  end if;
  connect(Q_flow_set_limit.y, efficiency.u) annotation (Line(points={{-35,10},{-32,10},{-32,65},{-29.8,65}},        color={0,0,127}));

  connect(Q_flow_set,signQ. u) annotation (Line(
      points={{-104,10},{-83.8,10}},
      color={175,0,0},
      pattern=LinePattern.Dash));
  connect(Q_flow_set_limit.u,signQ. y) annotation (Line(points={{-58,10},{-63.1,10}}, color={0,0,127}));
  connect(Q_flow_set_limit.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-35,10},{10,10},{10,-70},{52,-70}}, color={0,0,127}));
  connect(signP.u, P_el_set) annotation (Line(points={{-85.8,-32},{-92,-32},{-92,-24},{-96,-24}},
                                                                               color={0,0,127}));
  connect(P_el_set_limit.u, signP.y) annotation (Line(points={{-60,-32},{-65.1,-32}}, color={0,0,127}));
  connect(P_el_set_limit.y, powerBoundary.P_el_set) annotation (Line(points={{-37,-32},{-26,-32},{-26,48},{-4,48},{-4,42}}, color={0,0,127}));
  connect(P_el_set_limit.y, efficiency1.u) annotation (Line(points={{-37,-32},{-26,-32},{-26,-71},{-21.8,-71}}, color={0,0,127}));
  connect(efficiency1.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-1.1,-71},{10,-71},{10,-70},{52,-70}},
                                                                                                              color={0,0,127}));
  connect(efficiency1.y, sign.u) annotation (Line(points={{-1.1,-71},{10,-71},{10,0},{16.2,0}}, color={0,0,127}));
  connect(Q_flow_set_limit.y, Q_flow_gen) annotation (Line(points={{-35,10},{10,10},{10,82},{106,82}}, color={0,0,127}));
  connect(efficiency1.y, Q_flow_gen) annotation (Line(points={{-1.1,-71},{10,-71},{10,82},{106,82}}, color={0,0,127}));
  connect(P_el_set_limit.y, P_el_gen) annotation (Line(points={{-37,-32},{-26,-32},{-26,48},{40,48},{40,60},{106,60}}, color={0,0,127}));
  connect(efficiency.y, P_el_gen) annotation (Line(points={{-9.1,65},{-4,65},{-4,48},{40,48},{40,60},{106,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-42,-50},{40,-92}},
          lineColor={0,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-42,52},{40,-74}},
          lineColor={0,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-42,74},{40,32}},
          lineColor={0,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Line(
          points={{0,-48},{0,-102}},
          color={0,134,134},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{0,0},{20,-8},{-18,-22},{18,-36},{0,-40},{0,-50}},
          thickness=0.5,
          smooth=Smooth.None,
          color={0,134,134})}),   Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model of an electrode boiler using TransiEnt interfaces and TransiEnt.Statistics. Heat transfer is ideal, thermal losses are modeled using a constant efficiency. Heat port or fluid ports are choosable.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">2. Level of detail, physical effects considered, and physical insight</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">epp: electric power port</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">fluidPortIn: fluid inlet (if selected)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">fluidPortOut: fluid outlet (if selected)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">heat: heat port (if selected)</span></p>
<p>Q_flow_set: set value for heat flow rate (if selected)</p>
<p>P_el_set: set value for electric power (if selected)</p>
<p>Q_flow_gen: generated heat</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no elements)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no equations)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarsk for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de) in October 2014</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model generalized for different electrical power ports by Jan-Peter Heckel (jan.heckel@tuhh.de) in July 2018 </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model modified (added selectable heat port) by Carsten Bode (c.bode@tuhh.de), Nov 2018</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model modified by Anne Hagemeier (anne.hagemeier@umsicht.fraunhofer.de) in July 2021 (added change_sign and option to deselect both fluid and heat ports)</span></p>
</html>"));
end ElectricBoiler;
