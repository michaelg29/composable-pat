
##### Environment #####
if { ![info exists ::env(CP_DIR)] } {
   set errMsg "\nERROR: Could not find environment variable CP_DIR."
   lappend errMsg "\nPlease source the env.sh script for this repository."
   error $errMsg
}
set cpDir $::env(CP_DIR)

##### User variables #####
set projName "<<NAME>>"
set part "<<PART>>"

##### Directories #####
set designDir "<<PWD>>"
set ipDir "<<PWD>>"

##### Static hierarchy #####
set top "<<NAME>>_wrapper"
