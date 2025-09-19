
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

##### Vivado variables #####
set verbose      1
set dcpLevel     1

##### Directories #####
set designDir "<<PWD>>/soc"
set ipDir "<<PWD>>/ip_repo"

##### Static hierarchy #####
set top "<<NAME>>_wrapper"
