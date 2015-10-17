
########## Tcl recorder starts at 02/17/12 14:55:20 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/26_NTSC_1"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 14:55:20 ###########


########## Tcl recorder starts at 02/17/12 16:06:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:06:07 ###########


########## Tcl recorder starts at 02/17/12 16:06:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:06:08 ###########


########## Tcl recorder starts at 02/17/12 16:07:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:07:32 ###########


########## Tcl recorder starts at 02/17/12 16:07:33 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:07:33 ###########


########## Tcl recorder starts at 02/17/12 16:08:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:08:00 ###########


########## Tcl recorder starts at 02/17/12 16:08:00 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:08:00 ###########


########## Tcl recorder starts at 02/17/12 16:08:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:08:25 ###########


########## Tcl recorder starts at 02/17/12 16:08:25 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:08:25 ###########


########## Tcl recorder starts at 02/17/12 16:09:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:09:11 ###########


########## Tcl recorder starts at 02/17/12 16:09:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:09:12 ###########


########## Tcl recorder starts at 02/17/12 16:11:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:11:21 ###########


########## Tcl recorder starts at 02/17/12 16:11:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:11:21 ###########


########## Tcl recorder starts at 02/17/12 16:12:45 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 16:12:45 ###########


########## Tcl recorder starts at 02/17/12 21:44:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:44:12 ###########


########## Tcl recorder starts at 02/17/12 21:44:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:44:13 ###########


########## Tcl recorder starts at 02/17/12 21:45:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:45:29 ###########


########## Tcl recorder starts at 02/17/12 21:45:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:45:30 ###########


########## Tcl recorder starts at 02/17/12 21:45:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:45:57 ###########


########## Tcl recorder starts at 02/17/12 21:45:58 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src mach64_verilog_project.bl5 -type BLIF -presrc mach64_verilog_project.bl3 -crf mach64_verilog_project.crf -sif mach64_verilog_project.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_64_32.dev\" -lci mach64_verilog_project.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:45:58 ###########


########## Tcl recorder starts at 02/17/12 21:46:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:46:44 ###########


########## Tcl recorder starts at 02/17/12 21:46:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/17/12 21:46:45 ###########


########## Tcl recorder starts at 02/18/12 10:50:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 10:50:40 ###########


########## Tcl recorder starts at 02/18/12 10:50:40 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 10:50:40 ###########


########## Tcl recorder starts at 02/18/12 10:51:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 10:51:58 ###########


########## Tcl recorder starts at 02/18/12 10:55:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 10:55:51 ###########


########## Tcl recorder starts at 02/18/12 10:55:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 10:55:52 ###########


########## Tcl recorder starts at 02/18/12 11:03:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:03:47 ###########


########## Tcl recorder starts at 02/18/12 11:03:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:03:48 ###########


########## Tcl recorder starts at 02/18/12 11:04:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:04:44 ###########


########## Tcl recorder starts at 02/18/12 11:04:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:04:45 ###########


########## Tcl recorder starts at 02/18/12 11:09:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:09:04 ###########


########## Tcl recorder starts at 02/18/12 11:09:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:09:05 ###########


########## Tcl recorder starts at 02/18/12 11:09:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:09:28 ###########


########## Tcl recorder starts at 02/18/12 11:09:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:09:29 ###########


########## Tcl recorder starts at 02/18/12 11:35:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:35:10 ###########


########## Tcl recorder starts at 02/18/12 11:35:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:35:11 ###########


########## Tcl recorder starts at 02/18/12 11:38:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:38:19 ###########


########## Tcl recorder starts at 02/18/12 11:38:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:38:20 ###########


########## Tcl recorder starts at 02/18/12 11:49:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:49:26 ###########


########## Tcl recorder starts at 02/18/12 11:49:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:49:27 ###########


########## Tcl recorder starts at 02/18/12 11:52:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:52:48 ###########


########## Tcl recorder starts at 02/18/12 11:52:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:52:49 ###########


########## Tcl recorder starts at 02/18/12 11:56:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:56:20 ###########


