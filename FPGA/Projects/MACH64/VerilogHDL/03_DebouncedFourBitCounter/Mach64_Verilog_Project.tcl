
########## Tcl recorder starts at 01/17/12 20:19:50 ##########

set version "1.5"
set proj_dir "C:/Users/tmcphillips/Designs/Projects/MACH64/VerilogHDL/7.3Lab03/03_DebouncedFourBitCounter"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:19:50 ###########


########## Tcl recorder starts at 01/17/12 20:41:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:41:40 ###########


########## Tcl recorder starts at 01/17/12 20:45:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:45:05 ###########


########## Tcl recorder starts at 01/17/12 20:45:05 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:45:05 ###########


########## Tcl recorder starts at 01/17/12 20:45:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:45:43 ###########


########## Tcl recorder starts at 01/17/12 20:45:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:45:44 ###########


########## Tcl recorder starts at 01/17/12 20:53:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:53:29 ###########


########## Tcl recorder starts at 01/17/12 20:53:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:53:30 ###########


########## Tcl recorder starts at 01/17/12 20:54:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:54:54 ###########


########## Tcl recorder starts at 01/17/12 20:54:54 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:54:54 ###########


########## Tcl recorder starts at 01/17/12 20:56:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:56:08 ###########


########## Tcl recorder starts at 01/17/12 20:56:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:56:08 ###########


########## Tcl recorder starts at 01/17/12 20:56:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:56:36 ###########


########## Tcl recorder starts at 01/17/12 20:56:37 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:56:37 ###########


########## Tcl recorder starts at 01/17/12 20:57:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:57:20 ###########


########## Tcl recorder starts at 01/17/12 20:57:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h tenbitscaler.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:57:21 ###########


########## Tcl recorder starts at 01/17/12 20:58:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" tenbitscaler.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 20:58:44 ###########


########## Tcl recorder starts at 01/17/12 21:03:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:03:07 ###########


########## Tcl recorder starts at 01/17/12 21:03:07 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open Debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file Debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: Debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: Debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncer.v
OUTPUT_FILE_NAME: Debouncer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Debouncer.edi -out Debouncer.bl0 -err automake.err -log Debouncer.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:03:07 ###########


########## Tcl recorder starts at 01/17/12 21:03:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:03:44 ###########


########## Tcl recorder starts at 01/17/12 21:03:45 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open Debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file Debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: Debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: Debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncer.v
OUTPUT_FILE_NAME: Debouncer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Debouncer.edi -out Debouncer.bl0 -err automake.err -log Debouncer.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:03:45 ###########


########## Tcl recorder starts at 01/17/12 21:11:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:11:43 ###########


########## Tcl recorder starts at 01/17/12 21:12:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:12:28 ###########


########## Tcl recorder starts at 01/17/12 21:12:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/17/12 21:12:43 ###########


########## Tcl recorder starts at 01/17/12 21:15:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:15:16 ###########


########## Tcl recorder starts at 01/17/12 21:15:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open Debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file Debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: Debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: Debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: Debouncer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Debouncer.edi -out Debouncer.bl0 -err automake.err -log Debouncer.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:15:16 ###########


########## Tcl recorder starts at 01/17/12 21:16:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:16:17 ###########


########## Tcl recorder starts at 01/17/12 21:16:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open Debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file Debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: Debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: Debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: Debouncer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Debouncer.edi -out Debouncer.bl0 -err automake.err -log Debouncer.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:16:17 ###########


########## Tcl recorder starts at 01/17/12 21:16:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/17/12 21:16:37 ###########


########## Tcl recorder starts at 01/17/12 21:19:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:19:28 ###########


########## Tcl recorder starts at 01/17/12 21:19:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/17/12 21:19:29 ###########


########## Tcl recorder starts at 01/17/12 21:21:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:21:11 ###########


########## Tcl recorder starts at 01/17/12 21:21:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/17/12 21:21:12 ###########


########## Tcl recorder starts at 01/17/12 21:22:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/17/12 21:22:30 ###########


########## Tcl recorder starts at 01/17/12 21:22:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/17/12 21:22:31 ###########


########## Tcl recorder starts at 01/18/12 09:28:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:28:51 ###########


########## Tcl recorder starts at 01/18/12 09:28:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:28:52 ###########


