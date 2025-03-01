﻿within TransiEnt.Components.Statistics.Collectors.GlobalCollectors;
model EconomicStatistics



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





//Variables
  TransiEnt.Basics.Units.MonetaryUnit TotalSystemCosts "Total system costs";
  TransiEnt.Basics.Units.MonetaryUnit TotalInvestCosts "Total invest-related costs";
  TransiEnt.Basics.Units.MonetaryUnit TotalDemandCosts "Total demand-related costs";
  TransiEnt.Basics.Units.MonetaryUnit TotalOMCosts "Total operation-related costs incl. maintenance";
  TransiEnt.Basics.Units.MonetaryUnit TotalOtherCosts "Total other costs";
  TransiEnt.Basics.Units.MonetaryUnit TotalRevenues "Total revenues";

  outer TransiEnt.SimCenter simCenter;

//Interfaces
  Modelica.Blocks.Interfaces.RealInput costsCollector[6] annotation (HideResult=True, Placement(transformation(extent={{-10,-94},{10,-74}}), iconTransformation(extent={{-17,-16},{17,16}},
        rotation=90,
        origin={-1,-88})));

//Equations
equation
  TotalSystemCosts=-1*costsCollector[1];
  TotalInvestCosts=-1*costsCollector[2];
  TotalDemandCosts=-1*costsCollector[3];
  TotalOMCosts=-1*costsCollector[4];
  TotalOtherCosts=-1*costsCollector[5];
  TotalRevenues=-1*costsCollector[6];

  //Annotations
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={
                           Rectangle(extent={{-100,100},{100,-100}}, lineColor={127,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,78},{30,14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{-18,49},{-28,39}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{-4,67},{-14,57}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{14,67},{4,57}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{24,49},{14,39}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{2,51},{-8,41}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{10,27},{0,37}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),               Ellipse(
          extent={{-6,31},{-16,21}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-7,19},{-7,-5},{-23,-5},{3,-33},{27,-5},{11,-5},{11,19},{1,19},
              {-7,19}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          origin={1,-39},
          rotation=180),
        Text(
          extent={{-144,140},{138,96}},
          lineColor={0,0,0},
          textString="%name")}),
                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end EconomicStatistics;
