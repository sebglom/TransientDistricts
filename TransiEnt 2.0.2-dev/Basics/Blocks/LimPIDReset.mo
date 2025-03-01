﻿within TransiEnt.Basics.Blocks;
block LimPIDReset "P, PI, PD, and PID controller with limited output, anti-windup compensation and setpoint weighting"



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

  import InitPID =
         Modelica.Blocks.Types.Init;
  import Modelica.Blocks.Types.Init;
  import Modelica.Blocks.Types.SimpleController;
  extends TransiEnt.Basics.Icons.Block;

  // _____________________________________________
  //
  //        Constants and Hidden Parameters
  // _____________________________________________

  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  constant SI.Time unitTime=1  annotation(HideResult=true);

protected
  parameter Boolean with_I = controllerType==SimpleController.PI or
                             controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
  parameter Boolean with_D = controllerType==SimpleController.PD or
                             controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
public
  Modelica.Blocks.Sources.Constant Dzero(k=0) if not with_D annotation (Placement(transformation(extent={{-30,20},{-20,30}})));
  Modelica.Blocks.Sources.Constant Izero(k=0) if not with_I annotation (Placement(transformation(extent={{10,-55},{0,-45}})));


  // _____________________________________________
  //
  //               Visible Parameters
  // _____________________________________________