########## Tcl recorder starts at 02/18/12 11:56:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 11:56:21 ###########


########## Tcl recorder starts at 02/18/12 12:39:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:39:26 ###########


########## Tcl recorder starts at 02/18/12 12:39:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:39:27 ###########


########## Tcl recorder starts at 02/18/12 12:40:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:40:06 ###########


########## Tcl recorder starts at 02/18/12 12:40:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:40:08 ###########


########## Tcl recorder starts at 02/18/12 12:45:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:45:35 ###########


########## Tcl recorder starts at 02/18/12 12:45:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:45:36 ###########


########## Tcl recorder starts at 02/18/12 12:47:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:47:18 ###########


########## Tcl recorder starts at 02/18/12 12:47:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 12:47:19 ###########


########## Tcl recorder starts at 02/18/12 13:26:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:26:57 ###########


########## Tcl recorder starts at 02/18/12 13:26:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:26:58 ###########


########## Tcl recorder starts at 02/18/12 13:30:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:30:21 ###########


########## Tcl recorder starts at 02/18/12 13:30:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:30:22 ###########


########## Tcl recorder starts at 02/18/12 13:32:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:32:47 ###########


########## Tcl recorder starts at 02/18/12 13:32:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:32:48 ###########


########## Tcl recorder starts at 02/18/12 13:35:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:35:46 ###########


########## Tcl recorder starts at 02/18/12 13:35:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:35:47 ###########


########## Tcl recorder starts at 02/18/12 13:36:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:36:49 ###########


########## Tcl recorder starts at 02/18/12 13:36:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 13:36:50 ###########


########## Tcl recorder starts at 02/18/12 17:22:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:22:29 ###########


########## Tcl recorder starts at 02/18/12 17:22:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:22:30 ###########


########## Tcl recorder starts at 02/18/12 17:32:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:32:38 ###########


########## Tcl recorder starts at 02/18/12 17:32:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:32:39 ###########


########## Tcl recorder starts at 02/18/12 17:45:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:45:35 ###########


########## Tcl recorder starts at 02/18/12 17:45:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 17:45:36 ###########


########## Tcl recorder starts at 02/18/12 18:03:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:03:17 ###########


########## Tcl recorder starts at 02/18/12 18:03:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:03:18 ###########


########## Tcl recorder starts at 02/18/12 18:03:50 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:03:50 ###########


########## Tcl recorder starts at 02/18/12 18:04:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:04:16 ###########


########## Tcl recorder starts at 02/18/12 18:04:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:04:17 ###########


########## Tcl recorder starts at 02/18/12 18:08:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:08:27 ###########


########## Tcl recorder starts at 02/18/12 18:08:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:08:28 ###########


########## Tcl recorder starts at 02/18/12 18:09:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:09:06 ###########


########## Tcl recorder starts at 02/18/12 18:09:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:09:07 ###########


########## Tcl recorder starts at 02/18/12 18:10:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:10:35 ###########


########## Tcl recorder starts at 02/18/12 18:10:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:10:36 ###########


########## Tcl recorder starts at 02/18/12 18:11:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:11:50 ###########


########## Tcl recorder starts at 02/18/12 18:11:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:11:51 ###########


########## Tcl recorder starts at 02/18/12 18:13:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:13:09 ###########


########## Tcl recorder starts at 02/18/12 18:13:10 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:13:10 ###########


########## Tcl recorder starts at 02/18/12 18:14:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:14:50 ###########


########## Tcl recorder starts at 02/18/12 18:14:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:14:51 ###########


########## Tcl recorder starts at 02/18/12 18:15:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:15:33 ###########


########## Tcl recorder starts at 02/18/12 18:15:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:15:34 ###########


########## Tcl recorder starts at 02/18/12 18:16:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:16:53 ###########


########## Tcl recorder starts at 02/18/12 18:16:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:16:54 ###########


########## Tcl recorder starts at 02/18/12 18:20:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:20:40 ###########


########## Tcl recorder starts at 02/18/12 18:20:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:20:41 ###########


########## Tcl recorder starts at 02/18/12 18:23:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:23:31 ###########


