
source ${tclDir_dfx}/dfx_source.tcl

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
puts "modules are [get_modules]"
foreach m [get_modules] {
  puts "examining m $m"
  if { [get_attribute module $m top_level] } {
    set_attribute module $m synth ${run.topSynth}
  } else {
    puts "setting synth to ${run.rmSynth} for $m"
    set_attribute module $m synth ${run.rmSynth}
  }
}

source $tclDir/run.tcl