public
  parameter .Modelica.Blocks.Types.SimpleController controllerType=
         .Modelica.Blocks.Types.SimpleController.PID "Type of controller";
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter SI.Time Ti(min=Modelica.Constants.small)=0.5 "Time constant of Integrator block" annotation (Dialog(enable=controllerType == .Modelica.Blocks.Types.SimpleController.PI or controllerType == .Modelica.Blocks.Types.SimpleController.PID));
  parameter SI.Time Td(min=0)=0.1 "Time constant of Derivative block" annotation (Dialog(enable=controllerType == .Modelica.Blocks.Types.SimpleController.PD or controllerType == .Modelica.Blocks.Types.SimpleController.PID));
  parameter Real yMax(start=1) "Upper limit of output";
  parameter Real yMin=-yMax "Lower limit of output";
  parameter Real wp(min=0) = 1 "Set-point weight for Proportional block (0..1)";
  parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
       annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9 "Ni*Ti is time constant of anti-windup compensation"
     annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PI or
                              controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Nd(min=100*Modelica.Constants.eps) = 10 "The higher Nd, the more ideal the derivative block"
       annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter .Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (Evaluate=true, Dialog(group="Initialization"));
  parameter Boolean limitsAtInit = true "= false, if limits are ignored during initialization"
    annotation(Evaluate=true, Dialog(group="Initialization"));
  parameter Real xi_start=0 "Initial or guess value value for integrator output (= integrator state)"
    annotation (Dialog(group="Initialization",
                enable=controllerType==.Modelica.Blocks.Types.SimpleController.PI or
                       controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real xd_start=0 "Initial or guess value for state of derivative block"
    annotation (Dialog(group="Initialization",
                         enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == .Modelica.Blocks.Types.Init.InitialOutput,    group=
          "Initialization"));


  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger to reset integrator value" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-2,106})));
  Modelica.Blocks.Interfaces.RealInput u_s "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput u_m "Connector of measurement input signal" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of actuator output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));


  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  Modelica.Blocks.Math.Add addP(k1=wp, k2=-1) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Math.Add addD(k1=wd, k2=-1) if with_D annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.Gain P(k=1) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  IntegratorReset I(
    k=unitTime/Ti,
    y_start=xi_start,
    initType=if initType == InitPID.SteadyState then Init.SteadyState else if initType == InitPID.InitialState or initType == InitPID.InitialState then Init.InitialState else Init.NoInit) if with_I annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Continuous.Derivative D(
    k=Td/unitTime,
    T=max([Td/Nd,1.e-14]),
    x_start=xd_start,
    initType=if initType ==InitPID.SteadyState  or initType ==InitPID.InitialOutput  then Init.SteadyState else if initType ==InitPID.InitialState  then Init.InitialState else Init.NoInit) if with_D annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain gainPID(k=k) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Math.Add3 addPID annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Add3 addI(k2=-1) if with_I annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Math.Add addSat(k1=+1, k2=-1) if with_I annotation (Placement(transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Math.Gain gainTrack(k=1/(k*Ni)) if with_I annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(
    uMax=yMax,
    uMin=yMin,
    strict=strict) annotation (Placement(transformation(extent={{70,-10},{90,10}})));



  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

  output Real controlError = u_s - u_m "Control error (set point - measurement)";


  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________

initial equation
  if initType==InitPID.InitialOutput then
     gainPID.y = y_start;
  end if;
equation
  if initType ==InitPID.InitialOutput  and (y_start < yMin or y_start > yMax) then
      Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(y_start) +
         ") is outside of the limits of yMin (=" + String(yMin) +") and yMax (=" + String(yMax) + ")");
  end if;

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(u_s, addP.u1) annotation (Line(points={{-120,0},{-96,0},{-96,56},{
          -82,56}}, color={0,0,127}));
  connect(u_s, addD.u1) annotation (Line(points={{-120,0},{-96,0},{-96,6},{
          -82,6}}, color={0,0,127}));
  connect(u_s, addI.u1) annotation (Line(points={{-120,0},{-96,0},{-96,-42},{
          -82,-42}}, color={0,0,127}));
  connect(addP.y, P.u) annotation (Line(points={{-59,50},{-42,50}}, color={0,
          0,127}));
  connect(addD.y, D.u)
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(addI.y, I.u) annotation (Line(points={{-59,-50},{-42,-50}}, color={
          0,0,127}));
  connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,8},
          {-2,8}}, color={0,0,127}));
  connect(D.y, addPID.u2)
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(I.y, addPID.u3) annotation (Line(points={{-19,-50},{-10,-50},{-10,
          -8},{-2,-8}}, color={0,0,127}));
  connect(addPID.y, gainPID.u)
    annotation (Line(points={{21,0},{28,0}}, color={0,0,127}));
  connect(gainPID.y, addSat.u2) annotation (Line(points={{51,0},{60,0},{60,
          -20},{74,-20},{74,-38}}, color={0,0,127}));
  connect(gainPID.y, limiter.u)
    annotation (Line(points={{51,0},{68,0}}, color={0,0,127}));
  connect(limiter.y, addSat.u1) annotation (Line(points={{91,0},{94,0},{94,
          -20},{86,-20},{86,-38}}, color={0,0,127}));
  connect(limiter.y, y)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(addSat.y, gainTrack.u) annotation (Line(points={{80,-61},{80,-70},{
          42,-70}}, color={0,0,127}));
  connect(gainTrack.y, addI.u3) annotation (Line(points={{19,-70},{-88,-70},{
          -88,-58},{-82,-58}}, color={0,0,127}));
  connect(u_m, addP.u2) annotation (Line(
      points={{0,-120},{0,-92},{-92,-92},{-92,44},{-82,44}},
      color={0,0,127},
      thickness=0.5));
  connect(u_m, addD.u2) annotation (Line(
      points={{0,-120},{0,-92},{-92,-92},{-92,-6},{-82,-6}},
      color={0,0,127},
      thickness=0.5));
  connect(u_m, addI.u2) annotation (Line(
      points={{0,-120},{0,-92},{-92,-92},{-92,-50},{-82,-50}},
      color={0,0,127},
      thickness=0.5));
  connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{
          -14,0},{-2,0}}, color={0,0,127}));
  connect(Izero.y, addPID.u3) annotation (Line(points={{-0.5,-50},{-10,-50},{
          -10,-8},{-2,-8}}, color={0,0,127}));
  connect(I.trigger, trigger) annotation (Line(points={{-30,-43.2},{-30,-28},{-2,-28},{-2,106}}, color={255,0,255}));
  annotation (defaultComponentName="PID",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
        Text(
          extent={{-20,-20},{80,-60}},
          lineColor={192,192,192},
          textString="%controllerType"),
        Line(
          visible=strict,
          points={{30,60},{81,60}},
          color={255,0,0})}),
Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">1. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model extends the MSL LimPID Controller by a reset functionality which allows to trigger a reset of the integrator state. See documentation of <a href=\"Modelica.Blocks.Continuous.LimPID\">LimPID</a> for more details.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">2. Level of detail, physical effects considered, and physical insight</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(Purely technical component without physical modeling.)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Modelica BooleanInput: trigger to reset integrator value</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Modelica RealInput: connector of setpoint input signal</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Modelica RealInput: connector of measurement input signal</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Modelica RealOutput: connector of actuator output signal</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no elements)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no equations)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarks for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de), Aug 2014</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model revised by Pascal Dubucq (dubucq@tuhh.de), Apr 2017 : code conventions</span></p>
</html>"));
end LimPIDReset;
