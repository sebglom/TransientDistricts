﻿within TransiEnt.Producer.Heat.Gas2Heat.SmallGasBoiler.Check;
model TestBoiler_HoldTemperature_L1



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

  inner TransiEnt.SimCenter simCenter(
    redeclare TransiEnt.Basics.Media.Gases.Gas_VDIWA_NG7_H2_var gasModel2,
    redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_NG7_H2_var gasModel1,
    redeclare TransiEnt.Basics.Tables.HeatGrid.HeatingCurves.HeatingCurveEONHanse heatingCurve)
    annotation (Placement(transformation(extent={{-110,80},{-90,100}})));

  ClaRa.Components.BoundaryConditions.BoundaryVLE_Txim_flow waterSource(
    T_const=273.15 + 50,
    variable_T=false,
    m_flow_const=10,
    variable_m_flow=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-60})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_pTxi waterSink(p_const=simCenter.p_nom[2]) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-60})));
  TransiEnt.Components.Boundaries.Gas.IdealGasCompositionByWtFractions gasCompositionByWtFractions(xi_in=simCenter.gasModel2.xi_default) annotation (Placement(transformation(extent={{-106,-14},{-90,2}})));
  Modelica.Blocks.Sources.RealExpression T_supply_set(y=273.15 + 90)
    annotation (Placement(transformation(extent={{-84,18},{-60,42}})));
                   /**/
  Modelica.Units.SI.SpecificEnthalpy h_water_inflow_boiler=inStream(Boiler.waterPortIn.h_outflow);
  Gasboiler_dynamic_L1 Boiler(
    holdTemperature=true,
    Q_flow_n=5e5,
    modulating=false,
    stages=2,
    dimension=3)
              annotation (Placement(transformation(extent={{-18,-18},{18,18}})));
  inner TransiEnt.ModelStatistics modelStatistics
    annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=100,
    height=0.8*Boiler.Q_flow_n/Boiler.cp_water/(90 - 50),
    duration=1500)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi gasSink(gasModel=simCenter.exhaustGasModel) annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi gasSource(gasModel=simCenter.gasModel2, variable_xi=true) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  connect(Boiler.waterPortIn, waterSource.steam_a) annotation (Line(
      points={{-10.08,-14.76},{-10.08,-40},{-20,-40},{-20,-50}},
      color={175,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(Boiler.waterPortOut, waterSink.steam_a) annotation (Line(
      points={{10.08,-14.76},{10.08,-40},{20,-40},{20,-50}},
      color={175,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(T_supply_set.y, Boiler.T_supply_set) annotation (Line(
      points={{-58.8,30},{-40,30},{-40,9},{-16.92,9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gasCompositionByWtFractions.xi, gasSource.xi) annotation (Line(
      points={{-90,-6},{-62,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gasSource.gasPort, Boiler.gasPortIn) annotation (Line(
      points={{-40,0},{-18,0}},
      color={255,213,170},
      thickness=0.5,
      smooth=Smooth.None));
  connect(Boiler.gasPortOut, gasSink.gasPort) annotation (Line(
      points={{18,0},{40,0}},
      color={255,213,170},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ramp.y, waterSource.m_flow) annotation (Line(
      points={{-39,-80},{-26,-80},{-26,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}), graphics), Icon(graphics,
                                               coordinateSystem(extent={{-120,-100},
            {100,100}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Test environment for a boiler with a hold temperature and level of detail L1 (defined in the CodingConventions)</p>
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
end TestBoiler_HoldTemperature_L1;