########## Tcl recorder starts at 02/18/12 18:23:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:23:32 ###########


########## Tcl recorder starts at 02/18/12 18:24:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:24:21 ###########


########## Tcl recorder starts at 02/18/12 18:24:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:24:22 ###########


########## Tcl recorder starts at 02/18/12 18:26:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:26:04 ###########


########## Tcl recorder starts at 02/18/12 18:26:05 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:26:05 ###########


########## Tcl recorder starts at 02/18/12 18:26:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:26:57 ###########


########## Tcl recorder starts at 02/18/12 18:26:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:26:58 ###########


########## Tcl recorder starts at 02/18/12 18:29:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:29:14 ###########


########## Tcl recorder starts at 02/18/12 18:29:15 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:29:15 ###########


########## Tcl recorder starts at 02/18/12 18:30:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:30:24 ###########


########## Tcl recorder starts at 02/18/12 18:30:25 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:30:25 ###########


########## Tcl recorder starts at 02/18/12 18:31:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:31:41 ###########


########## Tcl recorder starts at 02/18/12 18:31:42 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:31:42 ###########


########## Tcl recorder starts at 02/18/12 18:33:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:33:51 ###########


########## Tcl recorder starts at 02/18/12 18:33:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:33:52 ###########


########## Tcl recorder starts at 02/18/12 18:35:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:35:06 ###########


########## Tcl recorder starts at 02/18/12 18:35:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:35:07 ###########


########## Tcl recorder starts at 02/18/12 18:36:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:36:02 ###########


########## Tcl recorder starts at 02/18/12 18:36:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:36:03 ###########


########## Tcl recorder starts at 02/18/12 18:39:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:39:07 ###########


########## Tcl recorder starts at 02/18/12 18:39:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:39:08 ###########


########## Tcl recorder starts at 02/18/12 18:40:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:40:12 ###########


########## Tcl recorder starts at 02/18/12 18:40:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:40:13 ###########


########## Tcl recorder starts at 02/18/12 18:40:38 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:40:38 ###########


########## Tcl recorder starts at 02/18/12 18:41:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:41:29 ###########


########## Tcl recorder starts at 02/18/12 18:41:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:41:30 ###########


########## Tcl recorder starts at 02/18/12 18:43:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:43:13 ###########


########## Tcl recorder starts at 02/18/12 18:43:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:43:14 ###########


########## Tcl recorder starts at 02/18/12 18:45:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:45:41 ###########


########## Tcl recorder starts at 02/18/12 18:45:42 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:45:42 ###########


########## Tcl recorder starts at 02/18/12 18:47:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:47:53 ###########


########## Tcl recorder starts at 02/18/12 18:47:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:47:54 ###########


########## Tcl recorder starts at 02/18/12 18:48:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:48:32 ###########


########## Tcl recorder starts at 02/18/12 18:48:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:48:33 ###########


########## Tcl recorder starts at 02/18/12 18:49:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:49:42 ###########


########## Tcl recorder starts at 02/18/12 18:49:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:49:43 ###########


########## Tcl recorder starts at 02/18/12 18:53:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:53:40 ###########


########## Tcl recorder starts at 02/18/12 18:53:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:53:41 ###########


########## Tcl recorder starts at 02/18/12 18:59:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:59:12 ###########


########## Tcl recorder starts at 02/18/12 18:59:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 18:59:13 ###########


########## Tcl recorder starts at 02/18/12 19:00:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:00:12 ###########


########## Tcl recorder starts at 02/18/12 19:00:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:00:13 ###########


########## Tcl recorder starts at 02/18/12 19:01:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:01:06 ###########


########## Tcl recorder starts at 02/18/12 19:01:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:01:07 ###########


########## Tcl recorder starts at 02/18/12 19:02:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:02:15 ###########


########## Tcl recorder starts at 02/18/12 19:02:16 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:02:16 ###########


########## Tcl recorder starts at 02/18/12 19:03:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:03:10 ###########


########## Tcl recorder starts at 02/18/12 19:03:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:03:11 ###########


