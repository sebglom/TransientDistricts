﻿within TransiEnt.Components.Statistics.ConfigurationData.GeneralCostSpecs;
model HydrogenBufferStorage "Cost model for small cylindrical hydrogen buffer storage (82m3 geo, max. 80 bar)"



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





  extends PartialCostSpecs(
    size1=82 "Geometric volume in m3",
    C_inv_size=300000/82*size1 "300000 EUR for a 82m3 storage tank Stolzenburg 2014",
    factor_OM=0.02 "2%, Stolzenburg 2014",
    lifeTime=30 "Stolzenburg 2014");
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Cost model for small cylindrical hydrogen buffer storage (82m3 geo, max. 80 bar)</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>[1] K. Stolzenburg, &quot;Integration von Wind-Wasserstoff-Systemen in das Energiesystem&quot;, 2014 </p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
</html>"));
end HydrogenBufferStorage;
