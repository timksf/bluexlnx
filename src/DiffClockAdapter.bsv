package DiffClockAdapter;

import Clocks :: *;
import DefaultValue :: *;

import IBUFDS :: *;
import BUFG :: *;

interface DiffClockAdapter_ifc#(type device_ifc);
    interface Clock clk;
    interface Reset rst;
    interface device_ifc device;
endinterface

//exports the reset so synthesized callers can preserve method reset associations and bsc does not complain
function m#(DiffClockAdapter_ifc#(ifc)) wrap_diff_clk_with_reset(function m#(ifc) mkM(), Clock clk_p, Clock clk_n) provisos(IsModule#(m, __c));
    return module#(DiffClockAdapter_ifc#(ifc));
        let i_ibufds <- mkIBUFDSClock(defaultValue, clk_p, clk_n);
        let sys_clk  <- mkBUFGClock(i_ibufds);
        let sys_rst  <- mkAsyncResetFromCR(2, sys_clk);
        let wrapped  <- mkM(clocked_by sys_clk, reset_by sys_rst);

        interface clk = sys_clk;
        interface rst = sys_rst;
        interface device = wrapped;
    endmodule;
endfunction

//convenience wrapper that drops clock and reset from the interface
function m#(ifc) wrap_diff_clk(function m#(ifc) mkM(), Clock clk_p, Clock clk_n) provisos(IsModule#(m, __c));
    return module#(ifc);
        let wrapped <- wrap_diff_clk_with_reset(mkM, clk_p, clk_n);
        return wrapped.device;
    endmodule;
endfunction

endpackage
