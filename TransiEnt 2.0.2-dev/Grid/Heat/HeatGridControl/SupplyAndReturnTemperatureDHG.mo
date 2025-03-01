﻿within TransiEnt.Grid.Heat.HeatGridControl;
model SupplyAndReturnTemperatureDHG "Table with supply and return temperatures according to technical connection conditions"




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

//   extends TransiEnt.Basics.Tables.GenericCombiTable1Ds(columns={2,3},
//       relativepath="heat/HeatingCurve_DHN_Vattenfall_Hamburg.txt");

  parameter TransiEnt.Grid.Heat.HeatGridControl.Base.T_set_DHG.Generic_T_set_DHG T_set_DHG=Base.T_set_DHG.Sample_T_set_DHG() annotation (choicesAllMatching);
  parameter Modelica.Units.NonSI.Temperature_degC T_supply_max_scale=max(T_set_DHG.T_set_DHG[:, 2]);
  parameter Modelica.Units.NonSI.Temperature_degC T_return_min_scale=max(T_set_DHG.T_set_DHG[:, 3]);
  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  TransiEnt.Basics.Interfaces.General.TemperatureOut T_supply_K annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
  TransiEnt.Basics.Interfaces.General.TemperatureOut T_return_K annotation (Placement(transformation(extent={{100,-78},{120,-58}})));

  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=T_set_DHG.T_set_DHG, columns={2,3}) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TransiEnt.Basics.Interfaces.General.TemperatureCelsiusIn T_amb annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  TransiEnt.Basics.Interfaces.General.TemperatureCelsiusOut T_set[size(combiTable1Ds.columns, 1)] annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain(k=T_supply_max_scale/max(T_set_DHG.T_set_DHG[:, 2])) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Math.Gain gain1(k=T_return_min_scale/max(T_set_DHG.T_set_DHG[:, 3])) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
equation
  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________

  T_supply_K=gain.y+273.15;
  T_return_K=gain1.y+273.15;
  connect(T_amb, combiTable1Ds.u) annotation (Line(points={{-120,0},{-66,0},{-12,0}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], gain.u) annotation (Line(points={{11,0},{24,0},{24,30},{38,30}}, color={0,0,127}));
  connect(combiTable1Ds.y[2], gain1.u) annotation (Line(points={{11,0},{24,0},{24,-30},{38,-30}}, color={0,0,127}));
  connect(gain.y, T_set[1]) annotation (Line(points={{61,30},{72,30},{72,0},{110,0}}, color={0,0,127}));
  connect(gain1.y, T_set[2]) annotation (Line(points={{61,-30},{72,-30},{72,0},{110,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-70,-16},{-24,-16}},
          color={255,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-24,-16},{28,74},{56,88},{80,92}},
          color={255,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-70,-64},{-14,-64},{20,-54},{82,-48}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Polygon(
          points={{-70,90},{-78,68},{-62,68},{-70,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-70,68},{-70,-80}}, color={192,192,192}),
        Line(points={{-80,-70},{92,-70}}, color={192,192,192}),
        Polygon(
          points={{100,-70},{78,-62},{78,-78},{100,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Provides a practical interface to input the expected supply and return temperatures as a function of the ambient temperature.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely tabular component without physical modeling)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely tabular component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>Real Input:</p>
<ul>
<li>T_amb: Ambient Temperature in &deg;C</li>
</ul>
<p>Real Output:</p>
<ul>
<li>T_set[1]: Supply Temperature in &deg;C</li>
<li>T_set[2]: Return Temperature in &deg;C</li>
</ul>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>This component was created using the combiTable 1Ds of the MSL. For further information regarding its usage refer to that component.</p>
<p>Create a record with the following structure:</p>
<p><br>T_amb[1] T_set[1] T_set[2]</p>
<p>Ambient Temperature Supply Temp. Return Temp.</p>
<p>xx</p>
<p>xx</p>
<p>xx</p>
<p><br>In the parameter &quot;columns&quot; write {2, 3} (meaning that the 2nd and third columns will be used and assigned to the outputs y[1] and y[2]</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>(no remarks)</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end SupplyAndReturnTemperatureDHG;
