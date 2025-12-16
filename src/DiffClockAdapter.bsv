package DiffClockAdapter;

import Clocks :: *;
import DefaultValue :: *;

import IBUFDS :: *;

function m#(ifc) wrap_diff_clk(function m#(ifc) mkM(), Clock clk_p, Clock clk_n) provisos(IsModule#(m, __c));
    return module#(ifc);
        let ibufds <- mkIBUFDSClock(defaultValue, clk_p, clk_n);
        let rst_sync <- mkSyncResetFromCR(2, ibufds);
        let i <- mkM(clocked_by ibufds, reset_by rst_sync);
        return i;
    endmodule;
endfunction

endpackage