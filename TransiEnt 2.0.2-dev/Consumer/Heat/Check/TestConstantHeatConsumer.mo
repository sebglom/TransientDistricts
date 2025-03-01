﻿within TransiEnt.Consumer.Heat.Check;
model TestConstantHeatConsumer




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

  extends TransiEnt.Basics.Icons.Checkmodel;

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  inner TransiEnt.SimCenter simCenter(
    useHomotopy=false,
    redeclare replaceable TILMedia.VLEFluidTypes.TILMedia_Water fluid1,
    useClaRaDelay=true) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_hxim_flow districtHeatingSupply(
    m_flow_const=0.1,
    m_flow_nom=0,
    p_nom=1000,
    variable_m_flow=false,
    variable_h=false,
    h_const=400e3) annotation (Placement(transformation(extent={{94,16},{42,62}})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_phxi districtHeatingReturn(
    m_flow_nom=100,
    p_const=1000000,
    Delta_p=100000,
    variable_p=false,
    h_const=400e3) annotation (Placement(transformation(
        extent={{-16,-21},{16,21}},
        rotation=180,
        origin={72,-41})));
  ConstantHeatConsumer constantHeatConsumer(Q_flow_const=1000)
    annotation (Placement(transformation(extent={{-60,-28},{6,34}})));

  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(constantHeatConsumer.fluidPortIn, districtHeatingSupply.steam_a)
    annotation (Line(
      points={{6,-9.4},{30,-9.4},{30,38},{42,38},{42,39}},
      color={175,0,0},
      smooth=Smooth.None));
  connect(constantHeatConsumer.fluidPortOut, districtHeatingReturn.steam_a)
    annotation (Line(
      points={{6,-21.8},{30,-21.8},{30,-41},{56,-41}},
      color={175,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
            {100,80}}),      graphics), Icon(graphics,
                                             coordinateSystem(extent={{-80,-80},
            {100,80}})),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p>Test environment for a constant heat consumer </p>
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
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de) on 01.10.2014</span></p>
</html>"));
end TestConstantHeatConsumer;
