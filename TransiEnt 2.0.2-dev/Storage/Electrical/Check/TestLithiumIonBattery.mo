﻿within TransiEnt.Storage.Electrical.Check;
model TestLithiumIonBattery



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

  inner TransiEnt.SimCenter simCenter
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{66,-40},{86,-20}})));
  TransiEnt.Producer.Electrical.Wind.WindProfiles.WindProfileLoader P_wind(REProfile=TransiEnt.Producer.Electrical.Wind.WindProfiles.WindData.Wind2012_TenneT_900s, constantfactor=0.2*30000e6) annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
  Modelica.Blocks.Math.Add P_residual(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
  TransiEnt.Basics.Tables.ElectricGrid.PowerData.ElectricityDemand_HH_900s_2012 P_load annotation (Placement(transformation(extent={{-78,-36},{-58,-16}})));

  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power Consumer annotation (Placement(transformation(extent={{48,-84},{28,-64}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power WindGenerator annotation (Placement(transformation(extent={{48,-2},{28,18}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{16,24},{24,32}})));
  Modelica.Blocks.Sources.RealExpression P_residual_smoothed(y=-ElectricGrid.epp.P) annotation (Placement(transformation(extent={{68,-12},{88,8}})));
  LithiumIonBattery Storage(                                                                                                    StorageModelParams=TransiEnt.Storage.Electrical.Specifications.LithiumIon(
        E_max=1e14,
        P_max_unload=900e6,
        P_max_load=90e6,
        eta_unload=1,
        eta_load=1), redeclare model CostModel = TransiEnt.Components.Statistics.ConfigurationData.StorageCostSpecs.LithiumIonBattery)
                     annotation (Placement(transformation(extent={{25,-41},{47,-19}})));
equation

  connect(Storage.epp, ElectricGrid.epp) annotation (Line(
      points={{47,-30},{66,-30},{66,-30}},
      color={0,135,135},
      thickness=0.5));
  connect(WindGenerator.epp, ElectricGrid.epp) annotation (Line(
      points={{48,8},{58,8},{58,-30},{66,-30}},
      color={0,135,135},
      thickness=0.5));
  connect(Consumer.epp, ElectricGrid.epp) annotation (Line(
      points={{48,-74},{58,-74},{58,-30},{66,-30}},
      color={0,135,135},
      thickness=0.5));
  connect(P_wind.y1, P_residual.u1) annotation (Line(points={{-59,8},{-46,8},{-46,-6},{-42,-6}}, color={0,0,127}));
  connect(P_load.y1, P_residual.u2) annotation (Line(points={{-57,-26},{-46,-26},{-46,-18},{-42,-18}}, color={0,0,127}));
  connect(P_load.y1, Consumer.P_el_set) annotation (Line(points={{-57,-26},{-46,-26},{-46,-54},{44,-54},{44,-62}}, color={0,0,127}));
  connect(gain.y, WindGenerator.P_el_set) annotation (Line(points={{24.4,28},{44,28},{44,20}}, color={0,0,127}));
  connect(gain.u, P_wind.y1) annotation (Line(points={{15.2,28},{-46,28},{-46,8},{-59,8}}, color={0,0,127}));
public
function plotResult

  constant String resultFileName = "TestLeadAcidBattery.mat";

  output String resultFile;

algorithm
  clearlog();
    assert(cd(Modelica.Utilities.System.getEnvironmentVariable(TransiEnt.Basics.Types.WORKINGDIR)), "Error changing directory: Working directory must be set as environment variable with name 'workingdir' for this script to work.");
  resultFile :=TransiEnt.Basics.Functions.fullPathName(Modelica.Utilities.System.getEnvironmentVariable(TransiEnt.Basics.Types.WORKINGDIR) + "/" + resultFileName);
  removePlots();

createPlot(id=1, position={809, 0, 791, 817}, y={"Storage.epp.P"}, range={0.0, 4000000.0, -1000000000.0, 200000000.0}, grid=true, colors={{238,46,47}}, filename=resultFile);
createPlot(id=1, position={809, 0, 791, 269}, y={"Storage.SOC.y"}, range={0.0, 4000000.0, -0.2, 1.0000000000000002}, grid=true, subPlot=2, colors={{28,108,200}}, filename=resultFile);
createPlot(id=1, position={809, 0, 791, 269}, y={"P_residual.y", "P_residual_smoothed.y"}, range={0.0, 4000000.0, -5000000000.0, 2000000000.0}, grid=true, subPlot=3, colors={{28,108,200}, {238,46,47}}, filename=resultFile);

  resultFile := "Successfully plotted results for file: " + resultFile;

end plotResult;
equation
  connect(P_residual.y, Storage.P_set) annotation (Line(points={{-19,-12},{36,-12},{36,-19.66}}, color={0,0,127}));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=4e+006,
      Interval=900,
      Tolerance=1e-006,
      __Dymola_Algorithm="Sdirk34hw"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
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
</html>"));
end TestLithiumIonBattery;
