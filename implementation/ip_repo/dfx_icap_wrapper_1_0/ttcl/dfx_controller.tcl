
if { [llength [get_ips dfx_controller_zynq]] == 0 } {

set ip_name dfx_controller_zynq
source [get_property REPOSITORY [get_ipdefs *dfx_controller:1.0]]/xilinx/dfx_controller_v1_0/tcl/api.tcl -notrace
create_ip -name dfx_controller -vendor xilinx.com -library ip -module_name $ip_name

dfx_controller_v1_0::set_property -dict [list                                                      \
                                    CONFIG.HAS_AXI_LITE_IF                      1\
                                    CONFIG.RESET_ACTIVE_LEVEL                   0\
                                    CONFIG.CP_FIFO_DEPTH                        32\
                                    CONFIG.CP_FIFO_TYPE                         lutram\
                                    CONFIG.CP_ARBITRATION_PROTOCOL              0\
                                    CONFIG.CP_COMPRESSION                       0\
                                    CONFIG.CP_FAMILY                            7series\
                                    CONFIG.CDC_STAGES                           2\
                                    CONFIG.VS.VS_0.START_IN_SHUTDOWN            0\
                                    CONFIG.VS.VS_0.NUM_TRIGGERS_ALLOCATED       1\
                                    CONFIG.VS.VS_0.NUM_RMS_ALLOCATED            1\
                                    CONFIG.VS.VS_0.NUM_HW_TRIGGERS              0\
                                    CONFIG.VS.VS_0.SHUTDOWN_ON_ERROR            0\
                                    CONFIG.VS.VS_0.HAS_AXIS_STATUS              0\
                                    CONFIG.VS.VS_0.HAS_AXIS_CONTROL             0\
                                    CONFIG.VS.VS_0.HAS_POR_RM                   0\
                                    CONFIG.VS.VS_0.SKIP_RM_STARTUP_AFTER_RESET  0\
                                    CONFIG.VS.VS_0.RM.RM_0.SHUTDOWN_REQUIRED    no\
                                    CONFIG.VS.VS_0.RM.RM_0.STARTUP_REQUIRED     sw\
                                    CONFIG.VS.VS_0.RM.RM_0.RESET_REQUIRED       no\
                                    CONFIG.VS.VS_0.RM.RM_0.BS.0.ADDRESS         0\
                                    CONFIG.VS.VS_0.RM.RM_0.BS.0.SIZE            0\
                                    CONFIG.VS.VS_0.RM.RM_0.BS.0.CLEAR           0\
                                    ] [get_ips $ip_name]
generate_target {all} [get_ips $ip_name]

}
