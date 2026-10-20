package PLLE2_ADV;

import Clocks :: *;
import DefaultValue :: *;

typedef struct {
    String   p_BANDWIDTH;
    Integer  p_CLKFBOUT_MULT;
    Real     p_CLKFBOUT_PHASE;
    Real     p_CLKIN1_PERIOD;
    Real     p_CLKIN2_PERIOD;
    Integer  p_CLKOUT0_DIVIDE;
    Real     p_CLKOUT0_DUTY_CYCLE;
    Real     p_CLKOUT0_PHASE;
    Integer  p_CLKOUT1_DIVIDE;
    Real     p_CLKOUT1_DUTY_CYCLE;
    Real     p_CLKOUT1_PHASE;
    Integer  p_CLKOUT2_DIVIDE;
    Real     p_CLKOUT2_DUTY_CYCLE;
    Real     p_CLKOUT2_PHASE;
    Integer  p_CLKOUT3_DIVIDE;
    Real     p_CLKOUT3_DUTY_CYCLE;
    Real     p_CLKOUT3_PHASE;
    Integer  p_CLKOUT4_DIVIDE;
    Real     p_CLKOUT4_DUTY_CYCLE;
    Real     p_CLKOUT4_PHASE;
    Integer  p_CLKOUT5_DIVIDE;
    Real     p_CLKOUT5_DUTY_CYCLE;
    Real     p_CLKOUT5_PHASE;
    String   p_COMPENSATION;
    Integer  p_DIVCLK_DIVIDE;
    Bit#(1)  p_IS_CLKINSEL_INVERTED;
    Bit#(1)  p_IS_PWRDWN_INVERTED;
    Bit#(1)  p_IS_RST_INVERTED;
    Real     p_REF_JITTER1;
    Real     p_REF_JITTER2;
    String   p_STARTUP_WAIT;
} PLLE2_ADV_Config;

