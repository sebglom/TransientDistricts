﻿within TransiEnt.Components.Statistics.Functions.CO2Allocation;
function AllocationMethod_Efficiencies "efficiencies method"




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

  // _____________________________________________
  //
  //          Imports and Class Hierarchy
  // _____________________________________________

  extends Basics.BasicAllocationMethod;

algorithm
  // _____________________________________________
  //
  //           Characteristic equations
  // _____________________________________________

  m_flow_spec_el := m_flow_spec * eta_th / (eta_th + eta_el);
  m_flow_spec_th := m_flow_spec * eta_el / (eta_th + eta_el);
alloc_m_flow_spec :={m_flow_spec_el,m_flow_spec_th};
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>This function allocates the specific massflowrate of carbon dioxide equivalents of a coupled thermal and eletrical process to the thermal and electrical side based on the efficiencies method.</p>
<p><img src=\"modelica://TransiEnt/Images/allocationEfficiencies.png\"/></p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>No physical effects considered. </p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>(no remarks), just input and output vectors.</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>The specific mass flow rate of carbon dioxide equivalents is allocated as follows:</p>
<p><img src=\"modelica://TransiEnt/Images/equations/equation-q8sRXsuJ.png\" alt=\"m_flowSpecEl = m_flowSpec * (eta_th / (eta_th + eta_el))\"/></p>
<p><img src=\"modelica://TransiEnt/Images/equations/equation-xX8Mpbyg.png\" alt=\"m_flowSpecTh = m_flowSpec * (eta_el / (eta_th + eta_el))\"/>.</p>
<p>The output vector provides the specific mass flow rate of carbon dioxide emissions for the thermal side in first and for the electrical side in second place</p>
<p><img src=\"modelica://TransiEnt/Images/equations/equation-CnIXYQNd.png\"/></p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>no remarks.</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>No validation needed.</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>[Mauch et. al.]: Allokationsmethoden für spezifische CO2-Emissionen von Strom und Wärme aus KWK-Anlagen. In: Energiewirtschaftliche</p>
<p>Tagesfragen Bd. 55. Jg. (2010) Heft 9</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Created by Jan Braune (jan.braune@tuhh.de), Mar 2015</p>
<p>Revised by Lisa Andresen (andresen@tuhh.de), Jun 2015</p>
</html>"));
end AllocationMethod_Efficiencies;
