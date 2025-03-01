﻿within TransiEnt.Producer.Gas.Electrolyzer.Base.Physics;
package Temperature "Contains Temperature base class and specific model implementations"




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







 extends TransiEnt.Basics.Icons.Package;

  annotation (Icon(graphics={
        Text(
          extent={{-150,-105},{150,-145}},
          lineColor={0,134,134},
          textString="%name"),
        Ellipse(
          extent={{-36,-100},{36,-32}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-22,-64},{-22,82},{-18,90},{-12,94},{-2,96},{8,94},{16,90},{20,82},{22,-66},{-22,-64}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-42,-24},{4,-24}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-22,-18},{4,-18},{4,22}},
          color={0,0,0},
          pattern=LinePattern.None),
        Rectangle(
          extent={{2,-24},{-22,-22}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,0},{-22,2}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,22},{-22,24}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,42},{-22,44}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,62},{-22,64}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end Temperature;
