
########## Tcl recorder starts at 01/31/12 14:55:04 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/16_KeypadScanner"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 14:55:04 ###########


########## Tcl recorder starts at 01/31/12 14:58:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 14:58:58 ###########


########## Tcl recorder starts at 01/31/12 14:58:59 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 14:58:59 ###########


########## Tcl recorder starts at 01/31/12 15:28:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:28:54 ###########


########## Tcl recorder starts at 01/31/12 15:28:55 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:28:55 ###########


########## Tcl recorder starts at 01/31/12 15:29:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:29:57 ###########


########## Tcl recorder starts at 01/31/12 15:29:59 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:29:59 ###########


########## Tcl recorder starts at 01/31/12 15:31:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:31:06 ###########


########## Tcl recorder starts at 01/31/12 15:31:07 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:31:07 ###########


########## Tcl recorder starts at 01/31/12 15:33:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:33:55 ###########


########## Tcl recorder starts at 01/31/12 15:33:57 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:33:57 ###########


########## Tcl recorder starts at 01/31/12 15:34:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:34:35 ###########


########## Tcl recorder starts at 01/31/12 15:34:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:34:36 ###########


########## Tcl recorder starts at 01/31/12 15:35:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:35:24 ###########


########## Tcl recorder starts at 01/31/12 15:35:25 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:35:25 ###########


########## Tcl recorder starts at 01/31/12 15:37:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:37:04 ###########


########## Tcl recorder starts at 01/31/12 15:37:06 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:37:06 ###########


########## Tcl recorder starts at 01/31/12 15:47:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:47:34 ###########


########## Tcl recorder starts at 01/31/12 15:47:35 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:47:35 ###########


########## Tcl recorder starts at 01/31/12 15:48:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:48:15 ###########


########## Tcl recorder starts at 01/31/12 15:48:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:48:17 ###########


########## Tcl recorder starts at 01/31/12 15:48:37 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:48:37 ###########


########## Tcl recorder starts at 01/31/12 15:49:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:49:49 ###########


########## Tcl recorder starts at 01/31/12 15:49:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:49:51 ###########


########## Tcl recorder starts at 01/31/12 15:50:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:50:30 ###########


########## Tcl recorder starts at 01/31/12 15:50:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:50:32 ###########


########## Tcl recorder starts at 01/31/12 15:55:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:55:34 ###########


########## Tcl recorder starts at 01/31/12 15:55:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:55:36 ###########


########## Tcl recorder starts at 01/31/12 15:56:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:56:19 ###########


########## Tcl recorder starts at 01/31/12 15:56:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:56:22 ###########


########## Tcl recorder starts at 01/31/12 15:57:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:57:23 ###########


########## Tcl recorder starts at 01/31/12 15:57:25 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:57:25 ###########


########## Tcl recorder starts at 01/31/12 15:58:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 15:58:52 ###########


########## Tcl recorder starts at 01/31/12 15:58:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 15:58:54 ###########


########## Tcl recorder starts at 01/31/12 16:47:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 16:47:51 ###########


########## Tcl recorder starts at 01/31/12 16:47:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 16:47:54 ###########


########## Tcl recorder starts at 01/31/12 16:55:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 16:55:21 ###########


########## Tcl recorder starts at 01/31/12 16:55:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 16:55:24 ###########


########## Tcl recorder starts at 01/31/12 16:59:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 16:59:54 ###########


########## Tcl recorder starts at 01/31/12 16:59:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 16:59:57 ###########


########## Tcl recorder starts at 01/31/12 17:00:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:00:31 ###########


########## Tcl recorder starts at 01/31/12 17:00:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:00:33 ###########


########## Tcl recorder starts at 01/31/12 17:04:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:04:44 ###########


########## Tcl recorder starts at 01/31/12 17:04:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:04:46 ###########


########## Tcl recorder starts at 01/31/12 17:05:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:05:28 ###########


########## Tcl recorder starts at 01/31/12 17:05:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:05:31 ###########


########## Tcl recorder starts at 01/31/12 17:17:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:17:42 ###########


########## Tcl recorder starts at 01/31/12 17:17:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:17:44 ###########


########## Tcl recorder starts at 01/31/12 17:19:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:19:07 ###########


########## Tcl recorder starts at 01/31/12 17:19:10 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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

########## Tcl recorder end at 01/31/12 17:19:10 ###########


########## Tcl recorder starts at 01/31/12 17:19:37 ##########

# Commands to make the Process: 
# Fit Design
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:19:37 ###########


########## Tcl recorder starts at 01/31/12 17:20:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:20:04 ###########


########## Tcl recorder starts at 01/31/12 17:20:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:20:37 ###########


########## Tcl recorder starts at 01/31/12 17:20:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:20:40 ###########


########## Tcl recorder starts at 01/31/12 17:35:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:35:11 ###########


########## Tcl recorder starts at 01/31/12 17:35:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:35:14 ###########


########## Tcl recorder starts at 01/31/12 17:36:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:36:07 ###########


########## Tcl recorder starts at 01/31/12 17:36:10 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:36:10 ###########


########## Tcl recorder starts at 01/31/12 17:41:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:41:44 ###########


########## Tcl recorder starts at 01/31/12 17:41:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:41:46 ###########


########## Tcl recorder starts at 01/31/12 17:46:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:46:21 ###########


########## Tcl recorder starts at 01/31/12 17:46:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:46:23 ###########


########## Tcl recorder starts at 01/31/12 17:59:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:59:22 ###########


########## Tcl recorder starts at 01/31/12 17:59:24 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 17:59:24 ###########


