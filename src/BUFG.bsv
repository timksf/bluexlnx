package BUFG;

import Clocks :: *;

interface BUFGClock_ifc;
    interface Clock clk_o;
endinterface

import "BVI" BUFG =
module vMkBUFGClock#(Clock clk_i)(BUFGClock_ifc);
    default_clock no_clock;
    default_reset no_reset;

    input_clock clk_i(I) = clk_i;
    output_clock clk_o(O);
    ancestor(clk_o, clk_i);
    path(I, O);
endmodule

module mkBUFGClock#(Clock clk_i)(Clock);
    let i_bufg <- vMkBUFGClock(clk_i);
    return i_bufg.clk_o;
endmodule

interface BUFG_ifc;
    method Bit#(1) out();
endinterface

interface BUFG_bit_ifc;
    method Bit#(1) out();
endinterface

import "BVI" BUFG = 
module vMkBUFGBit(BUFG_bit_ifc);

    default_clock clk(I);
    default_reset no_reset;

    method O out ();    

    schedule out CF out;

    path(I, O);

endmodule

module mkBUFGBit(BUFG_bit_ifc);
    (* hide *)
    let _int <- vMkBUFGBit;
    return _int;
endmodule

endpackage
