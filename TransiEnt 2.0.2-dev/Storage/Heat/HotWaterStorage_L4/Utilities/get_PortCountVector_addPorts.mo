﻿within TransiEnt.Storage.Heat.HotWaterStorage_L4.Utilities;
function get_PortCountVector_addPorts "generates port count vector for tank with solar, CHP,  grid and additional in and outputs"



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





 extends TransiEnt.Basics.Icons.Function;

  input Integer nSeg "Number of tank segments";

  input Integer CHP_in_layer "CHP input segment";
  input Integer CHP_out_layer "CHP output segment";

  input Integer grid_in_layer "grid input segment";
  input Integer grid_out_layer "grid output segment";

  input Integer nSolarInputLayer "number of solar input segments";
  input Integer Solar_in_layer "lowest solar input segment";
  input Integer Solar_out_layer "solar output segment";

  input Integer nAdditionalPorts "number of additional in and output ports";
  input Integer[nAdditionalPorts] additionalPorts_layer "additional ports segments";

//overall port counts to create volume segments with correct port count
  output Integer[nSeg] portCountVector;

// return port number of volume element where the connection has to be made

protected
   Integer CHP_in_port;
   Integer CHP_out_port;

   Integer grid_in_port;
   Integer grid_out_port;

   Integer[nSolarInputLayer] Solar_in_port;
   Integer Solar_out_port;
   Integer k "Variable for counting in solar input loop";

   Integer[nAdditionalPorts] additionalPort_ports;

algorithm
  // inter layer connections. sheme ist layer[i].ports[1]->layer[i+1].ports[2],
  // but layer[nSeg-1].ports[1]->layer[nSeg].ports[1]
    portCountVector :=  fill(1, nSeg);
    portCountVector[2:nSeg-1] :=  fill(2, nSeg-2);

    //CHP
    portCountVector[CHP_in_layer] :=portCountVector[CHP_in_layer] + 1;
    CHP_in_port := portCountVector[CHP_in_layer];
    portCountVector[CHP_out_layer] :=portCountVector[CHP_out_layer] + 1;
    CHP_out_port := portCountVector[CHP_out_layer];

    //Grid
    portCountVector[grid_in_layer] :=portCountVector[grid_in_layer] + 1;
    grid_in_port :=portCountVector[grid_in_layer];
    portCountVector[grid_out_layer] :=portCountVector[grid_out_layer] + 1;
    grid_out_port :=portCountVector[grid_out_layer];

    //add ports for external fluid connections
    //inputs for solar loading.
    k:= 1;
     for i in (Solar_in_layer - nSolarInputLayer + 1) : Solar_in_layer loop
       portCountVector[i] := portCountVector[i] + 1;
       Solar_in_port[k] := portCountVector[i];
       k := k+1;
     end for;
     //output solar
    portCountVector[Solar_out_layer] := portCountVector[Solar_out_layer] + 1;
    Solar_out_port := portCountVector[Solar_out_layer];

     //additional ports
     for i in 1 : nAdditionalPorts loop
       portCountVector[additionalPorts_layer[i]] := portCountVector[additionalPorts_layer[i]] + 1;
       additionalPort_ports[i] := portCountVector[additionalPorts_layer[i]];
     end for;

  annotation (Documentation(info="<html>
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
end get_PortCountVector_addPorts;