########## Tcl recorder starts at 02/18/12 19:04:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:04:46 ###########


########## Tcl recorder starts at 02/18/12 19:04:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:04:47 ###########


########## Tcl recorder starts at 02/18/12 19:06:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:06:59 ###########


########## Tcl recorder starts at 02/18/12 19:07:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:07:00 ###########


########## Tcl recorder starts at 02/18/12 19:08:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:08:09 ###########


########## Tcl recorder starts at 02/18/12 19:08:10 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:08:10 ###########


########## Tcl recorder starts at 02/18/12 19:09:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:09:01 ###########


########## Tcl recorder starts at 02/18/12 19:09:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:09:02 ###########


########## Tcl recorder starts at 02/18/12 19:09:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:09:57 ###########


########## Tcl recorder starts at 02/18/12 19:09:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:09:58 ###########


########## Tcl recorder starts at 02/18/12 19:11:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:11:10 ###########


########## Tcl recorder starts at 02/18/12 19:11:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:11:11 ###########


########## Tcl recorder starts at 02/18/12 19:12:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:12:07 ###########


########## Tcl recorder starts at 02/18/12 19:12:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:12:08 ###########


########## Tcl recorder starts at 02/18/12 19:13:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:13:28 ###########


########## Tcl recorder starts at 02/18/12 19:13:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:13:29 ###########


########## Tcl recorder starts at 02/18/12 19:14:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:14:51 ###########


########## Tcl recorder starts at 02/18/12 19:14:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/18/12 19:14:52 ###########


########## Tcl recorder starts at 02/21/12 10:42:49 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/27_NTSC_2"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 10:42:49 ###########


########## Tcl recorder starts at 02/21/12 10:47:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 10:47:31 ###########


########## Tcl recorder starts at 02/21/12 10:47:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 10:47:32 ###########


########## Tcl recorder starts at 02/21/12 10:48:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 10:48:06 ###########


########## Tcl recorder starts at 02/21/12 10:48:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 10:48:07 ###########


########## Tcl recorder starts at 02/21/12 11:19:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:19:54 ###########


########## Tcl recorder starts at 02/21/12 11:19:54 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:19:54 ###########


########## Tcl recorder starts at 02/21/12 11:20:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:20:21 ###########


########## Tcl recorder starts at 02/21/12 11:20:22 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:20:22 ###########


########## Tcl recorder starts at 02/21/12 11:21:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:21:14 ###########


########## Tcl recorder starts at 02/21/12 11:21:15 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:21:15 ###########


########## Tcl recorder starts at 02/21/12 11:22:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:22:00 ###########


########## Tcl recorder starts at 02/21/12 11:22:01 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:22:01 ###########


########## Tcl recorder starts at 02/21/12 11:22:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:22:41 ###########


########## Tcl recorder starts at 02/21/12 11:22:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:22:42 ###########


########## Tcl recorder starts at 02/21/12 11:30:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:30:18 ###########


########## Tcl recorder starts at 02/21/12 11:30:18 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:30:18 ###########


########## Tcl recorder starts at 02/21/12 11:30:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:30:52 ###########


########## Tcl recorder starts at 02/21/12 11:30:53 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:30:53 ###########


########## Tcl recorder starts at 02/21/12 11:32:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:32:33 ###########


########## Tcl recorder starts at 02/21/12 11:32:34 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:32:34 ###########


########## Tcl recorder starts at 02/21/12 11:33:12 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:33:12 ###########


########## Tcl recorder starts at 02/21/12 11:36:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:36:39 ###########


########## Tcl recorder starts at 02/21/12 11:36:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:36:40 ###########


########## Tcl recorder starts at 02/21/12 11:38:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:38:56 ###########


########## Tcl recorder starts at 02/21/12 11:38:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:38:57 ###########


########## Tcl recorder starts at 02/21/12 11:41:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:41:20 ###########


########## Tcl recorder starts at 02/21/12 11:41:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 11:41:21 ###########


########## Tcl recorder starts at 02/21/12 12:23:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:23:03 ###########


