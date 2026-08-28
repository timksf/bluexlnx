package IOBUF;

import Clocks :: *;
import Vector :: *;
import DefaultValue :: *;

(* always_enabled *)
interface IOBUF_ifc;
    //naming is reversed from IOBUF 
    method Action  o(Bit#(1) b);
    method Action  oe(Bit#(1) b);
    method Bit#(1) i();

    interface Inout#(Bit#(1)) io;
endinterface

(* always_enabled *)
interface IOBUFs_ifc#(numeric type n);
    method Action  o(Bit#(n) b);
    method Action  oe(Bit#(n) b);
    method Bit#(n) i();

    interface Vector#(n, Inout#(Bit#(1))) io;
endinterface

typedef struct {
    Integer p_DRIVE;
    String  p_IOSTANDARD;
    String  p_SLEW;
} IOBUF_Config_t;

instance DefaultValue#(IOBUF_Config_t);
    function defaultValue = IOBUF_Config_t { 
        p_DRIVE:        12, 
        p_IOSTANDARD:   "DEFAULT",
        p_SLEW:         "SLOW"
    };
endinstance

import "BVI" IOBUF = 
module vMkIOBUF#(IOBUF_Config_t cfg)(IOBUF_ifc);

    parameter DRIVE         = cfg.p_DRIVE;
    parameter IOSTANDARD    = cfg.p_IOSTANDARD;
    parameter SLEW          = cfg.p_SLEW;

    //default clocks to make action methods callable, not attached to any pins
    default_clock clk();
    default_reset rst();

    //the input I to this module is routed to the PAD when OE=1
    method o    (I) enable((*inhigh*) EN_O);
    method oe   (T) enable((*inhigh*) EN_OE);

    method O i();

    //pad
    ifc_inout io(IO);

    path(I, O);
    path(T, O);

    schedule (o, oe, i) CF (o, oe, i);

endmodule

module mkIOBUF#(IOBUF_Config_t cfg)(IOBUF_ifc);
    let i_iobuf <- vMkIOBUF(cfg);

    method o        = i_iobuf.o;
    method i        = i_iobuf.i;

    method Action oe(Bit#(1) b);
        i_iobuf.oe(~b);
    endmethod

    interface io    = i_iobuf.io;

endmodule

module mkIOBUFs#(IOBUF_Config_t cfg)(IOBUFs_ifc#(n));

    function Inout#(Bit#(1)) get_io(IOBUF_ifc i_iobuf);
        return i_iobuf.io;
    endfunction

    Vector#(n, IOBUF_ifc) i_iobufs <- replicateM(mkIOBUF(cfg));

    method o(bs) = action
        for(Integer idx = 0; idx < valueof(n); idx = idx + 1) begin
            i_iobufs[idx].o(bs[idx]);
        end
    endaction;

    method oe(oes) = action
        for(Integer idx = 0; idx < valueof(n); idx = idx + 1) begin
            i_iobufs[idx].oe(oes[idx]);
        end
    endaction;

    method Bit#(n) i();
        Bit#(n) r = 0;
        for(Integer idx = 0; idx < valueof(n); idx = idx + 1) begin
            r[idx] = i_iobufs[idx].i();
        end
        return r;
    endmethod

    interface io = map(get_io, i_iobufs);

endmodule


endpackage
