
source dfx_source.tcl

####### FPGA type #######
check_part $part

##### Run parameters #####
set run.topSynth  	   0
set run.rmSynth   	   1
set run.dfxImpl    	   1
set run.greyboxImpl    1
set run.prVerify  	   1
set run.writeBitstream 0

# synthesize modules
foreach m [get_modules] {
  if { [get_attribute module $m top_level] } {
    set_attribute module $m synth $run.topSynth
  } else {
    set_attribtue module $m synth $run.rmSynth
  }
}

source $tclDir/run.tcl