########## Tcl recorder starts at 02/21/12 12:23:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:23:04 ###########


########## Tcl recorder starts at 02/21/12 12:24:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:24:27 ###########


########## Tcl recorder starts at 02/21/12 12:24:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:24:28 ###########


########## Tcl recorder starts at 02/21/12 12:28:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:28:57 ###########


########## Tcl recorder starts at 02/21/12 12:28:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:28:58 ###########


########## Tcl recorder starts at 02/21/12 12:34:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:34:48 ###########


########## Tcl recorder starts at 02/21/12 12:34:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:34:49 ###########


########## Tcl recorder starts at 02/21/12 12:36:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:36:11 ###########


########## Tcl recorder starts at 02/21/12 12:36:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:36:12 ###########


########## Tcl recorder starts at 02/21/12 12:37:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:37:12 ###########


########## Tcl recorder starts at 02/21/12 12:37:14 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:37:14 ###########


########## Tcl recorder starts at 02/21/12 12:38:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:38:56 ###########


########## Tcl recorder starts at 02/21/12 12:38:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:38:57 ###########


########## Tcl recorder starts at 02/21/12 12:40:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:40:30 ###########


########## Tcl recorder starts at 02/21/12 12:40:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:40:31 ###########


########## Tcl recorder starts at 02/21/12 12:41:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:41:59 ###########


########## Tcl recorder starts at 02/21/12 12:42:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:42:00 ###########


########## Tcl recorder starts at 02/21/12 12:54:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:54:58 ###########


########## Tcl recorder starts at 02/21/12 12:54:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:55:00 ###########


########## Tcl recorder starts at 02/21/12 12:59:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:59:42 ###########


########## Tcl recorder starts at 02/21/12 12:59:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 12:59:43 ###########


########## Tcl recorder starts at 02/21/12 13:00:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:00:09 ###########


########## Tcl recorder starts at 02/21/12 13:00:10 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:00:10 ###########


########## Tcl recorder starts at 02/21/12 13:07:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:07:28 ###########


########## Tcl recorder starts at 02/21/12 13:07:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:07:29 ###########


########## Tcl recorder starts at 02/21/12 13:08:01 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:08:01 ###########


########## Tcl recorder starts at 02/21/12 13:16:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:16:26 ###########


########## Tcl recorder starts at 02/21/12 13:16:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:16:27 ###########


########## Tcl recorder starts at 02/21/12 13:18:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:18:36 ###########


########## Tcl recorder starts at 02/21/12 13:18:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:18:37 ###########


########## Tcl recorder starts at 02/21/12 13:25:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:25:53 ###########


########## Tcl recorder starts at 02/21/12 13:25:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:25:54 ###########


########## Tcl recorder starts at 02/21/12 13:26:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:26:44 ###########


########## Tcl recorder starts at 02/21/12 13:26:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:26:45 ###########


########## Tcl recorder starts at 02/21/12 13:35:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:35:05 ###########


########## Tcl recorder starts at 02/21/12 13:35:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:35:06 ###########


########## Tcl recorder starts at 02/21/12 13:41:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:41:21 ###########


########## Tcl recorder starts at 02/21/12 13:41:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:41:22 ###########


########## Tcl recorder starts at 02/21/12 13:43:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:43:56 ###########


########## Tcl recorder starts at 02/21/12 13:43:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:43:57 ###########


########## Tcl recorder starts at 02/21/12 13:46:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:46:44 ###########


########## Tcl recorder starts at 02/21/12 13:46:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:46:45 ###########


########## Tcl recorder starts at 02/21/12 13:51:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:51:44 ###########


########## Tcl recorder starts at 02/21/12 13:51:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 13:51:45 ###########


########## Tcl recorder starts at 02/21/12 15:31:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 15:31:26 ###########


########## Tcl recorder starts at 02/21/12 15:31:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 15:31:27 ###########


########## Tcl recorder starts at 02/21/12 16:25:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:25:48 ###########


########## Tcl recorder starts at 02/21/12 16:25:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:25:49 ###########