########## Tcl recorder starts at 01/18/12 09:30:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:30:13 ###########


########## Tcl recorder starts at 01/18/12 09:30:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:30:14 ###########


########## Tcl recorder starts at 01/18/12 09:31:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:31:17 ###########


########## Tcl recorder starts at 01/18/12 09:31:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:31:18 ###########


########## Tcl recorder starts at 01/18/12 09:33:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:33:13 ###########


########## Tcl recorder starts at 01/18/12 09:33:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:33:14 ###########


########## Tcl recorder starts at 01/18/12 09:34:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:34:35 ###########


########## Tcl recorder starts at 01/18/12 09:34:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:34:36 ###########


########## Tcl recorder starts at 01/18/12 09:37:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:37:54 ###########


########## Tcl recorder starts at 01/18/12 09:37:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:37:54 ###########


########## Tcl recorder starts at 01/18/12 09:40:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:40:12 ###########


########## Tcl recorder starts at 01/18/12 09:46:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:46:30 ###########


########## Tcl recorder starts at 01/18/12 09:47:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:47:42 ###########


########## Tcl recorder starts at 01/18/12 09:47:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:47:43 ###########


########## Tcl recorder starts at 01/18/12 09:48:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:48:36 ###########


########## Tcl recorder starts at 01/18/12 09:48:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:48:36 ###########


########## Tcl recorder starts at 01/18/12 09:52:13 ##########

# Commands to make the Process: 
# Compiled Equations
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" TenBitScaler.bl0 -o TenBitScaler.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:52:13 ###########


########## Tcl recorder starts at 01/18/12 09:57:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:57:49 ###########


########## Tcl recorder starts at 01/18/12 09:57:49 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open TenBitScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file TenBitScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: TenBitScaler
WORKING_PATH: \"$proj_dir\"
MODULE: TenBitScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: TenBitScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e TenBitScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete TenBitScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf TenBitScaler.edi -out TenBitScaler.bl0 -err automake.err -log TenBitScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:57:49 ###########


########## Tcl recorder starts at 01/18/12 09:59:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:59:10 ###########


########## Tcl recorder starts at 01/18/12 09:59:10 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 09:59:10 ###########


########## Tcl recorder starts at 01/18/12 09:59:31 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 09:59:31 ###########


########## Tcl recorder starts at 01/18/12 10:03:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:03:16 ###########


########## Tcl recorder starts at 01/18/12 10:03:17 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:03:17 ###########


########## Tcl recorder starts at 01/18/12 10:03:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:03:34 ###########


########## Tcl recorder starts at 01/18/12 10:05:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:05:27 ###########


########## Tcl recorder starts at 01/18/12 10:05:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:05:28 ###########


########## Tcl recorder starts at 01/18/12 10:07:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:07:19 ###########


########## Tcl recorder starts at 01/18/12 10:07:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:07:20 ###########


########## Tcl recorder starts at 01/18/12 10:12:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:12:02 ###########


########## Tcl recorder starts at 01/18/12 10:12:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:12:03 ###########


########## Tcl recorder starts at 01/18/12 10:13:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:13:44 ###########


########## Tcl recorder starts at 01/18/12 10:13:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:13:45 ###########


########## Tcl recorder starts at 01/18/12 10:14:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:14:57 ###########


########## Tcl recorder starts at 01/18/12 10:14:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:14:58 ###########


########## Tcl recorder starts at 01/18/12 10:20:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:20:09 ###########


########## Tcl recorder starts at 01/18/12 10:20:10 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:20:10 ###########


########## Tcl recorder starts at 01/18/12 10:24:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:24:56 ###########


########## Tcl recorder starts at 01/18/12 10:24:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:24:57 ###########


########## Tcl recorder starts at 01/18/12 10:48:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:48:42 ###########


########## Tcl recorder starts at 01/18/12 10:48:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:48:43 ###########


########## Tcl recorder starts at 01/18/12 10:50:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:50:10 ###########


########## Tcl recorder starts at 01/18/12 10:51:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:51:31 ###########


########## Tcl recorder starts at 01/18/12 10:55:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:55:31 ###########


########## Tcl recorder starts at 01/18/12 10:55:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:55:32 ###########


