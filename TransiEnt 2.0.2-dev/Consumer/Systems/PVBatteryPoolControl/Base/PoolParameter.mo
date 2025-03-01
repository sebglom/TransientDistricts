﻿within TransiEnt.Consumer.Systems.PVBatteryPoolControl.Base;
record PoolParameter "Enthlt die wichtigsten Simulations-Parameter"



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






  extends TransiEnt.Basics.Icons.Record;

  // ---- Pool Settings ---
  parameter Integer nSystems=1 "Number of systems in pool";

  // ---- Unit settings ---

  parameter Modelica.Units.SI.Power P_el_PV_peak=5e3 "PV peak power per household kW" annotation (Dialog(group="Household"));

  // ---- Balancing Power ---
  parameter Modelica.Units.SI.Power P_el_pbp_total=0 "Total primary balancing power offer of pool" annotation (Dialog(group="Primary Balancing Pool"));
  parameter Modelica.Units.SI.Time t_pbp_interval=300 "Communication intervall for PBP assignments per unit" annotation (Dialog(group="Primary Balancing Pool"));

  parameter Modelica.Units.SI.Power P_pbp_increment=0.2e3 "Increment of assigned PBP per unit" annotation (Dialog(group="Primary Balancing Pool"));

  // ---- Battery properties ---
  parameter Real SOC_start=0.5 "Start value of state of charge (SOC)" annotation (Dialog(group="Battery"));
  parameter Modelica.Units.SI.Power P_el_max_bat=1760 "Maximum power" annotation (Dialog(group="Battery"));
  parameter Modelica.Units.SI.Power P_el_min_bat=40 "Minimal power" annotation (Dialog(group="Battery"));

  parameter Modelica.Units.SI.Energy E_max_bat=5e3*3600 "Maximum capacity of battery system" annotation (Dialog(group="Battery"));
  parameter Real eta_max=0.7666 "Maximum cycle efficiency" annotation (Dialog(group="Battery"));
  parameter Real eta_min=0.5 "Minimum cycle efficiency" annotation (Dialog(group="Battery"));

  // ---- Battery management ---
  parameter Boolean useBatteryConditioning=true "False, no battery management (conditioning) active"
                                                                    annotation (Dialog(group="Battery Management"));

  parameter Modelica.Units.SI.Time t_conditioning=t_trading_intraday "Duration of conditioning operation" annotation (Dialog(group="Battery Management"));
  parameter Modelica.Units.SI.ActivePower P_el_cond=2000 "Power setpoint for battery conditioning" annotation (Dialog(group="Battery Management"));
  parameter Real SOC_min=0 "If SOC drops below this value, battery conditioning is started"
                                                                                 annotation (Dialog(group="Battery Management"));
  final parameter Real E_min_bat = SOC_min * E_max_bat;

  parameter Modelica.Units.SI.Time t_trading_intraday=900 "Time intervall of intraday trading" annotation (Dialog(group="Battery Management"));

  parameter Real SOC_cond=0.1 "SOC setpoint for conditioning" annotation (Dialog(group="Battery Management"));

     annotation (defaultComponentName="param", Icon(graphics,
                                                    coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                            Diagram(graphics,
                                                    coordinateSystem(extent={{-100,-100},{100,100}})));
end PoolParameter;