########## Tcl recorder starts at 02/21/12 16:29:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:29:12 ###########


########## Tcl recorder starts at 02/21/12 16:29:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:29:13 ###########


########## Tcl recorder starts at 02/21/12 16:32:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:32:34 ###########


########## Tcl recorder starts at 02/21/12 16:32:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:32:36 ###########


########## Tcl recorder starts at 02/21/12 16:38:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:38:42 ###########


########## Tcl recorder starts at 02/21/12 16:38:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:38:43 ###########


########## Tcl recorder starts at 02/21/12 16:40:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:40:11 ###########


########## Tcl recorder starts at 02/21/12 16:40:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:40:12 ###########


########## Tcl recorder starts at 02/21/12 16:42:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:42:33 ###########


########## Tcl recorder starts at 02/21/12 16:42:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:42:34 ###########


########## Tcl recorder starts at 02/21/12 16:53:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:53:18 ###########


########## Tcl recorder starts at 02/21/12 16:53:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:53:19 ###########


########## Tcl recorder starts at 02/21/12 16:55:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:55:44 ###########


########## Tcl recorder starts at 02/21/12 16:55:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 16:55:45 ###########


########## Tcl recorder starts at 02/21/12 17:00:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:00:59 ###########


########## Tcl recorder starts at 02/21/12 17:01:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntsc.cmd w} rspFile] {
	puts stderr "Cannot create response file ntsc.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntsc
WORKING_PATH: \"$proj_dir\"
MODULE: ntsc
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs.v
OUTPUT_FILE_NAME: ntsc
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntsc -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntsc.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntsc.edi -out ntsc.bl0 -err automake.err -log ntsc.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntsc.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntsc @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:01:00 ###########


########## Tcl recorder starts at 02/21/12 17:05:03 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/28_NTSCPong_1"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:05:03 ###########


########## Tcl recorder starts at 02/21/12 17:09:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:10:00 ###########


########## Tcl recorder starts at 02/21/12 17:10:00 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:10:00 ###########


########## Tcl recorder starts at 02/21/12 17:10:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:10:56 ###########


########## Tcl recorder starts at 02/21/12 17:10:57 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:10:57 ###########


########## Tcl recorder starts at 02/21/12 17:11:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:11:30 ###########


########## Tcl recorder starts at 02/21/12 17:11:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:11:30 ###########


########## Tcl recorder starts at 02/21/12 17:12:04 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:12:04 ###########


########## Tcl recorder starts at 02/21/12 17:14:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:14:44 ###########


########## Tcl recorder starts at 02/21/12 17:14:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:14:46 ###########


########## Tcl recorder starts at 02/21/12 17:16:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:16:18 ###########


########## Tcl recorder starts at 02/21/12 17:16:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:16:19 ###########


########## Tcl recorder starts at 02/21/12 17:17:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:17:25 ###########


########## Tcl recorder starts at 02/21/12 17:17:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:17:27 ###########


########## Tcl recorder starts at 02/21/12 17:17:57 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:17:57 ###########


########## Tcl recorder starts at 02/21/12 17:19:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:19:40 ###########


########## Tcl recorder starts at 02/21/12 17:19:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:19:41 ###########


########## Tcl recorder starts at 02/21/12 17:20:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:20:37 ###########


########## Tcl recorder starts at 02/21/12 17:20:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:20:38 ###########


########## Tcl recorder starts at 02/21/12 17:21:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:21:07 ###########


########## Tcl recorder starts at 02/21/12 17:21:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:21:08 ###########


########## Tcl recorder starts at 02/21/12 17:24:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:24:57 ###########


########## Tcl recorder starts at 02/21/12 17:24:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:24:58 ###########


########## Tcl recorder starts at 02/21/12 17:26:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:26:00 ###########


########## Tcl recorder starts at 02/21/12 17:26:01 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:26:01 ###########


########## Tcl recorder starts at 02/21/12 17:28:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:28:02 ###########


########## Tcl recorder starts at 02/21/12 17:28:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:28:03 ###########


########## Tcl recorder starts at 02/21/12 17:29:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:29:07 ###########


