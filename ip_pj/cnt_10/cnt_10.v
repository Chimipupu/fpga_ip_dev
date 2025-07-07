// IP: 十進カウンタ回路
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module counter(
        input CLK,
        input RES,
        output reg [3:0] Q
    );

    always @(posedge CLK or negedge RES) begin
        // リセット or 4bitの最大9 = 出力０
        if (RES == 1'b0 || Q == 4'd9)
            Q <= 4'd0;
        else
            Q <= Q + 4'd1;
    end

endmodule