########## Tcl recorder starts at 01/18/12 10:56:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:56:17 ###########


########## Tcl recorder starts at 01/18/12 10:56:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:56:18 ###########


########## Tcl recorder starts at 01/18/12 10:57:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:57:42 ###########


########## Tcl recorder starts at 01/18/12 10:57:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:57:43 ###########


########## Tcl recorder starts at 01/18/12 10:58:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 10:58:40 ###########


########## Tcl recorder starts at 01/18/12 10:58:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 10:58:41 ###########


########## Tcl recorder starts at 01/18/12 11:01:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:01:38 ###########


########## Tcl recorder starts at 01/18/12 11:01:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:01:39 ###########


########## Tcl recorder starts at 01/18/12 11:02:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:02:37 ###########


########## Tcl recorder starts at 01/18/12 11:02:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:02:38 ###########


########## Tcl recorder starts at 01/18/12 11:07:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:07:15 ###########


########## Tcl recorder starts at 01/18/12 11:07:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:07:16 ###########


########## Tcl recorder starts at 01/18/12 11:07:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:07:57 ###########


########## Tcl recorder starts at 01/18/12 11:07:57 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:07:57 ###########


########## Tcl recorder starts at 01/18/12 11:08:16 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:08:16 ###########


########## Tcl recorder starts at 01/18/12 11:10:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:10:49 ###########


########## Tcl recorder starts at 01/18/12 11:10:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:10:50 ###########


########## Tcl recorder starts at 01/18/12 11:12:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:12:25 ###########


########## Tcl recorder starts at 01/18/12 11:12:26 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:12:26 ###########


########## Tcl recorder starts at 01/18/12 11:18:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 11:18:05 ###########


########## Tcl recorder starts at 01/18/12 11:18:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 11:18:06 ###########


########## Tcl recorder starts at 01/18/12 11:20:27 ##########

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

########## Tcl recorder end at 01/18/12 11:20:27 ###########


########## Tcl recorder starts at 01/18/12 17:42:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:42:42 ###########


########## Tcl recorder starts at 01/18/12 17:42:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:42:42 ###########


########## Tcl recorder starts at 01/18/12 17:43:09 ##########