########## Tcl recorder starts at 02/21/12 17:29:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:29:08 ###########


########## Tcl recorder starts at 02/21/12 17:29:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:29:55 ###########


########## Tcl recorder starts at 02/21/12 17:29:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:29:57 ###########


########## Tcl recorder starts at 02/21/12 17:31:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:31:29 ###########


########## Tcl recorder starts at 02/21/12 17:31:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:31:30 ###########


########## Tcl recorder starts at 02/21/12 17:32:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:32:57 ###########


########## Tcl recorder starts at 02/21/12 17:32:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:32:58 ###########


########## Tcl recorder starts at 02/21/12 17:34:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:34:01 ###########


########## Tcl recorder starts at 02/21/12 17:34:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:34:02 ###########


########## Tcl recorder starts at 02/21/12 17:35:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:35:02 ###########


########## Tcl recorder starts at 02/21/12 17:35:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:35:04 ###########


########## Tcl recorder starts at 02/21/12 17:35:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:35:58 ###########


########## Tcl recorder starts at 02/21/12 17:35:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:35:59 ###########


########## Tcl recorder starts at 02/21/12 17:37:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:37:19 ###########


########## Tcl recorder starts at 02/21/12 17:37:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:37:20 ###########


########## Tcl recorder starts at 02/21/12 17:38:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:38:02 ###########


########## Tcl recorder starts at 02/21/12 17:38:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:38:03 ###########


########## Tcl recorder starts at 02/21/12 17:39:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:39:48 ###########


########## Tcl recorder starts at 02/21/12 17:39:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:39:49 ###########


########## Tcl recorder starts at 02/21/12 17:44:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:44:01 ###########


########## Tcl recorder starts at 02/21/12 17:44:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:44:03 ###########


########## Tcl recorder starts at 02/21/12 17:45:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:45:50 ###########


########## Tcl recorder starts at 02/21/12 17:45:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:45:51 ###########


########## Tcl recorder starts at 02/21/12 17:47:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:47:02 ###########


########## Tcl recorder starts at 02/21/12 17:47:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:47:04 ###########


########## Tcl recorder starts at 02/21/12 17:48:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:48:05 ###########


########## Tcl recorder starts at 02/21/12 17:48:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:48:06 ###########


########## Tcl recorder starts at 02/21/12 17:49:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:49:20 ###########


########## Tcl recorder starts at 02/21/12 17:49:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:49:21 ###########


########## Tcl recorder starts at 02/21/12 17:52:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:52:02 ###########


########## Tcl recorder starts at 02/21/12 17:52:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:52:04 ###########


########## Tcl recorder starts at 02/21/12 17:53:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:53:02 ###########


########## Tcl recorder starts at 02/21/12 17:53:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:53:03 ###########


########## Tcl recorder starts at 02/21/12 17:54:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:54:51 ###########


########## Tcl recorder starts at 02/21/12 17:54:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:54:52 ###########


########## Tcl recorder starts at 02/21/12 17:55:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:55:46 ###########


########## Tcl recorder starts at 02/21/12 17:55:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:55:47 ###########


########## Tcl recorder starts at 02/21/12 17:57:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:57:04 ###########


########## Tcl recorder starts at 02/21/12 17:57:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:57:05 ###########


########## Tcl recorder starts at 02/21/12 17:58:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:58:45 ###########


########## Tcl recorder starts at 02/21/12 17:58:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 17:58:46 ###########


########## Tcl recorder starts at 02/21/12 18:00:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:00:43 ###########


########## Tcl recorder starts at 02/21/12 18:00:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:00:44 ###########


########## Tcl recorder starts at 02/21/12 18:02:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:02:31 ###########


########## Tcl recorder starts at 02/21/12 18:02:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:02:33 ###########


########## Tcl recorder starts at 02/21/12 18:03:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:03:36 ###########


########## Tcl recorder starts at 02/21/12 18:03:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:03:38 ###########


########## Tcl recorder starts at 02/21/12 18:05:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:05:11 ###########


