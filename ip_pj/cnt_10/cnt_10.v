// IP: 十進カウンタ回路
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module counter(CLK, RES, Q);

input CLK, RES;
output [3:0]Q;

wire CLK, RES;
reg [3:0]Q;

always @(posedge CLK or negedge RES)
    if(RES ==1'b0)
        Q = 4'd0;
    else if(Q == 4'd9)
        Q = 4'd0;
    else
        Q = Q + 4'd1;

endmodule