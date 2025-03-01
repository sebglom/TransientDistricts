﻿within TransiEnt.Components.Mechanical;
model ConstantInertia "1D-rotational component with inertia"




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

  extends TransiEnt.Components.Mechanical.Base.PartialMechanicalConnection;

  // _____________________________________________
  //
  //                   Parameters
  // _____________________________________________

  SI.AngularAcceleration alpha(start=0) "Absolute angular acceleration of component (= der(omega))"
    annotation (Dialog(group="Initialization", showStartAttribute=true));

  SI.Power P_rot=omega*alpha*J "Power from changes in rotational energy";

  // _____________________________________________
  //
  //                Complex Components
  // _____________________________________________

  outer TransiEnt.ModelStatistics modelStatistics;

equation
  // _____________________________________________
  //
  //               Characteristic Equations
  // _____________________________________________

  alpha = der(omega);
  J*alpha = mpp_a.tau + mpp_b.tau;
  E_kin=J*omega^2/2;

  annotation (
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Ideal rigid mechanical shaft that can be used for simulation of grid inertia. </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">2. Level of detail, physical effects considered, and physical insight</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model contains moment of inertia statistics. Since the shaft is always connected it constantly sends the moment of inertia specified by parameter J to the statistics component.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p>mpp_a: mechanical power port</p>
<p>mpp_b: mechanical power port</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no elements)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no equations)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarks for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p>Tested in check model &quot;CheckInertiaConstant&quot;</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de) on 01.10.2014</span></p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-100,10},{-50,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{50,10},{100,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-80,-25},{-60,-25}}, color={0,0,0}),
        Line(points={{60,-25},{80,-25}}, color={0,0,0}),
        Line(points={{-70,-25},{-70,-70}}, color={0,0,0}),
        Line(points={{70,-25},{70,-70}}, color={0,0,0}),
        Line(points={{-80,25},{-60,25}}, color={0,0,0}),
        Line(points={{60,25},{80,25}}, color={0,0,0}),
        Line(points={{-70,45},{-70,25}}, color={0,0,0}),
        Line(points={{70,45},{70,25}}, color={0,0,0}),
        Line(points={{-70,-70},{70,-70}}, color={0,0,0}),
        Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Text(
          extent={{-151,-130},{149,-170}},
          lineColor={0,0,0},
          textString="J=%J")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics));
end ConstantInertia;