(* always_enabled *)
interface PLLE2_ADV_ifc;
    interface Clock clkout0;
    interface Clock clkout1;
    interface Clock clkout2;
    interface Clock clkout3;
    interface Clock clkout4;
    interface Clock clkout5;
    interface Clock clkfbout;

    method Action clkinsel(Bit#(1) i);
    method Action pwrdwn(Bit#(1) i);
    method Action daddr(Bit#(7) i);
    method Action den(Bit#(1) i);
    method Action d_i(Bit#(16) i);
    method Action dwe(Bit#(1) i);

    method Bit#(16) d_o();
    method Bit#(1) drdy();
    method Bit#(1) locked();
endinterface

import "BVI" PLLE2_ADV =
module vMkPLLE2_ADV#(PLLE2_ADV_Config cfg, Clock clkin1, Clock clkin2, Clock clkfbin, Clock dclk)(PLLE2_ADV_ifc);
    parameter BANDWIDTH                = cfg.p_BANDWIDTH;
    parameter CLKFBOUT_MULT            = cfg.p_CLKFBOUT_MULT;
    parameter CLKFBOUT_PHASE           = cfg.p_CLKFBOUT_PHASE;
    parameter CLKIN1_PERIOD            = cfg.p_CLKIN1_PERIOD;
    parameter CLKIN2_PERIOD            = cfg.p_CLKIN2_PERIOD;
    parameter CLKOUT0_DIVIDE           = cfg.p_CLKOUT0_DIVIDE;
    parameter CLKOUT0_DUTY_CYCLE       = cfg.p_CLKOUT0_DUTY_CYCLE;
    parameter CLKOUT0_PHASE            = cfg.p_CLKOUT0_PHASE;
    parameter CLKOUT1_DIVIDE           = cfg.p_CLKOUT1_DIVIDE;
    parameter CLKOUT1_DUTY_CYCLE       = cfg.p_CLKOUT1_DUTY_CYCLE;
    parameter CLKOUT1_PHASE            = cfg.p_CLKOUT1_PHASE;
    parameter CLKOUT2_DIVIDE           = cfg.p_CLKOUT2_DIVIDE;
    parameter CLKOUT2_DUTY_CYCLE       = cfg.p_CLKOUT2_DUTY_CYCLE;
    parameter CLKOUT2_PHASE            = cfg.p_CLKOUT2_PHASE;
    parameter CLKOUT3_DIVIDE           = cfg.p_CLKOUT3_DIVIDE;
    parameter CLKOUT3_DUTY_CYCLE       = cfg.p_CLKOUT3_DUTY_CYCLE;
    parameter CLKOUT3_PHASE            = cfg.p_CLKOUT3_PHASE;
    parameter CLKOUT4_DIVIDE           = cfg.p_CLKOUT4_DIVIDE;
    parameter CLKOUT4_DUTY_CYCLE       = cfg.p_CLKOUT4_DUTY_CYCLE;
    parameter CLKOUT4_PHASE            = cfg.p_CLKOUT4_PHASE;
    parameter CLKOUT5_DIVIDE           = cfg.p_CLKOUT5_DIVIDE;
    parameter CLKOUT5_DUTY_CYCLE       = cfg.p_CLKOUT5_DUTY_CYCLE;
    parameter CLKOUT5_PHASE            = cfg.p_CLKOUT5_PHASE;
    parameter COMPENSATION             = cfg.p_COMPENSATION;
    parameter DIVCLK_DIVIDE            = cfg.p_DIVCLK_DIVIDE;
    parameter IS_CLKINSEL_INVERTED     = cfg.p_IS_CLKINSEL_INVERTED;
    parameter IS_PWRDWN_INVERTED       = cfg.p_IS_PWRDWN_INVERTED;
    parameter IS_RST_INVERTED          = cfg.p_IS_RST_INVERTED;
    parameter REF_JITTER1              = cfg.p_REF_JITTER1;
    parameter REF_JITTER2              = cfg.p_REF_JITTER2;
    parameter STARTUP_WAIT             = cfg.p_STARTUP_WAIT;

    default_clock control_clk();
    default_reset rst(RST);

    input_clock clkin1(CLKIN1, (*unused*) clkin1_gate) = clkin1;
    input_clock clkin2(CLKIN2, (*unused*) clkin2_gate) = clkin2;
    input_clock clkfbin(CLKFBIN, (*unused*) clkfbin_gate) = clkfbin;
    input_clock dclk(DCLK, (*unused*) dclk_gate) = dclk;

    output_clock clkout0(CLKOUT0);
    output_clock clkout1(CLKOUT1);
    output_clock clkout2(CLKOUT2);
    output_clock clkout3(CLKOUT3);
    output_clock clkout4(CLKOUT4);
    output_clock clkout5(CLKOUT5);
    output_clock clkfbout(CLKFBOUT);

    method clkinsel(CLKINSEL) enable((*inhigh*) EN_clkinsel) clocked_by(control_clk) reset_by(no_reset);
    method pwrdwn(PWRDWN) enable((*inhigh*) EN_pwrdwn) clocked_by(control_clk) reset_by(no_reset);
    method daddr(DADDR) enable((*inhigh*) EN_daddr) clocked_by(dclk) reset_by(no_reset);
    method den(DEN) enable((*inhigh*) EN_den) clocked_by(dclk) reset_by(no_reset);
    method d_i(DI) enable((*inhigh*) EN_d_i) clocked_by(dclk) reset_by(no_reset);
    method dwe(DWE) enable((*inhigh*) EN_dwe) clocked_by(dclk) reset_by(no_reset);

    method (* reg *) DO d_o() clocked_by(dclk) reset_by(no_reset);
    method (* reg *) DRDY drdy() clocked_by(dclk) reset_by(no_reset);
    method (* reg *) LOCKED locked() clocked_by(no_clock) reset_by(no_reset);

    schedule (clkinsel, pwrdwn, daddr, den, d_i, dwe, d_o, drdy, locked) CF (clkinsel, pwrdwn, daddr, den, d_i, dwe, d_o, drdy, locked);
endmodule

module mkPLLE2_ADV#(PLLE2_ADV_Config cfg, Clock clkin1, Clock clkin2, Clock clkfbin, Clock dclk)(PLLE2_ADV_ifc);
    let i_pll <- vMkPLLE2_ADV(cfg, clkin1, clkin2, clkfbin, dclk);
    return i_pll;
endmodule

instance DefaultValue#(PLLE2_ADV_Config);
    defaultValue = PLLE2_ADV_Config {
        p_BANDWIDTH: "OPTIMIZED",
        p_CLKFBOUT_MULT: 5,
        p_CLKFBOUT_PHASE: 0.0,
        p_CLKIN1_PERIOD: 0.0,
        p_CLKIN2_PERIOD: 0.0,
        p_CLKOUT0_DIVIDE: 1,
        p_CLKOUT0_DUTY_CYCLE: 0.5,
        p_CLKOUT0_PHASE: 0.0,
        p_CLKOUT1_DIVIDE: 1,
        p_CLKOUT1_DUTY_CYCLE: 0.5,
        p_CLKOUT1_PHASE: 0.0,
        p_CLKOUT2_DIVIDE: 1,
        p_CLKOUT2_DUTY_CYCLE: 0.5,
        p_CLKOUT2_PHASE: 0.0,
        p_CLKOUT3_DIVIDE: 1,
        p_CLKOUT3_DUTY_CYCLE: 0.5,
        p_CLKOUT3_PHASE: 0.0,
        p_CLKOUT4_DIVIDE: 1,
        p_CLKOUT4_DUTY_CYCLE: 0.5,
        p_CLKOUT4_PHASE: 0.0,
        p_CLKOUT5_DIVIDE: 1,
        p_CLKOUT5_DUTY_CYCLE: 0.5,
        p_CLKOUT5_PHASE: 0.0,
        p_COMPENSATION: "ZHOLD",
        p_DIVCLK_DIVIDE: 1,
        p_IS_CLKINSEL_INVERTED: 0,
        p_IS_PWRDWN_INVERTED: 0,
        p_IS_RST_INVERTED: 0,
        p_REF_JITTER1: 0.01,
        p_REF_JITTER2: 0.01,
        p_STARTUP_WAIT: "FALSE"
    };
endinstance

endpackage
