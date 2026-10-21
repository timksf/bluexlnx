package ClockWires;

import Clocks :: *;

interface ClockWire_ifc;
    interface Clock clk;
    method Action drive(Bit#(1) value);
endinterface

import "BVI" BlueXLNXBitToClock =
module mkClockWire(ClockWire_ifc);
    default_clock control_clk();
    default_reset no_reset;
    output_clock clk(WGET);
    method drive(WVAL) enable((*inhigh*) EN);
    schedule drive C drive;
endmodule

import "BVI" BlueXLNXClockToBit =
module mkClockValue#(Clock clk_in)(ReadOnly#(Bit#(1)));
    default_clock no_clock;
    default_reset no_reset;
    input_clock clk_in(WVAL, (*unused*) clk_gate) = clk_in;
    method WGET _read() clocked_by(no_clock) reset_by(no_reset);
    schedule _read CF _read;
endmodule

interface ResetWire_ifc;
    interface Reset rst;
endinterface

import "BVI" BlueXLNXBitToReset =
module mkResetWire#(Bit#(1) reset_n)(ResetWire_ifc);
    default_clock no_clock;
    default_reset no_reset;
    port WVAL = reset_n;
    output_reset rst(WGET) clocked_by(no_clock);
endmodule

endpackage
