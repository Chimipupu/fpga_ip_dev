// IP: 十進カウンタ回路 テストベンチ
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module counter_test;

reg CLK, RES;
wire [3:0] Q;

counter i0(CLK, RES, Q);

always #5 CLK = ~CLK;

initial begin
        CLK = 0;
        RES = 0;
#23     RES = 1;
#150    $finish;
end

initial begin
        $monitor("CLK=%d, RES=%d, Q=%d", CLK, RES, Q);
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_test);
end

endmodule