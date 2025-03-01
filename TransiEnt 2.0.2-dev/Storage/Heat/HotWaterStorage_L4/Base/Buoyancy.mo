﻿within TransiEnt.Storage.Heat.HotWaterStorage_L4.Base;
model Buoyancy "Model to add buoyancy if there is a temperature inversion in the tank"



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





  // Model is bases on the model "Bouyncy in the "Buildings-library"
  // A few changes according to the parameters rho_default and cp_default are made

// _____________________________________________________________________________
//
//          Imports and Class Hierarchy
// _____________________________________________________________________________

  outer ClaRa.SimCenter  simCenter;

  parameter TILMedia.VLEFluidTypes.BaseVLEFluid   medium=simCenter.fluid1 "Medium in the component"
                               annotation(Dialog(group="Fundamental Definitions"), choicesAllMatching);

//______________________________________________________________________________
//                         Parameter
//______________________________________________________________________________
  parameter Modelica.Units.SI.Volume V "Volume of tank";
  parameter Integer nSeg(min=2) = 2 "Number of volume segments";
  parameter Modelica.Units.SI.Time tau(min=0) "Time constant for mixing";
  parameter Modelica.Units.SI.Density rho_default=998 "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=4200 "Specific heat capacity";
  //outer parameter Modelica.SIunits.SpecificHeatCapacity cp_default= Medium.cp

//______________________________________________________________________________
//                   Componenents / submodels
//______________________________________________________________________________

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSeg] heatPort "Heat input into the volumes" annotation (Placement(transformation(extent={{80,-4},{100,16}}), iconTransformation(extent={{80,-4},{100,16}})));

  Modelica.Units.SI.HeatFlowRate[nSeg - 1] Q_flow "Heat flow rate from segment i+1 to i";

   /*
   parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(T=Medium.T_default,
         p=Medium.p_default, X=Medium.X_default[1:Medium.nXi]);
   parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default) 
    "Density, used to compute fluid mass";
   parameter Modelica.SIunits.SpecificHeatCapacity cp_default=Medium.specificHeatCapacityCp(sta_default) 
   "Specific heat capacity";
   */

protected
   parameter Real k(unit="W/K") = V*rho_default*cp_default/tau/nSeg "Proportionality constant, since we use dT instead of dH";

  Modelica.Units.SI.TemperatureDifference dT[nSeg - 1] "Temperature difference between adjoining volumes";

equation
  for i in 1:nSeg-1 loop
    dT[i] = heatPort[i+1].T-heatPort[i].T;
    Q_flow[i] = k*smooth(1,noEvent(if dT[i]>0 then dT[i]^2 else 0));
  end for;

  heatPort[1].Q_flow = -Q_flow[1];
  for i in 2:nSeg-1 loop
       heatPort[i].Q_flow = -Q_flow[i]+Q_flow[i-1];
  end for;
  heatPort[nSeg].Q_flow = Q_flow[nSeg-1];

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Adds Buoyancy to a stratified storage.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>Convective energy flow is considered as heat flow of the same amount.</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>Purely technical component without physical modeling.</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>heatPort[nseg]: Gets the temperatures from the temperature layers and returns the heat flow due to boyancy back</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>The input parameters</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>This model should be used to add buoyancy to a one dimensional water storage model.</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>Building Library</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model created by Tobias Ramm (tobias.ramm@tuhh.de) on Fri Mar 20 2015</p>
<p>Revised and edited by Lisa Andresen (andresen@tuhh.de), Jun 2015</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,68},{36,28}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-26},{38,-66}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,10},{32,-20}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{29,22},{22,10},{36,10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,22},{-26,-8}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-29,-20},{-36,-8},{-22,-8}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics));
end Buoyancy;
