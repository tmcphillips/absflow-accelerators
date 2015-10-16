set project_dir  ".."
set source_dir   "${project_dir}/Source"
set modelsim_dir "${project_dir}/ModelSim"
set tests_dir   "${source_dir}/dbctr_tests"

set OVM_LIB_DIR "/home/tmcphillips/GitHub/Accelerators/Hardware/Libraries/ovm-2.1.2"
set OVL_LIB_DIR "/home/tmcphillips/GitHub/Accelerators/Hardware/Libraries/std_ovl"

set ovm_build_options [concat   \
    +incdir+${OVM_LIB_DIR}/src  \
    -y ${OVM_LIB_DIR}/src       \
]

set ovl_build_options [concat   \
    +incdir+${OVL_LIB_DIR}      \
    -y ${OVL_LIB_DIR}           \
]

set compile_v_options [concat   \
    -work work                  \
    -vlog01compat               \
    +incdir+${source_dir}       \
    +libext+.v                  \
    +libext+.sv                 \
    $ovl_build_options          \
    $ovm_build_options          \
    +define+OVL_VERILOG         \
    +define+OVL_ASSERT_ON       \
    +define+ASSERTIONS_ON  
]

set compile_sv_options [concat  \
    -sv                         \
    -work work                  \
    +incdir+${source_dir}       \
    +incdir+${modelsim_dir}     \
    +libext+.v                  \
    +libext+.sv                 \
    $ovl_build_options          \
    $ovm_build_options
]

proc compile_v {sourcefile} {
    global compile_v_options
    eval vlog [lrange $compile_v_options 0 end] $sourcefile
}

proc compile_sv {sourcefile} {
    global compile_sv_options
    eval vlog [lrange $compile_sv_options 0 end] $sourcefile
}

proc clean {} {
    file delete wlf*
	if [file exists "work"] {
		puts "Deleting work library"
		puts [exec vdel -all]
	}
	puts "Creating work library"
	puts [vlib work]
}

proc build {} {
    global verilog_options
    global source_dir
    
    compile_sv ${source_dir}/dbctr_testbench_classes.sv
    compile_sv ${source_dir}/dbctr_testbench_tester.sv
    compile_sv ${source_dir}/dbctr_testbench_modules.sv
    
    compile_v ${source_dir}/fourbitcounterwithload.v
}

proc loadsim {} {
    vsim -onfinish stop work.dbctr_testbench_top
}

proc loadwave {} {
    global SimTop
    add wave clock
    add wave up
    add wave down
    add wave load
    add wave reset
    add wave ack
    add wave load_value
    add wave counter_value
}

proc runsim {} {
    run -all
}

proc startsim {} {
    loadsim
    loadwave
    runsim
}

proc restartsim {} {
    restart -force
}

proc endsim {} {
    quit -sim -force   
}

proc runtests {} {
	global tests_dir
	global source_dir
    set testfiles [glob -directory ${tests_dir} *.sv]
    foreach filepath $testfiles {
        set testpath [split $filepath "/"]
        set testfile [lrange $testpath end end]
        set testname [lindex [split $testfile "."] 0]
        puts "Copying file $testfile"
        file copy -force $filepath ./testbody.sv
        compile_sv ${source_dir}/dbctr_testbench_tester.sv        
        restartsim
        vsim -onfinish stop work.dbctr_testbench_top -wlf ${testname}.wlf
        onbreak resume
		log clock
		log up
		log down
		log load
		log reset
		log ack
		log load_value
		log counter_value
        run -all
		log -flush
    }
}
