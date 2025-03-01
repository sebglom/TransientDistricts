﻿within TransiEnt.Basics.Tables;
model GenericDataTable "Parameterized version of MSL's CombiTimeTable. See Examples.Basics.GenericTable_How_to for explanation"




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
  //                   Parameters
  // _____________________________________________

  parameter String tableName="default" "Table name on file or in function usertab (see docu)"
                                                           annotation(Evaluate=true, HideResult=true, Dialog(group="Basics"));

  parameter Boolean multiple_outputs = false "If set true multiple outputs are enabled (but useage of MultiSum block will fail)"
                                                                                              annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Basics"));

  parameter Integer columns[:]=2:size(MSL_combiTimeTable.table, 2) "columns of table to be interpolated (*** has to be modified before usage! ***)"
                                                                                        annotation(Evaluate=true, HideResult=true, Dialog(enable=multiple_outputs, group="Basics"));

  parameter DataPrivacy datasource=DataPrivacy.isPublic "Source of table data"   annotation (
    Evaluate=true,
    HideResult=true,
    Dialog(enable=not use_absolute_path, group="Data location"));

  final parameter String environment_variable_name=if datasource ==DataPrivacy.isPublic then Types.PUBLIC_DATA else Types.PRIVATE_DATA  annotation(Evaluate=true, HideResult=true, Dialog(enable=not use_absolute_path, group="Data location"));

  parameter String relativepath = "" "Path relative to source directory"
                                                                        annotation(Evaluate=true, HideResult=true, Dialog(enable=not use_absolute_path, group="Data location"));

  parameter Boolean use_absolute_path = false "Should only be used for testing purposes" annotation (Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true), Dialog(group="Data location"));
  parameter String absolute_path = ""
  annotation(Evaluate=true, HideResult=true, Dialog(enable=use_absolute_path, group="Data location"));

  parameter Boolean change_of_sign = false "Change sign of output signal relative to table data"
        annotation(choices(__Dymola_checkBox=true), Dialog(group="Basics"));
  parameter Real constantfactor = 1.0 "Multiply output with constant factor"
        annotation(Dialog(tab="Advanced", group="table data interpretation"));
  parameter Modelica.Blocks.Types.Smoothness smoothness=simCenter.tableInterpolationSmoothness "Smoothness of table interpolation"
      annotation(Dialog(tab="Advanced", group="table data interpretation"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints "Extrapolation of data outside the definition range"
        annotation(Dialog(tab="Advanced", group="table data interpretation"));
  parameter Real offset[:]={0} "Offsets of output signals"
        annotation(Dialog(tab="Advanced", group="table data interpretation"));
  parameter SI.Time startTime=0       annotation(Dialog(tab="Advanced", group="table data interpretation"));

  parameter Modelica.Units.SI.Time shiftTime=startTime "Shift time of first table column" annotation (Dialog(group="Table data interpretation"));

  parameter Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.AtDiscontinuities
    "Time event handling of table interpolation"
    annotation (Dialog(group="Table data interpretation", enable=smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments));

  final parameter String complete_relative_path = Functions.fullPathName(               Modelica.Utilities.System.getEnvironmentVariable(environment_variable_name) + relativepath);

  final parameter String genericFileName = if use_absolute_path then absolute_path else complete_relative_path;

  outer TransiEnt.SimCenter simCenter;

  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

 Modelica.Blocks.Interfaces.RealOutput y[MSL_combiTimeTable.nout] if  multiple_outputs
    annotation (Placement(transformation(
          extent={{100,-10},{120,10}}),
                                      iconTransformation(extent={{100,-10},{120,
            10}})));

  Modelica.Blocks.Interfaces.RealOutput y1 if not multiple_outputs  annotation (Placement(transformation(
          extent={{100,-10},{120,10}}),
                                      iconTransformation(extent={{100,-10},{120,
            10}})));

  // _____________________________________________
  //
  //                Complex Components
  // _____________________________________________

   Modelica.Blocks.Sources.CombiTimeTable MSL_combiTimeTable(
    tableOnFile=true,
    fileName=genericFileName,
    smoothness=smoothness,
    extrapolation=extrapolation,
    columns=columns,
    offset=offset,
    startTime=startTime,
    tableName=tableName,
    shiftTime=shiftTime,
    timeEvents=timeEvents)
    annotation (Placement(transformation(extent={{-90,-52},{14,52}})));
  Modelica.Blocks.Math.Gain sign_changer[MSL_combiTimeTable.nout](each k=if change_of_sign then -1*constantfactor else constantfactor)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

equation
  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(MSL_combiTimeTable.y,sign_changer. u) annotation (Line(
      points={{19.2,0},{38,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sign_changer.y, y) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(y1, sign_changer[1].y) annotation (Line(
      points={{110,0},{61,0}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
        Polygon(
          points={{-80,80},{-88,58},{-72,58},{-80,80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,58},{-80,-90}}, color={192,192,192}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,60},{2,-60}},
          lineColor={255,255,255},
          fillColor={0,134,134},
          fillPattern=FillPattern.Solid),
        Line(points={{-48,-60},{-48,60},{52,60},{52,-60},{-48,-60},{-48,-30},{52,
              -30},{52,0},{-48,0},{-48,30},{52,30},{52,60},{2,60},{2,-61}},
            color={0,0,0})}),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Generates an output from any data table.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Description)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>Modelica RealOutput: y[MSL_combiTimeTable.nout]</p>
<p>Modelica RealOutput: y1</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>MSL_combiTimetable from MSL is used. Standard setting for timeEvents is changed from &apos;Always&apos; to &apos;AtDiscontinuities&apos; to avoid unnecessary events.</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(none)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model modified by Oliver Sch&uuml;lting (oliver.schuelting@tuhh.de) on Feb 2020: changed standard MSL-setting for timeEvents</p>
</html>"));
end GenericDataTable;
