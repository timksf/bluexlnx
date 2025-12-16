package IBUFDS;

import Clocks :: *;
import DefaultValue :: *;

(* always_enabled *)
interface IBUFDSClock_ifc;
    interface Clock clk_o;
endinterface

typedef struct {
    Bool    p_DIFF_TERM;
    Bool    p_IBUF_LOW_PWR;
    String  p_IOSTANDARD;
} IBUFDS_Config;

instance DefaultValue#(IBUFDS_Config);
    function defaultValue = IBUFDS_Config { 
        p_DIFF_TERM: False, 
        p_IBUF_LOW_PWR: True,
        p_IOSTANDARD: "DEFAULT"
    };
endinstance

import "BVI" IBUFDS = 
module vMkIBUFDSClock#(IBUFDS_Config cfg, Clock clk_p, Clock clk_n)(IBUFDSClock_ifc);

    parameter DIFF_TERM     = cfg.p_DIFF_TERM;
    parameter IBUF_LOW_PWR  = cfg.p_IBUF_LOW_PWR;
    parameter IOSTANDARD    = cfg.p_IOSTANDARD;

    default_clock no_clock;
    default_reset no_reset;

    input_clock clk_p(I)    = clk_p;
    input_clock clk_n(IB)   = clk_n;

    output_clock clk_o(O);

    path(I,  O);
    path(IB, O);

    same_family(clk_p, clk_o);

endmodule

module mkIBUFDSClock#(IBUFDS_Config cfg, Clock clk_p, Clock clk_n)(Clock);
   let _int <- vMkIBUFDSClock(cfg, clk_p, clk_n);
   return _int.clk_o;
endmodule


endpackage