########## Tcl recorder starts at 02/21/12 18:05:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:05:12 ###########


########## Tcl recorder starts at 02/21/12 18:07:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:07:38 ###########


########## Tcl recorder starts at 02/21/12 18:07:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:07:39 ###########


########## Tcl recorder starts at 02/21/12 18:11:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:11:27 ###########


########## Tcl recorder starts at 02/21/12 18:11:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:11:28 ###########


########## Tcl recorder starts at 02/21/12 18:12:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:12:11 ###########


########## Tcl recorder starts at 02/21/12 18:12:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/21/12 18:12:12 ###########


########## Tcl recorder starts at 02/22/12 09:17:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:17:45 ###########


########## Tcl recorder starts at 02/22/12 09:17:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:17:46 ###########


########## Tcl recorder starts at 02/22/12 09:19:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:19:33 ###########


########## Tcl recorder starts at 02/22/12 09:19:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:19:34 ###########


########## Tcl recorder starts at 02/22/12 09:20:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:20:57 ###########


########## Tcl recorder starts at 02/22/12 09:20:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:20:58 ###########


########## Tcl recorder starts at 02/22/12 09:54:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:54:12 ###########


########## Tcl recorder starts at 02/22/12 09:54:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:54:13 ###########


########## Tcl recorder starts at 02/22/12 09:57:40 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:57:40 ###########


########## Tcl recorder starts at 02/22/12 09:58:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:58:06 ###########


########## Tcl recorder starts at 02/22/12 09:58:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:58:07 ###########


########## Tcl recorder starts at 02/22/12 09:58:33 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 09:58:33 ###########


########## Tcl recorder starts at 02/22/12 10:01:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:01:18 ###########


########## Tcl recorder starts at 02/22/12 10:01:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:01:19 ###########


########## Tcl recorder starts at 02/22/12 10:02:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:02:24 ###########


########## Tcl recorder starts at 02/22/12 10:02:25 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:02:25 ###########


########## Tcl recorder starts at 02/22/12 10:14:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ntcs_pong.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:14:55 ###########


########## Tcl recorder starts at 02/22/12 10:14:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open ntscPong.cmd w} rspFile] {
	puts stderr "Cannot create response file ntscPong.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ntscPong
WORKING_PATH: \"$proj_dir\"
MODULE: ntscPong
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h ntcs_pong.v
OUTPUT_FILE_NAME: ntscPong
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ntscPong -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ntscPong.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ntscPong.edi -out ntscPong.bl0 -err automake.err -log ntscPong.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" ntscPong.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"ntscPong.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj mach64_verilog_project -lci mach64_verilog_project.lct -log mach64_verilog_project.imp -err automake.err -tti mach64_verilog_project.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -blifopt mach64_verilog_project.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" mach64_verilog_project.bl2 -sweep -mergefb -err automake.err -o mach64_verilog_project.bl3 @mach64_verilog_project.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -diofft mach64_verilog_project.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" mach64_verilog_project.bl3 -family AMDMACH -idev van -o mach64_verilog_project.bl4 -oxrf mach64_verilog_project.xrf -err automake.err @mach64_verilog_project.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci mach64_verilog_project.lct -dev lc4k -prefit mach64_verilog_project.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod ntscPong @mach64_verilog_project.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open mach64_verilog_project.rs1 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs1: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -nojed -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open mach64_verilog_project.rs2 w} rspFile] {
	puts stderr "Cannot create response file mach64_verilog_project.rs2: $rspFile"
} else {
	puts $rspFile "-i mach64_verilog_project.bl5 -lci mach64_verilog_project.lct -d m4s_64_32 -lco mach64_verilog_project.lco -html_rpt -fti mach64_verilog_project.fti -fmt PLA -tto mach64_verilog_project.tt4 -eqn mach64_verilog_project.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@mach64_verilog_project.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete mach64_verilog_project.rs1
file delete mach64_verilog_project.rs2
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod ntscPong -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj mach64_verilog_project -if mach64_verilog_project.jed -j2s -log mach64_verilog_project.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/22/12 10:14:56 ###########