########## Tcl recorder starts at 01/31/12 17:59:53 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 17:59:53 ###########


########## Tcl recorder starts at 01/31/12 18:02:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:02:36 ###########


########## Tcl recorder starts at 01/31/12 18:02:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:02:38 ###########


########## Tcl recorder starts at 01/31/12 18:06:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:06:50 ###########


########## Tcl recorder starts at 01/31/12 18:06:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:06:52 ###########


########## Tcl recorder starts at 01/31/12 18:07:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:07:29 ###########


########## Tcl recorder starts at 01/31/12 18:07:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:07:31 ###########


########## Tcl recorder starts at 01/31/12 18:08:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:08:32 ###########


########## Tcl recorder starts at 01/31/12 18:08:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:08:35 ###########


########## Tcl recorder starts at 01/31/12 18:09:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:09:45 ###########


########## Tcl recorder starts at 01/31/12 18:09:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:09:48 ###########


########## Tcl recorder starts at 01/31/12 18:21:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:21:19 ###########


########## Tcl recorder starts at 01/31/12 18:21:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:21:22 ###########


########## Tcl recorder starts at 01/31/12 18:21:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:21:56 ###########


########## Tcl recorder starts at 01/31/12 18:21:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:21:58 ###########


########## Tcl recorder starts at 01/31/12 18:28:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 18:28:57 ###########


########## Tcl recorder starts at 01/31/12 18:29:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 18:29:00 ###########


########## Tcl recorder starts at 01/31/12 20:05:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:05:53 ###########


########## Tcl recorder starts at 01/31/12 20:05:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:05:56 ###########


########## Tcl recorder starts at 01/31/12 20:10:11 ##########

# Commands to make the Process: 
# Constraint Editor
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

########## Tcl recorder end at 01/31/12 20:10:11 ###########


########## Tcl recorder starts at 01/31/12 20:13:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:13:40 ###########


########## Tcl recorder starts at 01/31/12 20:13:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:13:43 ###########


########## Tcl recorder starts at 01/31/12 20:16:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:16:14 ###########


########## Tcl recorder starts at 01/31/12 20:16:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:16:17 ###########


########## Tcl recorder starts at 01/31/12 20:16:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:16:45 ###########


########## Tcl recorder starts at 01/31/12 20:16:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:16:47 ###########


########## Tcl recorder starts at 01/31/12 20:20:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:20:47 ###########


########## Tcl recorder starts at 01/31/12 20:20:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:20:49 ###########


########## Tcl recorder starts at 01/31/12 20:22:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:22:27 ###########


########## Tcl recorder starts at 01/31/12 20:22:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:22:29 ###########


########## Tcl recorder starts at 01/31/12 20:24:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:24:48 ###########


########## Tcl recorder starts at 01/31/12 20:24:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:24:50 ###########


########## Tcl recorder starts at 01/31/12 20:29:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:29:33 ###########


########## Tcl recorder starts at 01/31/12 20:29:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:29:35 ###########


########## Tcl recorder starts at 01/31/12 20:30:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:30:40 ###########


########## Tcl recorder starts at 01/31/12 20:30:42 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:30:42 ###########


########## Tcl recorder starts at 01/31/12 20:51:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:51:58 ###########


########## Tcl recorder starts at 01/31/12 20:52:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:52:00 ###########


########## Tcl recorder starts at 01/31/12 20:56:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 20:56:50 ###########


########## Tcl recorder starts at 01/31/12 20:56:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 20:56:52 ###########


########## Tcl recorder starts at 01/31/12 21:03:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:03:27 ###########


########## Tcl recorder starts at 01/31/12 21:03:41 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:03:41 ###########


########## Tcl recorder starts at 01/31/12 21:04:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:04:46 ###########


########## Tcl recorder starts at 01/31/12 21:04:48 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:04:48 ###########


########## Tcl recorder starts at 01/31/12 21:05:31 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 21:05:31 ###########


########## Tcl recorder starts at 01/31/12 21:10:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:10:38 ###########


########## Tcl recorder starts at 01/31/12 21:10:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 21:10:40 ###########


########## Tcl recorder starts at 01/31/12 21:16:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:16:45 ###########


########## Tcl recorder starts at 01/31/12 21:16:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 21:16:48 ###########


########## Tcl recorder starts at 01/31/12 21:26:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:26:50 ###########


########## Tcl recorder starts at 01/31/12 21:26:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 21:26:53 ###########


########## Tcl recorder starts at 01/31/12 21:28:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keypadscannerdemo.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/31/12 21:28:07 ###########


########## Tcl recorder starts at 01/31/12 21:28:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/31/12 21:28:09 ###########


########## Tcl recorder starts at 02/01/12 12:03:24 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/16_KeypadScanner_1"
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
if [catch {open KeypadScannerDemo.cmd w} rspFile] {
	puts stderr "Cannot create response file KeypadScannerDemo.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: KeypadScannerDemo
WORKING_PATH: \"$proj_dir\"
MODULE: KeypadScannerDemo
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h keypadscannerdemo.v
OUTPUT_FILE_NAME: KeypadScannerDemo
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KeypadScannerDemo -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KeypadScannerDemo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KeypadScannerDemo.edi -out KeypadScannerDemo.bl0 -err automake.err -log KeypadScannerDemo.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KeypadScannerDemo.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"KeypadScannerDemo.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod KeypadScannerDemo @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod KeypadScannerDemo -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 02/01/12 12:03:24 ###########


########## Tcl recorder starts at 02/01/12 12:04:19 ##########

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

########## Tcl recorder end at 02/01/12 12:04:19 ###########