# Commands to make the Process: 
# Compiled Equations
if [catch {open Debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file Debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: Debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: Debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: Debouncer
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Debouncer.edi -out Debouncer.bl0 -err automake.err -log Debouncer.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" Debouncer.bl0 -o Debouncer.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:43:09 ###########


########## Tcl recorder starts at 01/18/12 17:44:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:44:20 ###########


########## Tcl recorder starts at 01/18/12 17:44:21 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:44:21 ###########


########## Tcl recorder starts at 01/18/12 17:45:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:45:09 ###########


########## Tcl recorder starts at 01/18/12 17:45:10 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:45:10 ###########


########## Tcl recorder starts at 01/18/12 17:46:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:46:16 ###########


########## Tcl recorder starts at 01/18/12 17:46:16 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open ClockScaler.cmd w} rspFile] {
	puts stderr "Cannot create response file ClockScaler.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: ClockScaler
WORKING_PATH: \"$proj_dir\"
MODULE: ClockScaler
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: ClockScaler
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e ClockScaler -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ClockScaler.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf ClockScaler.edi -out ClockScaler.bl0 -err automake.err -log ClockScaler.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:46:16 ###########


########## Tcl recorder starts at 01/18/12 17:46:35 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" ClockScaler.bl0 -o ClockScaler.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:46:35 ###########


########## Tcl recorder starts at 01/18/12 17:47:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:47:44 ###########


########## Tcl recorder starts at 01/18/12 17:47:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:47:45 ###########


########## Tcl recorder starts at 01/18/12 17:48:40 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" DebouncedFourBitCounter.bl0 -o DebouncedFourBitCounter.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:48:40 ###########


########## Tcl recorder starts at 01/18/12 17:51:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:51:08 ###########


########## Tcl recorder starts at 01/18/12 17:51:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 17:51:09 ###########


########## Tcl recorder starts at 01/18/12 17:52:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:52:35 ###########


########## Tcl recorder starts at 01/18/12 17:52:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 17:52:36 ###########


########## Tcl recorder starts at 01/18/12 17:54:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 17:54:40 ###########


########## Tcl recorder starts at 01/18/12 17:54:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 17:54:41 ###########


########## Tcl recorder starts at 01/18/12 18:05:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:05:14 ###########


########## Tcl recorder starts at 01/18/12 18:05:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:05:15 ###########


########## Tcl recorder starts at 01/18/12 18:06:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:06:15 ###########


########## Tcl recorder starts at 01/18/12 18:06:16 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:06:16 ###########


########## Tcl recorder starts at 01/18/12 18:07:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:07:08 ###########


########## Tcl recorder starts at 01/18/12 18:07:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:07:09 ###########


########## Tcl recorder starts at 01/18/12 18:08:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:08:28 ###########


########## Tcl recorder starts at 01/18/12 18:08:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:08:29 ###########


########## Tcl recorder starts at 01/18/12 18:12:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:12:00 ###########


########## Tcl recorder starts at 01/18/12 18:12:01 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:12:01 ###########


########## Tcl recorder starts at 01/18/12 18:12:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:12:54 ###########


########## Tcl recorder starts at 01/18/12 18:12:55 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:12:55 ###########


########## Tcl recorder starts at 01/18/12 18:13:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:13:58 ###########


########## Tcl recorder starts at 01/18/12 18:13:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:14:00 ###########


########## Tcl recorder starts at 01/18/12 18:16:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:16:29 ###########


########## Tcl recorder starts at 01/18/12 18:16:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:16:30 ###########


########## Tcl recorder starts at 01/18/12 18:18:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:18:17 ###########


########## Tcl recorder starts at 01/18/12 18:18:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:18:18 ###########


########## Tcl recorder starts at 01/18/12 18:21:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:21:45 ###########


########## Tcl recorder starts at 01/18/12 18:21:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:21:46 ###########


########## Tcl recorder starts at 01/18/12 18:22:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:22:09 ###########


########## Tcl recorder starts at 01/18/12 18:22:10 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:22:10 ###########


########## Tcl recorder starts at 01/18/12 18:24:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:24:18 ###########


########## Tcl recorder starts at 01/18/12 18:24:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:24:19 ###########


########## Tcl recorder starts at 01/18/12 18:34:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncedfourbitcounter.v -p \"$install_dir/ispcpld/generic\" -predefine mach64_verilog_project.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 18:34:24 ###########


########## Tcl recorder starts at 01/18/12 18:35:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 18:35:53 ###########


########## Tcl recorder starts at 01/18/12 21:09:34 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/18/12 21:09:34 ###########


########## Tcl recorder starts at 01/18/12 21:11:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 21:11:32 ###########


########## Tcl recorder starts at 01/18/12 21:57:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 21:57:21 ###########


########## Tcl recorder starts at 01/18/12 22:09:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DebouncedFourBitCounter.cmd w} rspFile] {
	puts stderr "Cannot create response file DebouncedFourBitCounter.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: mach64_verilog_project.sty
PROJECT: DebouncedFourBitCounter
WORKING_PATH: \"$proj_dir\"
MODULE: DebouncedFourBitCounter
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" mach64_verilog_project.h debouncedfourbitcounter.v
OUTPUT_FILE_NAME: DebouncedFourBitCounter
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DebouncedFourBitCounter -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DebouncedFourBitCounter.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DebouncedFourBitCounter.edi -out DebouncedFourBitCounter.bl0 -err automake.err -log DebouncedFourBitCounter.log -prj mach64_verilog_project -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DebouncedFourBitCounter.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"DebouncedFourBitCounter.bl1\" -o \"mach64_verilog_project.bl2\" -omod \"mach64_verilog_project\"  -err \"automake.err\""] {
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
if [runCmd "\"$cpld_bin/prefit\" -blif -inp mach64_verilog_project.bl4 -out mach64_verilog_project.bl5 -err automake.err -log mach64_verilog_project.log -mod DebouncedFourBitCounter @mach64_verilog_project.l0  -sc"] {
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
if [runCmd "\"$cpld_bin/tda\" -i mach64_verilog_project.bl5 -o mach64_verilog_project.tda -lci mach64_verilog_project.lct -dev m4s_64_32 -family lc4k -mod DebouncedFourBitCounter -ovec NoInput.tmv -err tda.err "] {
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

########## Tcl recorder end at 01/18/12 22:09:28 ###########

